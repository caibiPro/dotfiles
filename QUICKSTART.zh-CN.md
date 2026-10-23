# 工具速查

这份速查只覆盖这套 dotfiles 里当前最值得优先上手的工具和命令。

## 优先顺序

建议先学这 5 个：

1. `rg`
2. `fd`
3. `fzf`
4. `zoxide`
5. `nvim`

`yq` 先放后面，不急着一起学。

## rg

用途：搜文本内容，优先替代很多 `grep -R`。

```sh
rg keyword
rg "exact phrase"
rg -n "TODO"
rg "function_name" .
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

内置快捷键：

- `Ctrl-r`：搜索历史
- `Ctrl-t`：插入文件路径
- `Alt-c`：`cd` 进子目录

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

## yq

用途：处理 YAML。

```sh
yq '.name' file.yaml
yq '.jobs.build' .github/workflows/check.yml
```

先知道它是 YAML 版 `jq` 就够了。

## 你现在这套工作流里最常用的入口

- 搜文本：`rg`
- 找文件：`fd`
- 找目录并进入：`Alt-c`
- 跳目录：`z ...`
- 搜历史：`Ctrl-r`
- 编辑：`nvim file`
- 重载 shell：`reload`
- tmux 前缀：`Ctrl-b`
- Git 状态：`gst`

## 一周最短练习清单

```sh
rg
fd
z
nvim
gst
```

## 最短记忆版

- 找内容用 `rg`
- 找文件用 `fd`
- 跳目录用 `z`
- 编辑用 `nvim`
- 终端里筛选就接 `fzf`
