# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ~='cd ~'

# Easy report
if command -v eza >/dev/null 2>&1; then
	alias ls='eza --group-directories-first --icons=auto'
	alias l='eza -lg --group-directories-first --icons=auto'
	alias ll='eza -lag --group-directories-first --icons=auto'
else
	alias ls='ls -1h -G'
	alias l='ls -l'
	alias ll='ls -lA'
fi
alias dud='du -d 1 -h'
alias duf='du -sh *'
if command -v fd >/dev/null 2>&1; then
	alias fdir='fd --type d'
	alias ff='fd --type f'
elif command -v fdfind >/dev/null 2>&1; then
	alias fdir='fdfind --type d'
	alias ff='fdfind --type f'
else
	alias fdir='find . -type d -name'
	alias ff='find . -type f -name'
fi
alias h='history'
if command -v rg >/dev/null 2>&1; then
	alias sgrep='rg -n -C 5'
else
	alias sgrep='grep -R -n -H -C 5'
fi
alias cp='cp -iv'
alias mv='mv -iv'
alias ln='ln -iv'
alias mkdir='mkdir -v'
alias rm='rm -i'

# Bookmarks
alias dl='cd ~/Downloads && ll'
alias doc='cd ~/Documents && ll'

# Shortcuts
alias c='clear'
if command -v bat >/dev/null 2>&1; then
	alias cat='bat --paging=never'
elif command -v batcat >/dev/null 2>&1; then
	alias cat='batcat --paging=never'
fi
alias e='exit'

# Developer shortcuts
alias python='python3'
alias v='nvim'

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec ${SHELL} -l"

# Typos
alias :q='exit'
alias help='man'
alias quit='exit'
