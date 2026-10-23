# Dotfiles

[中文说明](./README.zh-CN.md)
[Quick Start](./QUICKSTART.md)
[Quick Guide (ZH)](./QUICKSTART.zh-CN.md)

Personal dotfiles for a macOS-first, Linux-compatible terminal workflow.

## What This Repo Manages

- `zsh` for login-shell environment and interactive shell behavior
- `tmux` for terminal multiplexing
- `git` for shared defaults
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
- Ghostty uses `Google Sans Code` with `Maple Mono NF CN` as the fallback for CJK and icons; the Brewfile only installs `Maple Mono NF CN`.
- `Brewfile` is cask-only; shared CLI packages are managed by `scripts/bootstrap.sh`.
- `fzf` and `zoxide` integrations are enabled when the commands exist.
- `bun` is optional and is expected to be managed from `private.local.sh` if used.
- `.psqlrc` is managed here, but `psql` itself is not installed by this repo today.

## Daily Usage

### Shell

- `reload`: restart the current shell as a login shell
- `mkd <dir>`: create a directory and enter it
- `jdk <version>`: switch the JDK (macOS), for example `jdk 17`
- `l` / `ll`: long listing; `ll` includes dotfiles
- `gst`: `git status`
- `doc`: go to `~/Documents` and list it
- `c`: `clear`; `:q`: `exit`
- `cat` runs `bat` when installed; `rm`, `cp` and `mv` ask before overwriting or deleting
- type a directory name such as `..`, `~` or `src` to `cd` into it (`AUTO_CD`)
- `z <keyword>` / `zi`: jump to a frequently used directory (zoxide)

Line editing uses `vi` mode (`bindkey -v`). Insert mode keeps the common emacs keys:

- `Ctrl-a` / `Ctrl-e`, or `Cmd-Left` / `Cmd-Right`: line start / end
- `Alt-b` / `Alt-f`, or `Option-Left` / `Option-Right`: word back / forward
- `Ctrl-w` or `Option-Delete`: delete the previous word; `Alt-d`: delete the next word
- `Ctrl-u` / `Ctrl-k`: delete to line start / end
- `Ctrl-x Ctrl-e`: edit the command in `nvim`; `:wq` runs it, `:cq` cancels
- `Right` or `Ctrl-e` at the end of the line: accept the grey autosuggestion

Normal mode and history:

- `Esc` enters normal mode at once (`KEYTIMEOUT=1`); the cursor turns from a bar into a block
- standard vi motions and edits work (`w`, `b`, `0`, `$`, `dw`, `cw`, ...); `v` starts visual selection
- `u` / `U`: undo / redo; `gg` / `G`: oldest / newest history entry
- `Ctrl-p` / `Ctrl-n` in insert mode, `k` / `j` in normal mode: search history by the current prefix

fzf:

- `Ctrl-r`: search history
- `Ctrl-t`: insert a file path
- `Alt-c`: `cd` into a subdirectory (uses `fd`, with preview)
- `**<Tab>`: fuzzy completion, for example `cd src/**<Tab>`

Prompt is `pure`.

### tmux

Prefix key: `Ctrl-b` (press it twice to send `Ctrl-b` to the program).

Without the prefix:

- `Alt-h/j/k/l`: move between panes
- `Alt-H/J/K/L`: resize the current pane
- `Alt-z`: zoom or unzoom the current pane
- `Alt-p` / `Alt-n`: previous or next window
- `Alt-v`: enter copy mode

With the prefix:

- `-` / `\`: split into top/bottom or left/right panes in the current directory
- `_` / `|`: full-width or full-height split in the current directory
- `x` / `X`: kill the pane or the window
- `/` / `?`: search the pane output forward or backward
- `r`: reload tmux config
- tmux defaults such as `c` (new window), `1-9` (select window), `,` (rename), `d` (detach) and `s` (sessions) are unchanged

Copy mode:

- `v`: begin selection
- `V`: select line
- `Ctrl-v`: rectangle selection
- `y`: copy to the system clipboard
- `Enter`: leave copy mode
- dragging with the mouse also copies to the system clipboard

Status bar sits at the bottom with a transparent background, so it follows the Ghostty light/dark theme. It shows the session name, windows (`Z` marks a zoomed pane), a `PREFIX` hint while the prefix is active, and the hostname.

### Ghostty

- theme follows the system: `GitHub Dark Dimmed` / `GitHub Light Default`
- `Option` acts as `Alt` (`macos-option-as-alt`)
- `Cmd-Left` / `Cmd-Right` send `Ctrl-a` / `Ctrl-e`; `Option-Left` / `Option-Right` move by word
- `Cmd-k` / `Cmd-j`: scroll up or down 5 lines
- selecting text copies it to the clipboard
- a notification is sent when a long command finishes while the window is unfocused
- `Cmd-Shift-,`: reload config

### Git

No custom aliases; `gst` in the shell runs `git status`. Notable defaults:

- `pull.ff = only`, `fetch.prune`, `rebase.autoStash`
- `push.autoSetupRemote`: first `git push` on a new branch sets the upstream
- `diff.algorithm = histogram`, `diff.colorMoved`
- `merge.conflictStyle = zdiff3`, `rerere.enabled`
- `branch.sort = -committerdate`
- `merge.tool = nvimdiff`
- `~/.gitconfig.local` is included last, so it overrides shared settings

### psql

Current defaults:

- prompt shows `user@host:port` and the database
- `NULL` is shown as `[NULL]`
- wide output uses `less -S`
- `\timing` is enabled
- history is kept per database in `~/.psql_history_<dbname>`, ignoring duplicates

### Neovim

Leader key:

- `<Space>`

Current built-in mappings:

- `<leader>w`: write
- `<leader>q`: quit
- `<leader>e`: open file explorer
- `<Esc>` in normal mode: clear search highlight

Colorscheme follows the macOS appearance (`habamax` dark, `shine` light).

## CI

GitHub Actions currently checks:

- `shellcheck` for `scripts/*.sh`
- `zsh -n` for managed zsh/env files
- basic Markdown prose linting
