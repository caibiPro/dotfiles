# Dotfiles

[中文说明](./README.zh-CN.md)
[Quick Start](./QUICKSTART.md)
[Quick Guide (ZH)](./QUICKSTART.zh-CN.md)

Personal dotfiles for a macOS-first, Linux-compatible terminal workflow.

## What This Repo Manages

- `zsh` for login-shell environment and interactive shell behavior
- `tmux` for terminal multiplexing
- `git` for aliases and defaults
- `psql` for interactive PostgreSQL defaults
- `ghostty` for terminal UI on macOS
- `nvim` as the only editor managed by this repo
- `Brewfile` for macOS GUI apps and font casks
- GitHub Actions checks for shell and zsh syntax

## Layout

- `zsh/`: shell entrypoints and zsh-specific config
- `env/`: shared environment variables, aliases, shell functions, and private local example
- `git/`: shared Git defaults and private local example
- `psql/`: PostgreSQL interactive client config
- `tmux/`: tmux configuration
- `ghostty/`: Ghostty terminal config
- `nvim/`: Neovim config
- `scripts/`: machine bootstrap and symlink sync entrypoints
- `.github/workflows/`: repository checks

## Managed Targets

`./scripts/sync.sh` links these paths:

- `~/.zprofile` -> `zsh/.zprofile`
- `~/.zshrc` -> `zsh/.zshrc`
- `~/.gitconfig` -> `git/.gitconfig`
- `~/.psqlrc` -> `psql/.psqlrc`
- `~/.tmux.conf` -> `tmux/.tmux.conf`
- `~/.config/ghostty` -> `ghostty/`
- `~/.config/nvim` -> `nvim/`

Existing files are moved into `~/.dotfiles-backups/<timestamp>/` before replacement.

## Install

### 1. Clone the repo

```sh
git clone https://github.com/caibiPro/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### 2. Bootstrap a machine

```sh
./scripts/bootstrap.sh
```

What bootstrap does:

- On macOS:
  - installs Homebrew if missing
  - installs shared CLI packages with Homebrew, or MacPorts on older macOS when available
  - installs GUI apps and font casks from `Brewfile`
- On Linux:
  - installs the shared CLI package set with `apt-get` or `dnf` when available
- On both:
  - installs Oh My Zsh if missing
  - installs or updates:
    - `zsh-autosuggestions`
    - `fast-syntax-highlighting`
    - `pure`
  - runs `./scripts/sync.sh`

### 3. Re-sync managed files

Run this after pulling new dotfiles on an existing machine:

```sh
./scripts/sync.sh
```

## Private Local Config

Keep machine-specific or personal settings out of the repo:

- `~/.dotfiles/env/private.local.sh`
- `~/.gitconfig.local`

Start from the examples:

```sh
cp ~/.dotfiles/git/.gitconfig.local.example ~/.gitconfig.local
cp ~/.dotfiles/env/private.local.sh.example ~/.dotfiles/env/private.local.sh
```

Typical `private.local.sh` uses:

- Android SDK paths
- `JAVA_HOME` overrides for a machine-specific JDK
- local tools that are not part of the shared package set
- machine-specific PATH additions

Typical `~/.gitconfig.local` uses:

- `user.name`
- `user.email`
- any host- or account-specific Git overrides

## Tooling Notes

- `nvim` is the only editor managed by this repo.
- Ghostty expects `Maple Mono NF CN`; the Brewfile includes the matching font cask on macOS.
- `Brewfile` is cask-only; shared CLI packages are managed by `scripts/bootstrap.sh`.
- `zoxide` integration is enabled when the command exists.
- `bun` is optional and is expected to be managed from `private.local.sh` if used.
- `.psqlrc` is managed here, but `psql` itself is not installed by this repo today.

## Daily Usage

### Shell

- `reload`: restart the current shell as a login shell
- `mkd <dir>`: create a directory and enter it
- `jdk <version>`: switch the JDK (macOS)
- `l` / `ll`: long listing; `ll` includes dotfiles
- `gst`: `git status`
- type a directory name such as `..`, `~` or `src` to `cd` into it (`AUTO_CD`)
- `z <keyword>` / `zi`: jump to a frequently used directory (zoxide)

Line editing uses `vi` mode (`bindkey -v`). Insert mode keeps the common emacs keys:

- `Ctrl-a` / `Ctrl-e`, or `Cmd-Left` / `Cmd-Right`: line start / end
- `Alt-b` / `Alt-f`, or `Option-Left` / `Option-Right`: word back / forward
- `Ctrl-w` or `Option-Delete`: delete the previous word; `Alt-d`: delete the next word
- `Ctrl-u` / `Ctrl-k`: delete to line start / end
- `Ctrl-x Ctrl-e`: edit the command in `nvim`

Normal mode and history:

- `Esc` enters normal mode; the cursor turns from a bar into a block
- `v` in normal mode edits the command in `nvim`
- `Ctrl-p` / `Ctrl-n` search command history by the current prefix

fzf:

- `Ctrl-r`: search history
- `Ctrl-t`: insert a file path
- `Alt-c`: `cd` into a subdirectory (uses `fd`, with preview)
- `**<Tab>`: fuzzy completion, for example `cd src/**<Tab>`

Prompt is `pure`.

### tmux

Prefix key:

- `Ctrl-b`

Common actions:

- `Ctrl-b r`: reload tmux config
- `Alt-h/j/k/l`: move between panes
- `Alt-p` / `Alt-n`: previous or next window
- `-` / `\`: split vertically or horizontally in the current directory
- `_` / `|`: full-height or full-width splits in the current directory
- `Alt-z`: zoom or unzoom the current pane
- `Alt-v`: enter copy mode

Copy mode:

- `v`: begin selection
- `V`: select line
- `Ctrl-v`: rectangle selection
- `y`: copy to the system clipboard

### Git

No custom aliases; `gst` in the shell runs `git status`. Notable defaults:

- `pull.ff = only`, `fetch.prune`, `rebase.autoStash`
- `push.autoSetupRemote`: first `git push` on a new branch sets the upstream
- `diff.algorithm = histogram`, `diff.colorMoved`
- `merge.conflictStyle = zdiff3`, `rerere.enabled`
- `branch.sort = -committerdate`

### psql

Current defaults:

- `NULL` is shown as `[NULL]`
- wide output uses `less -S`
- `\x auto` is enabled
- `\timing` is enabled
- interactive transaction errors use `ON_ERROR_ROLLBACK interactive`

### Neovim

Leader key:

- `<Space>`

Current built-in mappings:

- `<leader>w`: write
- `<leader>q`: quit
- `<leader>e`: open file explorer
- `<Esc>` in normal mode: clear search highlight

## CI

GitHub Actions currently checks:

- `shellcheck` for `scripts/*.sh`
- `zsh -n` for managed zsh/env files
- basic Markdown prose linting
