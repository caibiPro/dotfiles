# Shared environment variables for interactive shells.
# Keep this file shell-agnostic when possible.

if [[ -n "${DOTFILES_ENV_LOADED:-}" ]]; then
  return 0
fi
export DOTFILES_ENV_LOADED=1

export LANG="${LANG:-en_US.UTF-8}"
export LANGUAGE="${LANGUAGE:-en_US.UTF-8}"
export EDITOR="nvim"
export VISUAL="nvim"

export PAGER="less"
export LESS="--RAW-CONTROL-CHARS"
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;34m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_so=$'\e[38;5;215m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_us=$'\e[4;35m'
export LESS_TERMCAP_ue=$'\e[0m'
