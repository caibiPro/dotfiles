#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Common CLI packages shared across all platforms.
# Format: "brew_name:apt_name:dnf_name:port_name"
# Omit a field to reuse brew_name.
COMMON_PACKAGES=(
  bat
  fd:fd-find:fd-find:
  fzf
  git
  jq
  neovim
  node:nodejs:nodejs:nodejs22
  npm:npm:npm:npm10
  python@3.13:python3:python3:python313
  ripgrep
  tealdeer
  tmux
  yq
  zoxide
)

# Development runtimes skipped by --server (matched by brew_name).
DEV_ONLY_PACKAGES=(node npm python@3.13)

# Set by --server: headless Linux host, no clipboard tool or dev runtimes.
SERVER_MODE=0

# Extract platform-specific package name.
# Usage: pkg_name "entry" <field_index>  (0=brew, 1=apt, 2=dnf, 3=port)
pkg_name() {
  local entry="$1" idx="$2"
  local name
  name="$(echo "$entry" | cut -d: -f$((idx + 1)))"
  [[ -z "$name" ]] && name="$(echo "$entry" | cut -d: -f1)"
  echo "$name"
}

log() {
  printf '[bootstrap] %s\n' "$*"
}

have() {
  command -v "$1" >/dev/null 2>&1
}

# Print the apt/dnf package list for this run.
linux_package_entries() {
  local entry dev
  for entry in "${COMMON_PACKAGES[@]}"; do
    if [[ "$SERVER_MODE" -eq 1 ]]; then
      for dev in "${DEV_ONLY_PACKAGES[@]}"; do
        [[ "$(pkg_name "$entry" 0)" == "$dev" ]] && continue 2
      done
    fi
    echo "$entry"
  done
}

# nvim/init.lua needs 0.8+; 0.10+ also falls back to OSC 52 for the clipboard over SSH.
neovim_is_recent() {
  have nvim || return 1
  local ver major minor
  ver="$(nvim --version | head -n1 | grep -oE '[0-9]+\.[0-9]+' | head -n1)"
  major="${ver%%.*}"
  minor="${ver#*.}"
  [[ "$major" =~ ^[0-9]+$ && "$minor" =~ ^[0-9]+$ ]] || return 1
  (( major > 0 || minor >= 10 ))
}

# Distro repos such as Ubuntu 22.04 ship Neovim 0.6; install the upstream release instead.
ensure_recent_neovim() {
  if neovim_is_recent; then
    return
  fi

  local arch
  case "$(uname -m)" in
    x86_64) arch=x86_64 ;;
    aarch64 | arm64) arch=arm64 ;;
    *)
      log "no Neovim release for $(uname -m); keeping the distro package"
      return
      ;;
  esac

  log "installing Neovim release to /opt/nvim"
  local tmp
  tmp="$(mktemp -d)"
  curl -fsSL "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${arch}.tar.gz" |
    tar -xz -C "$tmp"
  sudo rm -rf /opt/nvim
  sudo mv "$tmp/nvim-linux-${arch}" /opt/nvim
  sudo ln -sfn /opt/nvim/bin/nvim /usr/local/bin/nvim
  rm -rf "$tmp"
}

install_oh_my_zsh() {
  if [[ -d "$HOME/.oh-my-zsh" ]]; then
    log "oh-my-zsh already installed"
    return
  fi

  log "installing oh-my-zsh"
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

install_or_update_git_repo() {
  local repo_url="$1"
  local target_dir="$2"

  if [[ -d "$target_dir/.git" ]]; then
    log "updating $(basename "$target_dir")"
    git -C "$target_dir" pull --ff-only
  else
    log "cloning $(basename "$target_dir")"
    git clone --depth 1 "$repo_url" "$target_dir"
  fi
}

install_zsh_extras() {
  local zsh_custom="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

  install_or_update_git_repo \
    "https://github.com/zsh-users/zsh-autosuggestions" \
    "$zsh_custom/plugins/zsh-autosuggestions"
  install_or_update_git_repo \
    "https://github.com/zdharma-continuum/fast-syntax-highlighting.git" \
    "$zsh_custom/plugins/fast-syntax-highlighting"
  install_or_update_git_repo \
    "https://github.com/sindresorhus/pure.git" \
    "$zsh_custom/themes/pure"
}

ensure_homebrew() {
  if have brew; then
    return
  fi

  log "installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
}

install_homebrew_bundle() {
  log "installing packages from Brewfile"
  brew bundle --file "$DOTFILES_DIR/Brewfile"
}

install_homebrew_packages() {
  local missing=()
  for entry in "${COMMON_PACKAGES[@]}"; do
    local name
    name="$(pkg_name "$entry" 0)"
    if ! brew list "$name" &>/dev/null; then
      missing+=("$name")
    fi
  done

  if [[ ${#missing[@]} -eq 0 ]]; then
    log "all Homebrew packages already installed"
    return
  fi

  log "installing Homebrew packages: ${missing[*]}"
  brew install "${missing[@]}"
}

install_macports_packages() {
  local missing=()
  local skipped=()
  for entry in "${COMMON_PACKAGES[@]}"; do
    local name
    name="$(pkg_name "$entry" 3)"
    if ! port info "$name" >/dev/null 2>&1; then
      skipped+=("$name")
    elif ! port -q installed "$name" 2>/dev/null | grep -q active; then
      missing+=("$name")
    fi
  done

  if [[ ${#missing[@]} -eq 0 ]]; then
    log "all MacPorts packages already installed"
    if [[ ${#skipped[@]} -gt 0 ]]; then
      log "skipped (not in MacPorts): ${skipped[*]}"
    fi
    return
  fi

  log "installing MacPorts packages: ${missing[*]}"
  sudo port install "${missing[@]}"

  if [[ ${#skipped[@]} -gt 0 ]]; then
    log "skipped (not in MacPorts): ${skipped[*]}"
  fi
}

install_linux_packages() {
  local skipped=()
  local entries=()
  local base_pkgs=(zsh)
  mapfile -t entries < <(linux_package_entries)
  # A headless server has no X display for xclip; tmux and nvim use OSC 52 instead.
  [[ "$SERVER_MODE" -eq 1 ]] || base_pkgs+=(xclip)

  if have apt-get; then
    log "installing Linux packages with apt-get"
    sudo apt-get update
    local pkgs=("${base_pkgs[@]}")
    for entry in "${entries[@]}"; do
      local name
      name="$(pkg_name "$entry" 1)"
      if apt-cache show "$name" >/dev/null 2>&1; then
        pkgs+=("$name")
      else
        skipped+=("$name")
      fi
    done
    sudo apt-get install -y "${pkgs[@]}"
  elif have dnf; then
    log "installing Linux packages with dnf"
    local pkgs=("${base_pkgs[@]}")
    for entry in "${entries[@]}"; do
      local name
      name="$(pkg_name "$entry" 2)"
      if dnf info "$name" >/dev/null 2>&1; then
        pkgs+=("$name")
      else
        skipped+=("$name")
      fi
    done
    sudo dnf install -y "${pkgs[@]}"
  else
    log "no supported package manager detected; skipping package installation"
  fi

  if [[ ${#skipped[@]} -gt 0 ]]; then
    log "skipped (not in repo): ${skipped[*]}"
  fi
}

usage() {
  cat <<'EOF'
Usage: bootstrap.sh [--server]

  --server  Headless Linux host: skip xclip and the node, npm, and python packages.
EOF
}

main() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --server) SERVER_MODE=1 ;;
      -h | --help)
        usage
        return
        ;;
      *)
        usage >&2
        return 1
        ;;
    esac
    shift
  done

  case "$(uname -s)" in
    Darwin)
      local macos_ver
      macos_ver="$(sw_vers -productVersion | cut -d. -f1)"
      ensure_homebrew
      if [[ "$macos_ver" -lt 14 ]] && have port; then
        install_macports_packages
      else
        install_homebrew_packages
      fi
      install_homebrew_bundle
      ;;
    Linux)
      install_linux_packages
      ensure_recent_neovim
      ;;
    *)
      log "unsupported platform: $(uname -s)"
      ;;
  esac

  install_oh_my_zsh
  install_zsh_extras
  "$DOTFILES_DIR/scripts/sync.sh"

  # Oh My Zsh is installed with CHSH=no, so the login shell is not changed for you.
  if [[ "$(basename "${SHELL:-}")" != "zsh" ]] && have zsh; then
    log "login shell is ${SHELL:-unknown}; switch with: chsh -s $(command -v zsh)"
  fi

  log "bootstrap complete"
}

main "$@"
