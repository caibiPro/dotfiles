# Common environment variables
typeset -U path PATH
[[ -d "$HOME/bin" ]] && path=("$HOME/bin" $path)
[[ -d "$HOME/.local/bin" ]] && path=("$HOME/.local/bin" $path)

# OS-specific configurations
if [[ "$OSTYPE" =~ ^darwin ]]; then
    # Homebrew (should be early in PATH)
    if [[ -x /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -x /usr/local/bin/brew ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi

    # MacPorts (if available, prepend to PATH)
    [[ -d /opt/local/bin ]] && path=(/opt/local/bin /opt/local/sbin $path)

    # Prefer Homebrew Python over macOS Command Line Tools Python.
    local _py=("${HOMEBREW_PREFIX:-/opt/homebrew}"/opt/python@3.*/libexec/bin(nNOn))
    (( $#_py )) && path=("$_py[1]" $path)
    unset _py

    # Java configuration
    if [[ -x /usr/libexec/java_home ]]; then
        local _java_home
        _java_home="$(/usr/libexec/java_home -v 17 2>/dev/null || /usr/libexec/java_home -v 21 2>/dev/null || /usr/libexec/java_home 2>/dev/null)"
        [[ -n "$_java_home" ]] && export JAVA_HOME="$_java_home"
        unset _java_home
    fi
    [[ -n "$JAVA_HOME" && -d "$JAVA_HOME/bin" ]] && path=(
        "$JAVA_HOME/bin"
        $path
    )

elif [[ "$OSTYPE" =~ ^linux ]]; then
    # Java configuration
    if [[ -d /usr/lib/jvm/java-11-openjdk-amd64/bin ]]; then
        export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
        path=(
            "$JAVA_HOME/bin"
            $path
        )
    fi

fi

# Cargo environment
if [ -f "$HOME/.cargo/env" ]; then
    export CARGO_HOME="$HOME/.cargo"
    source "$CARGO_HOME/env"
fi

# Shared environment
if [ -f "$HOME/.dotfiles/env/environment.sh" ]; then
    source "$HOME/.dotfiles/env/environment.sh"
fi

# Private local environment variables
if [ -f "$HOME/.dotfiles/env/private.local.sh" ]; then
    source "$HOME/.dotfiles/env/private.local.sh"
fi
