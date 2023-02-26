# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias ~='cd ~'

# Easy report
alias ls='ls -1h --color'
alias l='ls -l'
alias ll='ls -lA'
alias lr='ls -R'
alias lf='ls -l | grep "^-"'
alias l.f='ls -ld .* | grep "^-"'
alias ld='ls -l | grep "^d"'
alias l.d='ls -ld .* | grep "^d"'
alias dud='du -d 1 -h'
alias duf='du -sh *'
alias fdir='find . -type d -name'
alias ff='find . -type f -name'
alias h='history'
alias hgrep='history | grep'
alias lgrep='ls -l | grep'
alias lagrep='ls -lA | grep'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,node_modules,tealdeer,Trash,vendor}'
alias cp='cp -iv'
alias mv='mv -iv'
alias ln='ln -iv'
alias mkdir='mkdir -v'
alias rm='rm -i'
alias rmf='rm -rf'

# Bookmarks
alias dl='cd ~/Downloads && ls -lA'
alias doc='cd ~/Documents && ls -lA'

# Shortcuts
alias c='clear'
alias cat='bat'
alias e='exit'

# Developer shortcuts
alias python='python3'

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec ${SHELL} -l"

# Typos
alias :q='exit'
alias help='man'
alias quit='exit'
