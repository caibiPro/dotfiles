# Common environment variables
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
typeset -U path PATH

# OS-specific configurations
if [[ "$OSTYPE" =~ ^darwin ]]; then
    # Homebrew (should be early in PATH)
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # Prefer Homebrew Python over macOS Command Line Tools Python.
    export PATH="/opt/homebrew/opt/python@3.13/libexec/bin:$PATH"

    # Added by `rbenv init`
    eval "$(rbenv init - zsh)"

    # Java configuration
    export JAVA_HOME="$HOME/Library/Java/JavaVirtualMachines/ms-21.0.8/Contents/Home"
    export PATH="$JAVA_HOME/bin:$PATH"

    # Android configuration
    export ANDROID_HOME="$HOME/Library/Android/sdk"
    export PATH="$ANDROID_HOME/platform-tools:$PATH"
    export PATH="$ANDROID_HOME/emulator:$PATH"
    export PATH="$ANDROID_HOME/build-tools/36.1.0:$PATH"

    # PostgreSQL
    export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
    export PGDATA="/opt/homebrew/var/postgresql@16"

    # Rideshare 数据库配置
    export RIDESHARE_DB_PASSWORD=$(openssl rand -hex 12)
    export DB_URL="postgres://postgres:@localhost:5432/postgres"
    export DATABASE_URL="postgres://owner:@localhost:5432/rideshare_development"

    # Maven
    export MAVEN_HOME="$HOME/Documents/tools/maven/apache-maven-3.9.4"
    export PATH="$MAVEN_HOME/bin:$PATH"

    # Tomcat
    export CATALINA_HOME="$HOME/Documents/tools/tomcat/apache-tomcat-9.0.78"
    export PATH="$CATALINA_HOME/bin:$PATH"

    # bun
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"

    # Added by Antigravity
    export PATH="/Users/mingqing/.antigravity/antigravity/bin:$PATH"

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
if [ -d "$NVM_DIR" ] && [ -s "$NVM_DIR/nvm.sh" ]; then
    source "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
fi

# Private local environment variables
if [ -f "$HOME/.dotfiles/env/private.local.sh" ]; then
    source "$HOME/.dotfiles/env/private.local.sh"
fi

# OpenCode
export PATH=/Users/mingqing/.opencode/bin:$PATH
