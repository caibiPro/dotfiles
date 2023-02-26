# PATH Operation
path_remove() {
	PATH=$(echo -n "$PATH" | awk -v RS=: -v ORS=: "\$0 != \"$1\"" | sed 's/:$//')
}

path_append() {
	path_remove "$1"
	PATH="${PATH:+"$PATH:"}$1"
}

path_prepend() {
	path_remove "$1"
	PATH="$1${PATH:+":$PATH"}"
}

# Clean Debian packages
apt-clean() {
	sudo apt-get clean
	sudo apt-get autoclean
	sudo apt-get autoremove
}

# Create a new directory and enter it
mkd() {
	mkdir -p "$@" && cd "$@"
}

# Print README file
readme() {
	for readme in {readme,README}.{md,MD,markdown,mkd,txt,TXT}; do
		if [[ -f "$readme" ]]; then
			cat "$readme"
		fi
	done
}
