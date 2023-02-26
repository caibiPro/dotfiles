# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH Path to your dotfiles.
export DOTFILES="$HOME/.dotfiles"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Themes.
ZSH_THEME="steeef" # set by `omz`

# Case-sensitive completion.
CASE_SENSITIVE="true"

# Disable marking untracked files under VCS as dirty.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# History.
HIST_STAMPS="yyyy-mm-dd"

# Plugins.
# Plugins to load
plugins=(
    git
    autojump
    colored-man-pages
    zsh-completions
    zsh-autosuggestions
    fast-syntax-highlighting
    history-substring-search
)

# Oh My Zsh.
source $ZSH/oh-my-zsh.sh

# Aliases.
source $DOTFILES/env/aliases.sh

# Functions
source $DOTFILES/env/functions.sh

# Input editing and Keybindings.
source $DOTFILES/env/inputrc.sh
