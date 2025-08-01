# Personal NixOS Configuration

一个模块化的 NixOS 配置，支持多用户、多主机以及多桌面环境。基于 Flake 构建，使用 Home Manager 进行用户配置管理。

## 🖥️ 支持的桌面环境

### 完整桌面环境
| 桌面环境  | 状态 | 描述 |
|-----------|------|------|
| KDE       | ✅   | Plasma 桌面环境 |
| GNOME     | ✅   | GNOME 桌面环境 |
| Cosmic    | ✅   | System76 的 Cosmic 桌面 |

### Wayland 窗口管理器
| 窗口管理器 | 状态 | 描述 |
|------------|------|------|
| Hyprland   | ✅   | 基于 wlroots 的动态平铺合成器 |
| Niri       | ✅   | 基于 Smithay 的滚动平铺合成器 |

## 📂 配置方法

本项目为 dotfiles 提供了三种配置方法：

### 1. Direct（直接配置）
适合轻量级配置，直接使用模板文件。

### 2. External（外部配置）
最简单的配置方式，无需深入了解 Home Manager 配置文档。配置文件存放在外部目录中。

### 3. Home Manager（原生配置）
更符合 Nix 哲学，但依赖社区支持。直接在 Nix 配置中定义。

> **注意**: 由于我只使用其中一部分工具，无法保证所有配置都能正常工作。

## 🛠️ 支持的工具

### Shell
- **Fish** - 用户友好的 shell
- **Bash** - 传统 shell
- **Zsh** - 高级 shell
- **Nushell** - 现代结构化 shell

### 终端模拟器
- **Alacritty** - GPU 加速终端
- **Ghostty** - 现代终端模拟器
- **Rio** - 硬件加速终端

### 终端多路复用器
- **Tmux** - 传统终端多路复用器
- **Zellij** - 现代终端多路复用器

### 文件管理器
- **Yazi** - 终端文件管理器

### 编辑器
- **Vim** - 经典编辑器
- **VS Code** - 现代编辑器
- **Zed** - 高性能编辑器

### 其他工具
- **Rmpc** - MPD 客户端
- **Starship** - 跨 shell 提示符
- **Git & Lazygit** - 版本控制
- **Rofi** - 应用启动器
- 等等...

## 📁 项目结构

```
├── flake.nix              # 主 Flake 配置文件
├── flake.lock            # 锁定文件
├── home/                 # Home Manager 配置
│   ├── desktop/          # 桌面环境配置
│   │   ├── cosmic/       # Cosmic 桌面
│   │   ├── gnome/        # GNOME 桌面
│   │   ├── kde/          # KDE 桌面
│   │   ├── hyprland/     # Hyprland 窗口管理器
│   │   └── niri/         # Niri 窗口管理器
│   ├── develop/          # 开发环境配置
│   ├── dotfiles/         # 各种工具的配置文件
│   ├── pkgs/             # 用户级软件包
│   ├── profiles/         # 用户配置文件（字体、主题等）
│   └── services/         # 用户服务
├── hosts/                # 主机配置
│   ├── host1/            # 主机1配置
│   ├── host2/            # 主机2配置
│   └── host3/            # 主机3配置
├── system/               # 系统级配置
│   ├── desktop/          # 系统级桌面配置
│   ├── locale/           # 本地化配置
│   ├── pkgs/             # 系统级软件包
│   ├── profiles/         # 系统配置文件
│   └── services/         # 系统服务
├── users/                # 用户配置
├── lib/                  # 自定义库函数
├── overlays/             # Nix overlays
└── pkgs/                 # 自定义软件包
```

## 🔧 工作原理

配置系统基于模块化设计：

```
flake.nix  <--  host/* (启用功能)  <--  system/* (定义功能)
           <--  user/* (启用功能)  <--  home/* (定义功能)
```

### 系统配置层次
- **system/desktop/** - 桌面环境系统级配置
- **system/locale/** - 语言和输入法配置
- **system/pkgs/** - 系统级软件包分类
- **system/services/** - 系统服务配置

### 用户配置层次
- **home/desktop/** - 桌面环境用户级配置
- **home/develop/** - 开发环境配置
- **home/dotfiles/** - 各种工具的配置文件
- **home/services/** - 用户级服务

## 🚀 快速开始

1. 克隆仓库：
```bash
git clone <repository-url> ~/.config/nixos
cd ~/.config/nixos
```

2. 根据你的需求修改主机配置（`hosts/` 目录）

3. 构建并切换配置：
```bash
sudo nixos-rebuild switch --flake .#<hostname>
```

4. 应用 Home Manager 配置：
```bash
home-manager switch --flake .#<username>@<hostname>
```

## 📝 使用说明

### 启用桌面环境

在你的主机配置中设置：
```nix
# 启用桌面环境
mySystem.desktop.enable = true;
mySystem.desktop.preset = "hyprland";  # 或 "niri", "gnome", "kde", "cosmic"
```

### 配置用户环境

在用户配置中启用所需功能：
```nix
# 启用桌面配置
myHome.desktop.enable = true;
myHome.desktop.hyprland.enable = true;  # 对应的桌面环境

# 启用 dotfiles
myHome.dotfiles.fish.enable = true;
myHome.dotfiles.starship.enable = true;
```

## 🔍 特别说明

### Niri 配置
- 使用 External 方法配置，配置文件位于 `home/desktop/niri/external/`
- 包含完整的 Wayland 生态系统工具
- 已去除终端配置（使用你的 dotfiles 配置）
- 专注于桌面环境核心功能

### Hyprland 配置
- 提供完整的 Hyprland 生态系统
- 包含系统级和用户级配置
- 支持 XWayland 应用

## 📚 文档

更多详细文档请查看 `docs/` 目录：
- [文件名解耦指南](docs/file-name-decoupling.md)
- [Flatpak 与 Nixpkgs 冲突解决](docs/flatpak-nixpkgs-conflict-resolution.md)
- [Mihomo 使用指南](docs/mihomo-usage-guide.md)
- [MPD + RMPC 设置指南](docs/mpd-rmpc-setup-guide.md)
- [代理服务设置指南](docs/proxy-services-setup-guide.md)
- 等等...

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

本项目采用 MIT 许可证。
```
