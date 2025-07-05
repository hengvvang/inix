# 模块化 NixOS 和 Home Manager 配置系统

## 概述

本配置系统实现了完全模块化的设计，使每个功能模块都可以选择性地开启或关闭。这种设计使得在不同主机上可以有不同的配置组合，同时保持代码的复用性和可维护性。

## 架构说明

### 系统模块 (NixOS)

位于 `system/` 目录，包含以下可选模块：

- **desktop-environment.nix** - 桌面环境配置 (Cosmic/Gnome/KDE)
- **hardware.nix** - 硬件配置 (NVIDIA/音频/触摸板/打印)
- **localization.nix** - 本地化配置 (中文输入法/时区/语言)
- **users.nix** - 用户配置 (用户账户/Docker/SSH)
- **packages.nix** - 系统级软件包

每个模块都有自己的 `mySystem.<模块名>.enable` 选项。

### 用户模块 (Home Manager)

位于 `home/` 目录，包含以下可选模块：

- **apps/** - 应用程序配置
  - editors/ - 编辑器配置 (vim/vscode/zed/micro)
  - shells/ - Shell 配置 (fish/zsh/nushell)
  - terminals/ - 终端配置 (ghostty)
  - yazi/ - 文件管理器配置
- **development/** - 开发环境
  - languages/ - 编程语言支持
  - version-control/ - 版本控制工具
  - embedded/ - 嵌入式开发工具
- **profiles/** - 配置文件
  - env-var/ - 环境变量配置
  - fonts/ - 字体配置
- **toolkits/** - 工具包
  - system/ - 系统工具
  - user/ - 用户工具

每个主要模块都有自己的 `myHome.<模块名>.enable` 选项。

## 主机特定配置

### laptop 配置

当前 laptop 主机配置位于 `hosts/laptop/`，包含：

- **configuration.nix** - NixOS 系统配置入口
- **home.nix** - Home Manager 用户配置入口  
- **modules.nix** - NixOS 模块开关配置
- **home-modules.nix** - Home Manager 模块开关配置
- **hardware-configuration.nix** - 硬件特定配置

在 laptop 配置中，所有模块都默认启用：

```nix
# modules.nix (NixOS)
mySystem = {
  desktop.enable = lib.mkDefault true;
  hardware.enable = lib.mkDefault true;
  localization.enable = lib.mkDefault true;
  users.enable = lib.mkDefault true;
  packages.enable = lib.mkDefault true;
};

# home-modules.nix (Home Manager)  
myHome = {
  apps = {
    enable = lib.mkDefault true;
    yazi.enable = lib.mkDefault true;
    editors.enable = lib.mkDefault true;
  };
  development.enable = lib.mkDefault true;
  profiles.enable = lib.mkDefault true;
  toolkits.enable = lib.mkDefault true;
};
```

## 使用方法

### 构建配置

1. **构建 NixOS 配置**:
   ```bash
   nix build .#nixosConfigurations.hengvvang.config.system.build.toplevel
   ```

2. **构建 Home Manager 配置**:
   ```bash
   nix build .#homeConfigurations.hengvvang.activationPackage
   ```

### 创建新主机配置

要为新主机创建配置：

1. 在 `hosts/` 下创建新主机目录
2. 复制 `laptop/` 下的配置文件
3. 在新的 `modules.nix` 和 `home-modules.nix` 中选择性启用所需模块
4. 更新 `flake.nix` 添加新的配置入口

### 自定义模块组合

通过修改主机的模块配置文件，可以轻松定制不同的配置组合：

```nix
# 例如：服务器配置 - 只启用基础功能
mySystem = {
  desktop.enable = false;        # 无桌面环境
  hardware.enable = true;        # 基础硬件支持
  localization.enable = false;   # 无中文输入法
  users.enable = true;           # 用户和SSH
  packages.enable = false;       # 无图形软件
};
```

## 优势

1. **模块化**: 每个功能模块独立，可选择性启用
2. **可重用**: 模块在不同主机间可复用
3. **易维护**: 配置变更只影响相关模块
4. **灵活**: 不同主机可有完全不同的配置组合
5. **类型安全**: 通过 NixOS 模块系统保证配置正确性

## 测试状态

✅ NixOS 配置构建成功  
✅ Home Manager 配置构建成功  
✅ 所有模块正确启用并工作
