# Common environment variables
typeset -U path PATH
[[ -d "$HOME/bin" ]] && path=("$HOME/bin" $path)
[[ -d "$HOME/.local/bin" ]] && path=("$HOME/.local/bin" $path)

# OS-specific configurations
if [[ "$OSTYPE" =~ ^darwin ]]; then
    # Homebrew (should be early in PATH)
    if [[ -x /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    # Prefer Homebrew Python over macOS Command Line Tools Python.
    [[ -d /opt/homebrew/opt/python@3.13/libexec/bin ]] && path=(
        /opt/homebrew/opt/python@3.13/libexec/bin
        $path
    )

    # Java configuration
    if [[ -x /usr/libexec/java_home ]]; then
        export JAVA_HOME="$(/usr/libexec/java_home -v 21 2>/dev/null)"
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
