#!/usr/bin/env bash

# # Dotfiles basic arguments
DOTDIR=$HOME/.dotfiles
PROGRAMS=(zsh vim tmux git)

# Dont link DS_Store files
find . -name ".DS_Store" -exec rm {} \;

# Link dotfiles in PROGRAMS to the $HOME directory
for rcdir in ${PROGRAMS[@]}; do
    DOTFILEPATH=${DOTDIR}/$rcdir
    for rcfile in $DOTFILEPATH/.*; do
        echo "$rcfile -> "
        file=$(eval basename $rcfile)
        echo "$HOME/$file"
        ln -sf "$rcfile" "$HOME/$file"
    done
done

# # ZSH plug-in install
# zsh-autosuggestions
if [[ ! -d $ZSH_CUSTOM/plugins/zsh-autosuggestions ]]; then
    echo "didn'f find plugin zsh-autosuggestions, start to install..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
else
    echo "plugin zsh-autosuggestions found, skip installation..."
fi

# # zsh-syntax-highlighting
# if [[ ! -d $ZSH_CUSTOM/plugins/zsh-syntax-highlighting ]]; then
#     echo "didn'f find plugin zsh-syntax-highlighting, start to install..."
#     git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# else
#     echo "plugin zsh-syntax-highlighting found, skip installation..."
# fi

# fast-syntax-highlighting
if [[ ! -d $ZSH_CUSTOM/plugins/fast-syntax-highlighting ]]; then
    echo "didn'f find plugin fast-syntax-highlighting, start to install..."
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
        ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
else
    echo "plugin fast-syntax-highlighting found, skip installation..."
fi

# zsh-completions
if [[ ! -d $ZSH_CUSTOM/plugins/zsh-completions ]]; then
    echo "didn'f find plugin zsh-completions, start to install..."
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
else
    echo "plugin zsh-completions found, skip installation..."
fi

# # Check for Homebrew and install if we don't have it in MacOs
if [[ "$OSTYPE" =~ ^darwin ]]; then
    echo "MacOS..."
    # # Check for Homebrew and install if we don't have it
    which brew 1>/dev/null
    if [[ $? == 0 ]]; then
        echo "brew found, skip installation..."
    else
        echo "brew didn't find, start to install..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        # Update Homebrew recipes
        /opt/homebrew/bin/brew update

        # Install all our dependencies with bundle (See Brewfile)
        /opt/homebrew/bin/brew tap homebrew/bundle
        /opt/homebrew/bin/brew bundle --file $DOTDIR/Brewfile
    fi
elif [[ "$OSTYPE" =~ ^linux ]]; then
    echo "Linux..."
fi
