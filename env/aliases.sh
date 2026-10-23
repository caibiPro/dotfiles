# Easy report
if ls --color=auto /dev/null >/dev/null 2>&1; then
	alias ls='ls -1h --color=auto'
	alias l='ls -lh --color=auto'
	alias ll='ls -lAh --color=auto'
else
	alias ls='ls -1h -G'
	alias l='ls -l'
	alias ll='ls -lA'
fi
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -v'
alias rm='rm -i'

# Bookmarks
alias doc='cd ~/Documents && ll'

# Shortcuts
alias c='clear'
if command -v bat >/dev/null 2>&1; then
	alias cat='bat --paging=never'
elif command -v batcat >/dev/null 2>&1; then
	alias cat='batcat --paging=never'
fi

# Developer shortcuts
alias gst='git status'

# Docker
alias dps="docker ps --format $'Name: {{.Names}}\nImage: {{.Image}}\nStatus: {{.Status}}\nPorts: {{.Ports}}\nCreated: {{.CreatedAt}}\n----------------------------------------'"

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec ${SHELL} -l"

# Typos
alias :q='exit'
