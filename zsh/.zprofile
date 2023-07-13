if [[ "$OSTYPE" =~ ^darwin ]]; then
    # JDK
    export JAVA_HOME="$HOME/Library/Java/JavaVirtualMachines/openjdk-20.0.1/Contents/Home"
    # TOMCAT
    export CATALINA_HOME="$HOME/Documents/study/web/apache-tomcat-10.1.11"
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
