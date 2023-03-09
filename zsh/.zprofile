if [[ "$OSTYPE" =~ ^darwin ]]; then
    # MacOS ruby PATH
    export PATH="$HOME/.ruby/bin:$PATH"
    # MacOS add Homebrew PATH
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ "$OSTYPE" =~ ^linux ]]; then
    # Linux add GEM PATH
    export GEM_HOME="$HOME/.gems"
    export PATH="$HOME/.gems/bin:$PATH"
fi

# Cargo Env PATH added
. "$HOME/.cargo/env"
