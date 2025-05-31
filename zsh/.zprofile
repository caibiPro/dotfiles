# Common environment variables
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# OS-specific configurations
if [[ "$OSTYPE" =~ ^darwin ]]; then
    # Homebrew (should be early in PATH)
    eval "$(/opt/homebrew/bin/brew shellenv)"
    
    # Java configuration
    export JAVA_HOME="$HOME/Library/Java/JavaVirtualMachines/corretto-17.0.13/Contents/Home"
    export PATH="$JAVA_HOME/bin:$PATH"
    
    # Android configuration
    export ANDROID_HOME="$HOME/Library/Android/sdk"
    export PATH="$ANDROID_HOME/platform-tools:$PATH"
    export PATH="$ANDROID_HOME/emulator:$PATH"
    export PATH="$ANDROID_HOME/build-tools/34.0.0:$PATH"

    # PostgreSQL
    export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
    
    # Maven
    export MAVEN_HOME="$HOME/Documents/tools/maven/apache-maven-3.9.4"
    export PATH="$MAVEN_HOME/bin:$PATH"
    
    # Tomcat
    export CATALINA_HOME="$HOME/Documents/tools/tomcat/apache-tomcat-9.0.78"
    export PATH="$CATALINA_HOME/bin:$PATH"
    
    # Ruby configuration
    export RUBY_HOME="/opt/homebrew/opt/ruby"
    export PATH="$RUBY_HOME/bin:$PATH"
    export PATH="/opt/homebrew/lib/ruby/gems/3.3.0/bin:$PATH"
    export PATH="$HOME/.ruby/bin:$PATH"
    export LDFLAGS="-L$RUBY_HOME/lib"
    export CPPFLAGS="-I$RUBY_HOME/include"
    
elif [[ "$OSTYPE" =~ ^linux ]]; then
    # Java configuration
    export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
    export PATH="$JAVA_HOME/bin:$PATH"
    
    # Tomcat
    export CATALINA_HOME="$HOME/tools/tomcat/apache-tomcat-9.0.78"
    export PATH="$CATALINA_HOME/bin:$PATH"
    
    # Maven
    export MAVEN_HOME="$HOME/tools/maven/apache-maven-3.9.4"
    export PATH="$MAVEN_HOME/bin:$PATH"
    
    # Ruby configuration
    export GEM_HOME="$HOME/.gems"
    export PATH="$GEM_HOME/bin:$PATH"
fi

# Cargo environment
if [ -f "$HOME/.cargo/env" ]; then
    export CARGO_HOME="$HOME/.cargo"
    source "$CARGO_HOME/env"
fi

# Node Version Manager (NVM)
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
    source "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
fi

# Add standard system paths at the end (lower priority)
export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
