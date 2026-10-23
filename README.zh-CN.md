# Dotfiles

[English](./README.md)
[工具速查](./QUICKSTART.zh-CN.md)

这是我的个人 dotfiles，目标是提供一套以 macOS 为主、兼容 Linux 的终端工作流。

## 这个仓库管理什么

- `zsh`：登录 shell 环境和交互式 shell 行为
- `tmux`：终端复用
- `git`：常用别名和默认行为
- `psql`：PostgreSQL 交互客户端默认配置
- `ghostty`：macOS 终端界面配置
- `nvim`：唯一受管的编辑器
- `Brewfile`：macOS GUI 应用和字体 cask 清单
- GitHub Actions：shell 和 zsh 的基础检查

## 目录结构

- `zsh/`：shell 入口和 zsh 专属配置
- `env/`：共享环境变量、alias、shell 函数、私有配置示例
- `git/`：共享 Git 配置和私有本地配置示例
- `psql/`：PostgreSQL 交互配置
- `tmux/`：tmux 配置
- `ghostty/`：Ghostty 配置
- `nvim/`：Neovim 配置
- `scripts/`：初始化和同步脚本
- `.github/workflows/`：仓库检查

## 受管目标

`./scripts/sync.sh` 会链接这些路径：

- `~/.zprofile` -> `zsh/.zprofile`
- `~/.zshrc` -> `zsh/.zshrc`
- `~/.gitconfig` -> `git/.gitconfig`
- `~/.psqlrc` -> `psql/.psqlrc`
- `~/.tmux.conf` -> `tmux/.tmux.conf`
- `~/.config/ghostty` -> `ghostty/`
- `~/.config/nvim` -> `nvim/`

旧文件会先被移动到 `~/.dotfiles-backups/<timestamp>/`，再替换为软链。

## 安装

### 1. 克隆仓库

```sh
git clone https://github.com/caibiPro/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### 2. 初始化一台新机器

```sh
./scripts/bootstrap.sh
```

这个脚本会做的事：

- 在 macOS 上：
  - 如果缺 Homebrew，就先安装
  - 用 Homebrew 安装共享 CLI 工具；旧版 macOS 且有 MacPorts 时优先用 MacPorts
  - 按 `Brewfile` 安装 GUI 应用和字体 cask
- 在 Linux 上：
  - 尽量用 `apt-get` 或 `dnf` 安装共享 CLI 工具
- 在两个平台上都会：
  - 如果缺 Oh My Zsh，就安装它
  - 安装或更新：
    - `zsh-autosuggestions`
    - `fast-syntax-highlighting`
    - `pure`
  - 运行 `./scripts/sync.sh`

### 3. 重新同步配置

在已有机器上拉取新版本后，执行：

```sh
./scripts/sync.sh
```

## 私有本地配置

机器相关或个人身份相关的配置不放进仓库：

- `~/.dotfiles/env/private.local.sh`
- `~/.gitconfig.local`

可以从示例文件开始：

```sh
cp ~/.dotfiles/git/.gitconfig.local.example ~/.gitconfig.local
cp ~/.dotfiles/env/private.local.sh.example ~/.dotfiles/env/private.local.sh
```

`private.local.sh` 适合放：

- Android SDK 路径
- 当前机器的 `JAVA_HOME` 覆盖配置
- 不属于共享软件清单的本地工具
- 机器专属 PATH

`~/.gitconfig.local` 适合放：

- `user.name`
- `user.email`
- 主机或账号相关的 Git 覆盖项

## 工具说明

- 这个仓库只管理 `nvim`，不再管理 `vim`。
- Ghostty 使用 `Maple Mono NF CN`；macOS 下 Brewfile 已包含对应字体 cask。
- `Brewfile` 只管理 cask；共享 CLI 工具由 `scripts/bootstrap.sh` 管理。
- 如果系统里存在 `zoxide`，zsh 会自动启用它的集成。
- `bun` 是可选工具；如果要用，建议通过 `private.local.sh` 管理。
- `.psqlrc` 已纳入管理，但这个仓库目前不会自动安装 `psql` 本体。

## 日常使用

### Shell

- `reload`：以 login shell 方式重启当前 shell
- `mkd <dir>`：创建目录并进入
- `jdk <version>`：切换 JDK（macOS）
- `l` / `ll`：详细列表，`ll` 包含隐藏文件
- `gst`：`git status`
- 直接输入目录名（如 `..`、`~`、`src`）即可 `cd` 进去（`AUTO_CD`）
- `z <关键词>` / `zi`：跳到常用目录（zoxide）

命令行编辑使用 `vi` 模式（`bindkey -v`），插入模式下保留常用的 emacs 键：

- `Ctrl-a` / `Ctrl-e`，或 `Cmd-左` / `Cmd-右`：行首 / 行尾
- `Alt-b` / `Alt-f`，或 `Option-左` / `Option-右`：按词后退 / 前进
- `Ctrl-w` 或 `Option-Delete`：删除前一个词；`Alt-d`：删除后一个词
- `Ctrl-u` / `Ctrl-k`：删到行首 / 行尾
- `Ctrl-x Ctrl-e`：在 `nvim` 里编辑当前命令

普通模式和历史：

- `Esc` 进入普通模式，光标从竖线变成方块
- 普通模式下按 `v`：在 `nvim` 里编辑当前命令
- `Ctrl-p` / `Ctrl-n` 会按当前输入前缀搜索历史

fzf：

- `Ctrl-r`：搜索历史
- `Ctrl-t`：插入文件路径
- `Alt-c`：`cd` 进子目录（用 `fd`，带预览）
- `**<Tab>`：模糊补全，例如 `cd src/**<Tab>`

提示符使用 `pure`。

### tmux

前缀键：

- `Ctrl-b`

常用操作：

- `Ctrl-b r`：重载 tmux 配置
- `Alt-h/j/k/l`：在 pane 之间移动
- `Alt-p` / `Alt-n`：切到上一个或下一个 window
- `-` / `\`：在当前目录下做纵向或横向分屏
- `_` / `|`：在当前目录下做全高或全宽分屏
- `Alt-z`：放大或恢复当前 pane
- `Alt-v`：进入 copy mode

Copy mode：

- `v`：开始选择
- `V`：按整行选择
- `Ctrl-v`：矩形选择
- `y`：复制到系统剪贴板

### Git

没有自定义 alias，shell 里的 `gst` 等于 `git status`。主要默认配置：

- `pull.ff = only`、`fetch.prune`、`rebase.autoStash`
- `push.autoSetupRemote`：新分支第一次 `git push` 时自动设置 upstream
- `diff.algorithm = histogram`、`diff.colorMoved`
- `merge.conflictStyle = zdiff3`、`rerere.enabled`
- `branch.sort = -committerdate`

### psql

当前默认行为：

- `NULL` 显示为 `[NULL]`
- 宽输出使用 `less -S`
- 启用 `\x auto`
- 启用 `\timing`
- 交互式事务出错时启用 `ON_ERROR_ROLLBACK interactive`

### Neovim

Leader 键：

- `<Space>`

当前内置映射：

- `<leader>w`：保存
- `<leader>q`：退出
- `<leader>e`：打开文件浏览器
- 普通模式下 `<Esc>`：清除搜索高亮

## CI

GitHub Actions 当前会检查：

- `scripts/*.sh` 的 `shellcheck`
- 受管 zsh/env 文件的 `zsh -n`
- 基础 Markdown 文案检查
