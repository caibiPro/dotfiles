# Quick Start

This guide focuses on the tools in this dotfiles setup that are worth learning first.

## Priority

Start with these 5:

1. `rg`
2. `fd`
3. `fzf`
4. `zoxide`
5. `nvim`

Leave `yq` for later.

## rg

Use it to search text. It replaces many `grep -R` cases.

```sh
rg keyword
rg "exact phrase"
rg -n "TODO"
rg "function_name" .
```

## fd

Use it to find files and directories. It replaces many `find` cases.

```sh
fd name
fd '\.md$'
fd config ~
fd --type d src
fd --type f json
```

## fzf

Use it as a fuzzy selector, usually after another command.

```sh
fd | fzf
history | fzf
git branch | fzf
```

The main pattern to remember is:

```sh
some-command | fzf
```

Built-in shortcuts:

- `Ctrl-r`: search history
- `Ctrl-t`: insert a file path
- `Alt-c`: `cd` into a subdirectory

## zoxide

Use it for smart directory jumping.

```sh
z project
z dotfiles
z Downloads
```

The idea is simple: once you visit directories often, `z <keyword>` jumps back to them.

## nvim

Start with the smallest useful set:

```sh
nvim file.txt
```

Most important keys:

- `i`: enter insert mode
- `Esc`: return to normal mode
- `:w`: write
- `:q`: quit
- `:wq`: write and quit
- `/word`: search
- `n`: next result
- `<Space>w`: write
- `<Space>q`: quit
- `<Space>e`: open the file explorer

## yq

Use it to work with YAML.

```sh
yq '.name' file.yaml
yq '.jobs.build' .github/workflows/check.yml
```

The simplest way to think about it: `yq` is the YAML version of `jq`.

## Most Useful Entry Points In This Setup

- Search text: `rg`
- Find files: `fd`
- Find and enter directories: `Alt-c`
- Jump to directories: `z ...`
- Search history: `Ctrl-r`
- Edit files: `nvim file`
- Reload the shell: `reload`
- tmux prefix: `Ctrl-b`
- Git status: `gst`

## One-Week Practice List

```sh
rg
fd
z
nvim
gst
```

## Shortest Memory Version

- Use `rg` to find text
- Use `fd` to find files
- Use `z` to jump directories
- Use `nvim` to edit
- Pipe into `fzf` when you want fuzzy selection
