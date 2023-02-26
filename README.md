# My Simple Dotfiles Managment
Try to backup my dotfiles on MacOS/Linux on path $HOME/.dotfiles, the first version includes the following componets:
- zsh/.zshrc
- zsh/.zprofile
- vim/.vimrc
- vim/.vim(vim-plug)
- tmux/.tmux.comf
- git/.gitconfig
- Brewfile

Testing OS info:
- macOS Ventura 13.2.1
- Debian 5.10 149-2
## Installation
### Linux/MacOS
```Shell
git clone https://github.com/caibiPro/dotfiles.git ~/.dotfiles

cd ~/.dotfiles

# Backup the old dotfiles and install oh-my-zsh
source setup_zsh.sh 

# Systemlink the dotfiles and install the plug-ins
source setup_plug.sh
```
Then restart the shell to enjoy it!

## Bugs
zsh plug-ins contained the <code>autojump</code> which need to install it seperately.
1. MacOS
- <code>setup_plug.sh</code> would install it automatically since the <code>Brewfile</code>
2. Linux/Debian
- When finished the script installation, need to install it manually:
    ```shell
    apt install autojump
    ```
The next step to optimize the installation process will focus on the package installaiton on Linux.




