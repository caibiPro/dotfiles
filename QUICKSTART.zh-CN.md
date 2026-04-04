# 工具速查

这份速查只覆盖这套 dotfiles 里当前最值得优先上手的工具和命令。

## 优先顺序

建议先学这 6 个：

1. `rg`
2. `fd`
3. `fzf`
4. `zoxide`
5. `nvim`
6. `gh`

`eza` 和 `yq` 先放后面，不急着一起学。

## rg

用途：搜文本内容，优先替代很多 `grep -R`。

```sh
rg keyword
rg "exact phrase"
rg -n "TODO"
rg "function_name" .
```

你现在还有：

```sh
sgrep keyword
```

## fd

用途：找文件和目录，优先替代很多 `find`。

```sh
fd name
fd '\.md$'
fd config ~
fd --type d src
fd --type f json
```

你现在还有：

```sh
ff pattern
fdir pattern
```

## fzf

用途：模糊筛选器，通常和别的命令组合使用。

```sh
fd | fzf
history | fzf
git branch | fzf
```

先记住一个模式就够了：

```sh
某个命令 | fzf
```

## zoxide

用途：智能跳目录。

```sh
z project
z dotfiles
z Downloads
```

核心思路就是：常去的目录以后用 `z 关键词` 跳过去。

## nvim

先学最小集：

```sh
nvim file.txt
```

最重要的键：

- `i`：进入插入模式
- `Esc`：回普通模式
- `:w`：保存
- `:q`：退出
- `:wq`：保存并退出
- `/word`：搜索
- `n`：跳到下一个结果
- `<Space>w`：保存
- `<Space>q`：退出
- `<Space>e`：打开文件浏览器

你现在还有：

```sh
v file.txt
```

## gh

用途：GitHub CLI。

```sh
gh auth login
gh repo view
gh pr status
gh pr list
gh issue list
```

如果你经常看 PR、issue、workflow，这个很值。

## eza

用途：更好的 `ls`。

```sh
eza
eza -l
eza -la
eza --tree
```

你现在的 `ls` / `l` / `ll` 会在装了 `eza` 后自动接过去，所以日常直接用 `ls` 就行。

## yq

用途：处理 YAML。

```sh
yq '.name' file.yaml
yq '.jobs.build' .github/workflows/check.yml
```

先知道它是 YAML 版 `jq` 就够了。

## 你现在这套工作流里最常用的入口

- 搜文本：`rg` 或 `sgrep`
- 找文件：`fd` 或 `ff`
- 找目录：`fdir`
- 跳目录：`z ...`
- 编辑：`v file`
- 重载 shell：`reload`
- tmux 前缀：`Ctrl-a`
- Git 状态：`git s`

## 一周最短练习清单

```sh
rg
fd
z
v
git s
gh pr status
```

## 最短记忆版

- 找内容用 `rg`
- 找文件用 `fd`
- 跳目录用 `z`
- 编辑用 `v`
- GitHub 用 `gh`
- 终端里筛选就接 `fzf`
