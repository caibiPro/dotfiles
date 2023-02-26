# Locale.
export LANG="zh_CN.UTF-8"
export LANGUAGE="zh_CN.UTF-8"

# Term.
export TERM="xterm-256color"

# Default Editor.
export EDITOR="vim"

# Default Pager.
export PAGER="less"

# Less.
export LESS="--RAW-CONTROL-CHARS"
export LESS_TERMCAP_mb=$'\e[1;31m'     # Start blinking
export LESS_TERMCAP_md=$'\e[1;34m'     # Start bold mode
export LESS_TERMCAP_me=$'\e[0m'        # End all mode
export LESS_TERMCAP_so=$'\e[38;5;215m' # Start standout mode
export LESS_TERMCAP_se=$'\e[0m'        # End standout mode
export LESS_TERMCAP_us=$'\e[4;35m'     # Start underline
export LESS_TERMCAP_ue=$'\e[0m'        # End underline

# History.
HISTSIZE=1048576
HISTFILE="$HOME/.zsh_history"
SAVEHIST=$HISTSIZE
setopt appendhistory
setopt incappendhistory
setopt extendedhistory

# Use vim style line editing in zsh
bindkey -v

# Movement
bindkey -a 'gg' beginning-of-buffer-or-history
bindkey -a 'G' end-of-buffer-or-history

# Undo
bindkey -a 'u' undo
bindkey -a '^R' redo

# Filtered history search
# bindkey '^P' history-search-backward
# bindkey '^N' history-search-forward
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
