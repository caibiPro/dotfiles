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
# Off macOS (e.g. over SSH) bat may be too old to detect a light terminal, or sit
# behind tmux, which does not report the background. ansi follows the terminal palette.
if [ "$(uname -s)" != "Darwin" ] && [ -z "${BAT_THEME:-}" ]; then
	export BAT_THEME=ansi
fi
# Debian/Ubuntu install fd as fdfind
if ! command -v fd >/dev/null 2>&1 && command -v fdfind >/dev/null 2>&1; then
	alias fd='fdfind'
fi

# Developer shortcuts
alias gst='git status'

# Docker
alias dps="docker ps --format $'Name: {{.Names}}\nImage: {{.Image}}\nStatus: {{.Status}}\nPorts: {{.Ports}}\nCreated: {{.CreatedAt}}\n----------------------------------------'"

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec ${SHELL} -l"

# Typos
alias :q='exit'
