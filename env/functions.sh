# Create a new directory and enter it
mkd() {
	mkdir -p "${1:?}" && cd "$1"
}

# Switch JDK version: jdk <version> (macOS only)
jdk() {
	[[ "$(uname -s)" != "Darwin" ]] && { echo "jdk: macOS only"; return 1; }
	local ver="${1:?Usage: jdk <version>}"
	local home
	home="$(/usr/libexec/java_home -v "$ver" 2>/dev/null)"
	if [[ -z "$home" ]]; then
		echo "JDK $ver not found. Installed versions:"
		/usr/libexec/java_home -V 2>&1 | tail -n +2
		return 1
	fi
	export JAVA_HOME="$home"
	path=("$JAVA_HOME/bin" ${path:#"$JAVA_HOME/bin"})
	export PATH
	rehash 2>/dev/null || true
	echo "JAVA_HOME -> $JAVA_HOME"
	java -version
}
