# Dotfiles

[English](./README.md)
[工具速查](./QUICKSTART.zh-CN.md)

这是我的个人 dotfiles，目标是提供一套以 macOS 为主、兼容 Linux 的终端工作流。

## 这个仓库管理什么

- `zsh`：登录 shell 环境和交互式 shell 行为
- `tmux`：终端复用
- `git`：共享默认配置
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
- Ghostty 主字体是 `Google Sans Code`，中文和图标回退到 `Maple Mono NF CN`；Brewfile 只安装 `Maple Mono NF CN`。
- `Brewfile` 只管理 cask；共享 CLI 工具由 `scripts/bootstrap.sh` 管理。
- 系统里存在 `fzf`、`zoxide` 时，zsh 会自动启用它们的集成。
- `bun` 是可选工具；如果要用，建议通过 `private.local.sh` 管理。
- `.psqlrc` 已纳入管理，但这个仓库目前不会自动安装 `psql` 本体。

## 日常使用

### Shell

- `reload`：以 login shell 方式重启当前 shell
- `mkd <dir>`：创建目录并进入
- `jdk <version>`：切换 JDK（macOS），例如 `jdk 17`
- `l` / `ll`：详细列表，`ll` 包含隐藏文件
- `gst`：`git status`
- `dps`：`docker ps`，每个容器分块显示
- `doc`：进入 `~/Documents` 并列出内容
- `c`：`clear`；`:q`：`exit`
- 装了 `bat` 时 `cat` 会调用 `bat`；`rm`、`cp`、`mv` 在删除或覆盖前会先确认
- 直接输入目录名（如 `..`、`~`、`src`）即可 `cd` 进去（`AUTO_CD`）
- `z <关键词>` / `zi`：跳到常用目录（zoxide）

命令行编辑使用 `vi` 模式（`bindkey -v`），插入模式下保留常用的 emacs 键：

- `Ctrl-a` / `Ctrl-e`，或 `Cmd-左` / `Cmd-右`：行首 / 行尾
- `Alt-b` / `Alt-f`，或 `Option-左` / `Option-右`：按词后退 / 前进
- `Ctrl-w` 或 `Option-Delete`：删除前一个词；`Alt-d`：删除后一个词
- `Ctrl-u` / `Ctrl-k`：删到行首 / 行尾
- `Ctrl-x Ctrl-e`：在 `nvim` 里编辑当前命令；`:wq` 执行，`:cq` 取消
- 光标在行尾时按 `右方向键` 或 `Ctrl-e`：接受灰色的自动建议

普通模式和历史：

- `Esc` 立即进入普通模式（`KEYTIMEOUT=1`），光标从竖线变成方块
- 支持标准 vi 移动和编辑（`w`、`b`、`0`、`$`、`dw`、`cw` 等）；`v` 进入 visual 选择模式
- `u` / `U`：撤销 / 重做；`gg` / `G`：最早 / 最新的历史记录
- 插入模式下 `Ctrl-p` / `Ctrl-n`，普通模式下 `k` / `j`：按当前输入前缀搜索历史

fzf：

- `Ctrl-r`：搜索历史
- `Ctrl-t`：插入文件路径
- `Alt-c`：`cd` 进子目录（用 `fd`，带预览）
- `**<Tab>`：模糊补全，例如 `cd src/**<Tab>`

提示符使用 `pure`。

### tmux

前缀键：`Ctrl-b`（连按两次会把 `Ctrl-b` 传给程序）。

不需要前缀：

- `Alt-h/j/k/l`：在 pane 之间移动
- `Alt-H/J/K/L`：调整当前 pane 大小
- `Alt-z`：放大或恢复当前 pane
- `Alt-p` / `Alt-n`：切到上一个或下一个 window
- `Alt-v`：进入 copy mode

需要前缀：

- `-` / `\`：在当前目录下上下分屏 / 左右分屏
- `_` / `|`：在当前目录下全宽 / 全高分屏
- `x` / `X`：关闭 pane / 关闭 window
- `/` / `?`：在 pane 输出里向下 / 向上搜索
- `r`：重载 tmux 配置
- tmux 默认键不变，例如 `c`（新建 window）、`1-9`（切换 window）、`,`（重命名）、`d`（detach）、`s`（会话列表）

Copy mode：

- `v`：开始选择
- `V`：按整行选择
- `Ctrl-v`：矩形选择
- `y`：复制到系统剪贴板
- `Enter`：退出 copy mode
- 用鼠标拖选也会复制到系统剪贴板

状态栏在底部，背景透明，会跟随 Ghostty 的深色 / 浅色主题。显示会话名、window 列表（`Z` 表示 pane 已放大）、按下前缀时的 `PREFIX` 提示和主机名。

### Ghostty

- 主题跟随系统：`GitHub Dark Dimmed` / `GitHub Light Default`
- `Option` 当作 `Alt` 使用（`macos-option-as-alt`）
- `Cmd-左` / `Cmd-右` 发送 `Ctrl-a` / `Ctrl-e`；`Option-左` / `Option-右` 按词移动
- `Cmd-k` / `Cmd-j`：向上 / 向下滚动 5 行
- 选中文字即复制到剪贴板
- 窗口不在前台时，耗时较长的命令执行完会发通知
- `Cmd-Shift-,`：重载配置

### Git

没有自定义 alias，shell 里的 `gst` 等于 `git status`。主要默认配置：

- `pull.ff = only`、`fetch.prune`、`rebase.autoStash`
- `push.autoSetupRemote`：新分支第一次 `git push` 时自动设置 upstream
- `diff.algorithm = histogram`、`diff.colorMoved`
- `merge.conflictStyle = zdiff3`、`rerere.enabled`
- `branch.sort = -committerdate`
- `merge.tool = nvimdiff`
- `~/.gitconfig.local` 最后引入，会覆盖共享配置

### psql

当前默认行为：

- 提示符显示 `user@host:port` 和数据库名
- `NULL` 显示为 `[NULL]`
- 宽输出使用 `less -S`
- 启用 `\timing`
- 历史按数据库分别保存在 `~/.psql_history_<dbname>`，忽略重复命令

### Neovim

Leader 键：

- `<Space>`

当前内置映射：

- `<leader>w`：保存
- `<leader>q`：退出
- `<leader>e`：打开文件浏览器
- 普通模式下 `<Esc>`：清除搜索高亮

配色跟随 macOS 外观（深色 `habamax`，浅色 `shine`）。

## CI

GitHub Actions 当前会检查：

- `scripts/*.sh` 的 `shellcheck`
- 受管 zsh/env 文件的 `zsh -n`
- 基础 Markdown 文案检查
