# Create a new directory and enter it
mkd() {
	mkdir -p "${1:?}" && cd "$1"
}
