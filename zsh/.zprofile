if [[ "$OSTYPE" =~ ^darwin ]]; then
    # JDK
    export JAVA_HOME="$HOME/Library/Java/JavaVirtualMachines/corretto-17.0.13/Contents/Home"
    # TOMCAT
    export CATALINA_HOME="$HOME/Documents/tools/tomcat/apache-tomcat-9.0.78"
    # Maven
    export PATH="$HOME/Documents/tools/maven/apache-maven-3.9.4/bin:$PATH"
    # Android SDK Tools
    export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"
    export PATH="$HOME/Library/Android/sdk/build-tools/34.0.0:$PATH"
    # MacOS ruby PATH
    export PATH="$HOME/.ruby/bin:$PATH"
    export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
    export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
    export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"
    # MacOS add Homebrew PATH
    eval "$(/opt/homebrew/bin/brew shellenv)"
    # Ruby
    export PATH="/opt/homebrew/lib/ruby/gems/3.3.0/bin:$PATH"
elif [[ "$OSTYPE" =~ ^linux ]]; then
    # Linux add GEM PATH
    export GEM_HOME="$HOME/.gems"
    export PATH="$HOME/.gems/bin:$PATH"
    # JDK
    export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
    #TOMCAT
    export CATALINA_HOME="$HOME/tools/tomcat/apache-tomcat-9.0.78"
    #Maven
    export PATH="$HOME/tools/maven/apache-maven-3.9.4/bin:$PATH"
fi

# Cargo Env PATH added
. "$HOME/.cargo/env"
