# Quick Start

This guide focuses on the tools in this dotfiles setup that are worth learning first.

## Priority

Start with these 6:

1. `rg`
2. `fd`
3. `fzf`
4. `zoxide`
5. `nvim`
6. `gh`

Leave `eza` and `yq` for later.

## rg

Use it to search text. It replaces many `grep -R` cases.

```sh
rg keyword
rg "exact phrase"
rg -n "TODO"
rg "function_name" .
```

You also have:

```sh
sgrep keyword
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

You also have:

```sh
ff pattern
fdir pattern
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

You also have:

```sh
v file.txt
```

## gh

Use it as the GitHub CLI.

```sh
gh auth login
gh repo view
gh pr status
gh pr list
gh issue list
```

If you use GitHub often, this is worth learning early.

## eza

Use it as a better `ls`.

```sh
eza
eza -l
eza -la
eza --tree
```

Your `ls` / `l` / `ll` aliases switch to `eza` automatically once it is installed.

## yq

Use it to work with YAML.

```sh
yq '.name' file.yaml
yq '.jobs.build' .github/workflows/check.yml
```

The simplest way to think about it: `yq` is the YAML version of `jq`.

## Most Useful Entry Points In This Setup

- Search text: `rg` or `sgrep`
- Find files: `fd` or `ff`
- Find directories: `fdir`
- Jump to directories: `z ...`
- Edit files: `v file`
- Reload the shell: `reload`
- tmux prefix: `Ctrl-a`
- Git status: `git s`

## One-Week Practice List

```sh
rg
fd
z
v
git s
gh pr status
```

## Shortest Memory Version

- Use `rg` to find text
- Use `fd` to find files
- Use `z` to jump directories
- Use `v` to edit
- Use `gh` for GitHub
- Pipe into `fzf` when you want fuzzy selection
