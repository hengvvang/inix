# Niri 桌面环境配置指南

## 概述

Niri 是一个基于 Rust 和 Smithay 的现代 Wayland 合成器，采用滚动平铺窗口管理方式。本项目为 Niri 提供了完整的桌面环境配置。

## 配置结构

```
home/desktop/niri/
├── default.nix              # 主模块，选项定义
└── external/                # 外部配置方法
    ├── default.nix          # Home Manager 配置
    ├── niri/
    │   └── config.kdl       # Niri 核心配置文件
    ├── waybar/              # 状态栏配置
    ├── dunst/               # 通知系统配置
    ├── fuzzel/              # 应用启动器配置
    ├── swaylock/            # 屏幕锁定配置
    └── scripts/             # 实用脚本
```

## 启用 Niri

### 系统级配置

在你的主机配置中：

```nix
# 启用桌面环境
mySystem.desktop.enable = true;
mySystem.desktop.preset = "niri";
```

### 用户级配置

在你的用户配置中：

```nix
# 启用 Niri 桌面
myHome.desktop.enable = true;
myHome.desktop.niri.enable = true;
myHome.desktop.niri.method = "external";
```

## 核心组件

### 1. Niri 合成器
- **配置文件**: `external/niri/config.kdl`
- **语法**: KDL (KuDL Document Language)
- **功能**: 窗口管理、键盘绑定、动画设置

### 2. Waybar 状态栏
- **配置文件**: `external/waybar/config.json` 和 `style.css`
- **功能**: 系统状态显示、工作区切换

### 3. Fuzzel 应用启动器
- **配置文件**: `external/fuzzel/fuzzel.ini`
- **启动**: `Super + D`

### 4. Dunst 通知系统
- **配置文件**: `external/dunst/dunstrc`
- **功能**: 桌面通知显示

### 5. Swaylock 屏幕锁定
- **配置文件**: `external/swaylock/config`
- **启动**: `Super + L`

## 包含的软件包

### 核心工具
- `niri` - 窗口管理器
- `niriswitcher` - 应用切换器
- `xwayland-satellite` - X11 应用支持

### 系统工具
- `grim` + `slurp` + `swappy` - 截图工具链
- `wl-clipboard` + `cliphist` - 剪贴板管理
- `brightnessctl` + `pamixer` + `playerctl` - 系统控制

### 桌面组件
- `waybar` - 状态栏
- `dunst` - 通知系统
- `fuzzel` - 应用启动器
- `swaylock` + `swayidle` - 锁屏和空闲管理
- `swaybg` - 壁纸设置

### 系统集成
- `xdg-desktop-portal-gnome` - 桌面门户
- `networkmanagerapplet` - 网络管理
- `blueman` - 蓝牙管理
- `polkit-kde-agent-1` - 权限认证

## 系统服务

所有桌面组件都通过 systemd 用户服务管理：

- `waybar.service` - 状态栏
- `dunst.service` - 通知守护进程
- `nm-applet.service` - 网络管理器托盘
- `blueman-applet.service` - 蓝牙托盘
- `polkit-kde-agent.service` - 权限认证代理
- `xwayland-satellite.service` - XWayland 支持

## 实用脚本

### 截图脚本 (`scripts/screenshot.sh`)
- 全屏截图
- 区域截图
- 活动窗口截图

### 亮度控制 (`scripts/brightness.sh`)
- 增加/减少亮度
- 发送通知显示当前亮度

### 音量控制 (`scripts/volume.sh`)
- 音量调节
- 静音切换
- 通知显示

### 显示器切换 (`scripts/toggle-display.sh`)
- 外接显示器管理
- 分辨率切换

## 键盘快捷键（默认）

### 窗口管理
- `Super + Q` - 关闭窗口
- `Super + M` - 最大化/还原窗口
- `Super + F` - 全屏切换

### 导航
- `Super + H/J/K/L` - 窗口焦点移动
- `Super + Shift + H/J/K/L` - 窗口移动
- `Super + 1-9` - 工作区切换

### 应用启动
- `Super + Return` - 启动终端
- `Super + D` - 应用启动器
- `Super + L` - 锁屏

### 系统控制
- `Super + Print` - 截图
- `XF86AudioRaiseVolume/LowerVolume` - 音量控制
- `XF86MonBrightnessUp/Down` - 亮度控制

## 自定义配置

### 修改 Niri 设置
编辑 `external/niri/config.kdl` 文件，参考 [Niri 官方文档](https://github.com/YaLTeR/niri)。

### 自定义状态栏
修改 `external/waybar/config.json` 和 `style.css`。

### 更改主题
通过 Stylix 系统统一管理主题，或直接修改各组件的配置文件。

## 故障排除

### 检查服务状态
```bash
systemctl --user status waybar
systemctl --user status dunst
```

### 查看日志
```bash
journalctl --user -u waybar
journalctl --user -u dunst
```

### 重启服务
```bash
systemctl --user restart waybar
systemctl --user restart dunst
```

## 与其他桌面环境的兼容性

Niri 配置设计为独立运行，不会与其他桌面环境产生冲突。可以在同一系统中同时配置多个桌面环境。

## 注意事项

1. **终端配置**: 本配置不包含终端配置，请使用你现有的 dotfiles 配置
2. **X11 应用**: 通过 xwayland-satellite 支持 X11 应用
3. **性能**: Niri 是一个相对较新的合成器，某些功能可能仍在开发中
4. **依赖**: 确保系统级 Niri 配置已启用

## 参考资料

- [Niri 官方文档](https://github.com/YaLTeR/niri)
- [Wayland 协议](https://wayland.freedesktop.org/)
- [KDL 语法指南](https://kdl.dev/)
