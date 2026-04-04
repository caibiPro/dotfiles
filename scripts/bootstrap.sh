#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

log() {
  printf '[bootstrap] %s\n' "$*"
}

have() {
  command -v "$1" >/dev/null 2>&1
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

install_homebrew_bundle() {
  if ! have brew; then
    log "installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi

  log "installing packages from Brewfile"
  brew bundle --file "$DOTFILES_DIR/Brewfile"
}

install_linux_packages() {
  if have apt-get; then
    log "installing Linux packages with apt-get"
    sudo apt-get update
    sudo apt-get install -y \
      bat fd-find fzf git jq neovim ripgrep tmux xclip zoxide zsh
  elif have dnf; then
    log "installing Linux packages with dnf"
    local packages=(
      bat
      fzf
      git
      jq
      neovim
      ripgrep
      tmux
      xclip
      zoxide
      zsh
    )
    if dnf info fd-find >/dev/null 2>&1; then
      packages+=(fd-find)
    elif dnf info fd >/dev/null 2>&1; then
      packages+=(fd)
    fi
    sudo dnf install -y \
      "${packages[@]}"
  else
    log "no supported package manager detected; skipping package installation"
  fi
}

main() {
  case "$(uname -s)" in
    Darwin)
      install_homebrew_bundle
      ;;
    Linux)
      install_linux_packages
      ;;
    *)
      log "unsupported platform: $(uname -s)"
      ;;
  esac

  install_oh_my_zsh
  install_zsh_extras
  "$DOTFILES_DIR/scripts/sync.sh"

  log "bootstrap complete"
}

main "$@"
