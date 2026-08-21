# dotfiles

这个仓库使用 [GNU Stow](https://www.gnu.org/software/stow/) 管理，按软件拆分为独立模块。新机器上可以只启用需要的软件，避免一次性部署所有配置。

## 目录结构

```
packages/   home 配置包（stow 目标为 $HOME）
system/     系统配置包（stow 目标为 /）
misc/       不适合 stow 的手动配置（JetBrains、VS Code、Windows Terminal 等）
scripts/    仓库脚本
private/    本地私有文件（已被 .gitignore 忽略）
install.sh  安装入口
Makefile    常用命令封装
```

每个 `packages/<name>` 或 `system/<name>` 都是一个 stow package，内部路径会相对于目标目录展开。

## 准备

1. 安装依赖：

   ```sh
   # Arch
   sudo pacman -S stow git

   # Debian/Ubuntu
   sudo apt install stow git
   ```

2. 克隆仓库。`kitty` 主题是 git submodule，需要递归克隆：

   ```sh
   git clone --recurse-submodules git@github.com:<you>/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

   如果已经普通克隆，可以补拉子模块：

   ```sh
   git submodule update --init --recursive
   ```

## 使用

### 查看可安装的包

```sh
./install.sh -l        # home 配置
./install.sh -s -l     # system 配置
```

### 按需安装 home 配置

```sh
./install.sh zsh git tmux nvim
./install.sh i3 polybar picom rofi
```

安装全部 home 配置：

```sh
./install.sh -a
```

### 按需安装系统配置

系统配置会写入 `/`，需要 root 权限。脚本会自动通过 `sudo` 重跑：

```sh
./install.sh -s pacman network docker
sudo ./install.sh -s caddy samba v2ray
```

安装全部系统配置：

```sh
sudo ./install.sh -s -a
```

也可以用 Makefile：

```sh
make list
make home PACKAGES="zsh git nvim"
make system SYSTEM_PACKAGES="pacman docker"
```

## Home 配置包

| 包名 | 内容 |
| --- | --- |
| `alacritty` | `~/.config/alacritty` |
| `applications` | `~/.local/share/applications` |
| `autostart` | `~/.config/autostart` |
| `bash` | `~/.bashrc` |
| `bat` | `~/.config/bat` |
| `cargo` | `~/.config/cargo` |
| `cgdb` | `~/.cgdb/cgdbrc` |
| `cheat` | `~/.config/cheat` |
| `docs` | `~/.config/docs` |
| `dunst` | `~/.config/dunst` |
| `fcitx5` | Fcitx5/Rime 配置及输入法环境变量 |
| `fontconfig` | `~/.config/fontconfig` |
| `fonts` | `~/.local/share/fonts` |
| `gdb` | `~/.gdbinit` |
| `git` | `~/.config/git` |
| `goldendict` | `~/.config/goldendict` |
| `gradle` | `~/.gradle/gradle.properties` |
| `htop` | `~/.config/htop` |
| `i3` | `~/.config/i3` |
| `ideavim` | `~/.ideavimrc` |
| `k9s` | `~/.config/k9s` |
| `kde` | KDE baloo 配置 |
| `kitty` | `~/.config/kitty`（含 kitty-themes 子模块） |
| `libinput-gestures` | `~/.config/libinput-gestures` |
| `litecli` | `~/.config/litecli` |
| `maven` | `~/.m2/settings.xml` |
| `mycli` | `~/.myclirc` |
| `npm` | `~/.npmrc` |
| `nvim` | `~/.config/nvim` |
| `picom` | `~/.config/picom` |
| `polybar` | `~/.config/polybar` |
| `python` | `~/.config/pip` |
| `ranger` | `~/.config/ranger` |
| `readline` | `~/.inputrc` |
| `rofi` | `~/.config/rofi` |
| `terminator` | `~/.config/terminator` |
| `tmux` | `~/.tmux.conf` |
| `vim` | `~/.vimrc` |
| `x11` | `.Xresources`、`.Xmodmap`、`.xinitrc` 等 |
| `yay` | `~/.config/yay` |
| `zathura` | `~/.config/zathura` |
| `zinit` | `~/.local/share/zinit` |
| `zsh` | `~/.zshrc`、`~/.config/zsh` 等 |

## 系统配置包

| 包名 | 内容 |
| --- | --- |
| `apt` | `/etc/apt/sources.list` |
| `buildkit` | `/etc/buildkit/buildkitd.toml` |
| `caddy` | `/etc/caddy` |
| `docker` | `/etc/docker/daemon.json`、systemd proxy 配置 |
| `network` | NetworkManager、resolv 配置 |
| `nfs` | `/etc/exports` |
| `pacman` | `/etc/pacman.conf`、pacman hooks/mirrorlist |
| `proxychains` | `/etc/proxychains.conf` |
| `samba` | `/etc/samba/smb.conf` |
| `sddm` | `/etc/sddm.conf.d` |
| `v2ray` | `/etc/v2ray` |
| `x11` | `/etc/X11/xorg.conf.d` |

## 非 stow 配置

`misc/` 下是按应用分类的手动配置，不会自动 stow，请按需手动复制或导入：

- `clink`：Windows Clink
- `jetbrains`：JetBrains IDE 配色/设置
- `kde`：KDE 快捷键导出方案（`.kksrc`）
- `mathematica`：Wolfram Mathematica
- `obs-studio`：OBS Studio
- `pacman`：Arch 包列表
- `qtcreator`：Qt Creator
- `shadowsocks`：Shadowsocks 客户端
- `switchy-omega`：SwitchyOmega
- `vimium`：Vimium
- `vscode`：VS Code
- `windows-terminal`：Windows Terminal

## 添加新模块

1. 在 `packages/` 下创建模块目录，目录名即模块名。
2. 把要部署到 `$HOME` 的文件按目标相对路径放进去。

例如新增 `lazygit`：

```sh
mkdir -p packages/lazygit/.config/lazygit
cp ~/.config/lazygit/config.yml packages/lazygit/.config/lazygit/config.yml
./install.sh lazygit
```

系统配置同理，放在 `system/<module>/etc/...`，用 `./install.sh -s <module>` 安装。
