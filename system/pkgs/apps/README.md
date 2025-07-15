# 月相应用分类系统 🌙

本系统按照月相周期将应用程序分为八个阶段，从系统必需的核心工具到高级娱乐应用，重要性逐渐降低。

## 月相配置 (按重要性排序)

### 🌑 新月 - 系统核心基础 ⭐⭐⭐⭐⭐
**系统运行绝对必需**
- vim, nano, curl, wget, git, htop, procps

### 🌒 峨眉月 - 基础终端增强 ⭐⭐⭐⭐
**基础命令行体验改善**
- fish, zsh, alacritty, bat, eza, fd, ripgrep

### 🌓 上弦月 - 高级终端和基础开发 ⭐⭐⭐
**高级终端功能和基础开发**
- nushell, starship, tmux, yazi, neovim, lazygit

### 🌔 盈凸月 - 完整开发环境 ⭐⭐⭐
**完整编程工具链**
- helix, nodejs, python3, rust, docker, gdb

### 🌕 满月 - 桌面办公套件 ⭐⭐
**基础桌面应用**
- firefox, chromium, libreoffice, thunderbird

### 🌖 亏凸月 - 高级生产力工具 ⭐⭐
**系统管理和高级功能**
- okular, bitwarden, timeshift, valgrind

### 🌗 下弦月 - 媒体和创意工具 ⭐
**多媒体处理**
- gimp, inkscape, vlc, obs-studio, kdenlive

### 🌘 残月 - 通讯娱乐套件 ⭐
**社交、游戏、娱乐**
- discord, telegram, steam, spotify, blender

## 配置示例

### 基础系统 (laptop)
```nix
mySystem.pkgs.apps = {
  enable = true;
  newMoon.enable = true;        # 🌑 系统核心
  waxingCrescent.enable = true; # 🌒 基础终端
  # 其他禁用
};
```

### 工作站 (work)
```nix
mySystem.pkgs.apps = {
  enable = true;
  newMoon.enable = true;        # 🌑 系统核心
  waxingCrescent.enable = true; # 🌒 基础终端
  firstQuarter.enable = true;   # 🌓 高级终端开发
  waxingGibbous.enable = true;  # 🌔 完整开发环境
  fullMoon.enable = true;       # 🌕 桌面办公
  # 其他按需
};
```

### 日常使用 (daily)
```nix
mySystem.pkgs.apps = {
  enable = true;
  newMoon.enable = true;        # 🌑 系统核心
  waxingCrescent.enable = true; # 🌒 基础终端
  firstQuarter.enable = true;   # 🌓 高级终端开发
  fullMoon.enable = true;       # 🌕 桌面办公
  lastQuarter.enable = true;    # 🌗 媒体创意
  waningCrescent.enable = true; # 🌘 通讯娱乐
};
```

## 设计原则

1. **渐进性**: 从必需到可选，重要性逐级递减
2. **模块化**: 每个阶段独立，可自由组合
3. **简洁性**: 精简配置，易于理解和维护
4. **实用性**: 前两个阶段提供完整的命令行环境
