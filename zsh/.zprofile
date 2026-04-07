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

    # MacPorts is only preferred on older macOS where bootstrap uses it.
    _macos_ver="$(sw_vers -productVersion 2>/dev/null | cut -d. -f1)"
    if [[ -n "$_macos_ver" && "$_macos_ver" -lt 14 && -x /opt/local/bin/port ]]; then
        path=(/opt/local/bin /opt/local/sbin $path)
    fi
    unset _macos_ver

    # Prefer Homebrew Python over macOS Command Line Tools Python.
    local _py=("${HOMEBREW_PREFIX:-/opt/homebrew}"/opt/python@3.*/libexec/bin(nNOn))
    (( $#_py )) && path=("$_py[1]" $path)
    unset _py

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

# Private local environment variables win over shared defaults and can set JAVA_HOME.
if [ -f "$HOME/.dotfiles/env/private.local.sh" ]; then
    source "$HOME/.dotfiles/env/private.local.sh"
fi

# Java configuration — auto-detect; switch with jdk() at runtime
if [[ -z "$JAVA_HOME" ]]; then
    if [[ -x /usr/libexec/java_home ]]; then
        # macOS: system default (highest installed version)
        JAVA_HOME="$(/usr/libexec/java_home 2>/dev/null)"
    elif [[ -d /usr/lib/jvm ]]; then
        # Linux: pick first available JDK
        local _d
        for _d in /usr/lib/jvm/java-*-openjdk-*(N); do
            [[ -x "$_d/bin/java" ]] && JAVA_HOME="$_d" && break
        done
        unset _d
    fi
fi
[[ -n "$JAVA_HOME" && -d "$JAVA_HOME/bin" ]] && {
    export JAVA_HOME
    path=("$JAVA_HOME/bin" $path)
}
