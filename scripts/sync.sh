#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backups/$(date +%Y%m%d%H%M%S)"

log() {
  printf '[sync] %s\n' "$*"
}

ensure_parent_dir() {
  mkdir -p "$(dirname "$1")"
}

backup_existing() {
  local target="$1"
  local source="$2"
  local relative_target

  if [[ -L "$target" ]]; then
    local current
    current="$(readlink "$target")"
    if [[ "$current" == "$source" ]]; then
      return
    fi
  fi

  if [[ -e "$target" || -L "$target" ]]; then
    relative_target="${target#$HOME/}"
    ensure_parent_dir "$BACKUP_DIR/$relative_target"
    mv "$target" "$BACKUP_DIR/$relative_target"
    log "backed up $target"
  fi
}

link_path() {
  local source_path="$1"
  local target_path="$2"
  local current_target

  ensure_parent_dir "$target_path"
  if [[ -L "$target_path" ]]; then
    current_target="$(readlink "$target_path")"
    if [[ "$current_target" == "$source_path" ]]; then
      return
    fi
  fi
  backup_existing "$target_path" "$source_path"
  ln -sfn "$source_path" "$target_path"
  log "linked $target_path -> $source_path"
}

main() {
  local mappings=(
    "$DOTFILES_DIR/zsh/.zprofile:$HOME/.zprofile"
    "$DOTFILES_DIR/zsh/.zshrc:$HOME/.zshrc"
    "$DOTFILES_DIR/git/.gitconfig:$HOME/.gitconfig"
    "$DOTFILES_DIR/psql/.psqlrc:$HOME/.psqlrc"
    "$DOTFILES_DIR/tmux/.tmux.conf:$HOME/.tmux.conf"
    "$DOTFILES_DIR/ghostty:$HOME/.config/ghostty"
    "$DOTFILES_DIR/nvim:$HOME/.config/nvim"
  )
  local optional_mappings=(
    "$DOTFILES_DIR/git/.gitconfig.local:$HOME/.gitconfig.local"
  )

  for mapping in "${mappings[@]}"; do
    link_path "${mapping%%:*}" "${mapping#*:}"
  done

  for mapping in "${optional_mappings[@]}"; do
    if [[ -f "${mapping%%:*}" ]]; then
      link_path "${mapping%%:*}" "${mapping#*:}"
    fi
  done

  log "sync complete"
}

main "$@"
