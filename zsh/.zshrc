# Path to your dotfiles
export DOTFILES="$HOME/.dotfiles"
typeset -U fpath FPATH

# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CACHE_DIR="$HOME/.cache/oh-my-zsh"

# Oh My Zsh update behavior
zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 14
zstyle ':omz:update' verbose minimal

# Disable marking untracked files under VCS as dirty
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Completion behavior
COMPLETION_WAITING_DOTS="true"

# Plugin tuning
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

# ZSH theme (using pure prompt)
ZSH_THEME=""

# Plugins configuration
plugins=(
  git
  zsh-autosuggestions
  fast-syntax-highlighting
  history-substring-search
)

# Add extra completion directories before Oh My Zsh runs compinit.
fpath=($HOME/.docker/completions $fpath)

# Load Oh My Zsh
source "$ZSH/oh-my-zsh.sh"

# Shared environment and shell helpers
source "$DOTFILES/env/environment.sh"
source "$DOTFILES/env/aliases.sh"
source "$DOTFILES/env/functions.sh"
source "$DOTFILES/zsh/history.zsh"
source "$DOTFILES/zsh/keybindings.zsh"

# Pure prompt configuration
fpath+=($ZSH_CUSTOM/themes/pure)
autoload -U promptinit
promptinit

# Pure prompt customization
PURE_CMD_MAX_EXEC_TIME=10
PURE_PROMPT_SYMBOL='➜'
PURE_PROMPT_VICMD_SYMBOL=':'
zstyle :prompt:pure:path color cyan
zstyle :prompt:pure:git:stash show yes
prompt pure

# Additional ZSH options
setopt AUTO_CD                # 'directory' is equivalent to 'cd directory'
setopt PROMPT_SUBST           # Allow prompt substitution

# fzf / zoxide integration
if [[ -t 0 ]]; then
  if command -v fzf >/dev/null 2>&1; then
    source <(fzf --zsh)
  fi

  if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
  fi
fi

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
