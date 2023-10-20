if [[ "$OSTYPE" =~ ^darwin ]]; then
    # JDK
    export JAVA_HOME="$HOME/Library/Java/JavaVirtualMachines/jbr-17.0.8.1/Contents/Home"
    # TOMCAT
    export CATALINA_HOME="$HOME/Documents/tools/tomcat/apache-tomcat-9.0.78"
    # Maven
    export PATH="$HOME/Documents/tools/maven/apache-maven-3.9.4/bin:$PATH"
    # MacOS ruby PATH
    export PATH="$HOME/.ruby/bin:$PATH"
    # MacOS add Homebrew PATH
    eval "$(/opt/homebrew/bin/brew shellenv)"
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
