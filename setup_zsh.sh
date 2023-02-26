#!/usr/bin/env bash

# # Backup current dotfiles
OLD_DOTFILES="dotfiles_backup_$(date -u +"%Y%m%d%H%M%S")"
mkdir $OLD_DOTFILES

function backup_if_exits() {
    if [[ -f $1 ]]; then
        mv $1 $OLD_DOTFILES
    fi
    if [[ -d $1 ]]; then
        mv $1 $OLD_DOTFILES
    fi
}

# Clean common conflicts
backup_if_exits ~/.zprofile
backup_if_exits ~/.zshrc
backup_if_exits ~/.tmux.conf
backup_if_exits ~/.vimrc
backup_if_exits ~/.vim
backup_if_exits ~/.gitconfig

# # Check for Oh My Zsh and install if we don't have it
which omz 1>/dev/null
if [[ $? == 0 ]]; then
    echo "oh-my-zsh found, skip installation..."
else
    echo "oh-my-zsh didn't found, start to install..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
