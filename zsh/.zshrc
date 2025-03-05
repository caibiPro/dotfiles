# Path to your dotfiles
export DOTFILES="$HOME/.dotfiles"

# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# History configuration
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history
HIST_STAMPS="yyyy-mm-dd"

# Disable marking untracked files under VCS as dirty
DISABLE_UNTRACKED_FILES_DIRTY="true"

# ZSH theme (using pure prompt)
ZSH_THEME=""

# Plugins configuration
plugins=(
  git
  autojump
  colored-man-pages
  zsh-completions
  zsh-autosuggestions
  fast-syntax-highlighting
  history-substring-search
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Load custom configuration files
source $DOTFILES/env/aliases.sh
source $DOTFILES/env/functions.sh
source $DOTFILES/env/inputrc.sh

# Pure prompt configuration
fpath+=($ZSH_CUSTOM/themes/pure)
autoload -U promptinit
promptinit

# Pure prompt customization
PURE_PROMPT_SYMBOL='➜'
PURE_PROMPT_VICMD_SYMBOL=':'
zstyle :prompt:pure:path color cyan
zstyle :prompt:pure:git:stash show yes
prompt pure

# Additional ZSH options
setopt AUTO_CD                # 'directory' is equivalent to 'cd directory'
setopt AUTO_PUSHD             # Makes cd push each old directory onto the stack
setopt PUSHD_IGNORE_DUPS      # Don't push duplicate directories onto the stack
setopt EXTENDED_HISTORY       # Save timestamps in history
setopt SHARE_HISTORY          # Share history between sessions
setopt HIST_IGNORE_DUPS       # Don't record duplicate commands
setopt HIST_IGNORE_SPACE      # Don't record commands starting with a space
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks from history
setopt HIST_VERIFY            # Don't execute immediately upon history expansion
setopt PROMPT_SUBST           # Allow prompt substitution
