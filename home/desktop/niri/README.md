# Niri 桌面环境配置

这是一个完整的 Niri 桌面环境配置，专为 NixOS 系统设计，采用模块化结构。

## 功能特性

### 🚀 核心功能
- **滚动平铺窗口管理**: Niri 独特的无限水平滚动布局
- **现代动画效果**: 流畅的窗口切换和工作区动画
- **完整的 Wayland 支持**: 原生 Wayland 应用体验
- **多显示器支持**: 每个显示器独立的工作区

### 🎨 视觉效果
- **渐变边框**: 活动窗口的炫酷渐变边框效果
- **聚焦环**: 清晰的窗口聚焦指示
- **自定义颜色主题**: 基于紫色调的现代配色
- **响应式布局**: 支持不同分辨率的显示器

### ⚙️ 集成组件
- **Waybar**: 功能丰富的状态栏，支持 Niri 工作区
- **Fuzzel**: 现代化的应用启动器
- **Dunst**: 美观的通知系统
- **Swaylock**: 安全的屏幕锁定
- **XWayland-satellite**: X11 应用兼容层

## 安装和使用

### 1. 启用配置

在你的 NixOS 配置中启用 Niri:

```nix
# 系统配置
mySystem.desktop = {
  enable = true;
  preset = "niri";
};

# Home Manager 配置
myHome.desktop = {
  enable = true;
  niri = {
    enable = true;
    method = "external";
  };
};
```

### 2. 重建系统

```bash
sudo nixos-rebuild switch
home-manager switch
```

### 3. 启动 Niri

从 GDM 登录界面选择 "Niri" 会话，或者在 TTY 中运行：

```bash
niri-session
```

## 快捷键指南

### 🚀 应用启动
- `Super + T`: 启动终端 (Alacritty)
- `Super + D`: 应用启动器 (Fuzzel)
- `Super + E`: 文件管理器 (Nautilus)
- `Super + B`: 浏览器 (Firefox)
- `Super + C`: 代码编辑器 (VSCode)

### 🪟 窗口管理
- `Super + Q`: 关闭窗口
- `Super + H/L` 或 `Super + ←/→`: 左右切换列
- `Super + J/K` 或 `Super + ↑/↓`: 上下切换窗口
- `Super + Ctrl + H/L`: 移动列
- `Super + Ctrl + J/K`: 移动窗口

### 📱 工作区操作
- `Super + U/I` 或 `Super + PageDown/PageUp`: 切换工作区
- `Super + 1-0`: 切换到数字工作区
- `Super + Ctrl + 1-0`: 移动窗口到数字工作区
- `Super + Tab`: 概览模式

### 🎛️ 窗口调整
- `Super + R`: 切换预设列宽
- `Super + Shift + R`: 切换预设窗口高度
- `Super + F`: 最大化列
- `Super + Shift + F`: 全屏窗口
- `Super + -/=`: 调整列宽
- `Super + Shift + -/=`: 调整窗口高度

### 🔄 列操作
- `Super + ,`: 合并右侧窗口到当前列
- `Super + .`: 分离列底部窗口
- `Super + [/]`: 左右合并/分离窗口

### 🎨 特殊功能
- `Super + V`: 切换浮动窗口
- `Super + Shift + V`: 切换浮动/平铺布局焦点
- `Super + Alt + L`: 锁屏
- `Super + Shift + E`: 退出 Niri

### 📸 截图和媒体
- `Print`: 区域截图
- `Alt + Print`: 窗口截图
- `Ctrl + Print`: 全屏截图
- `Shift + Print`: 区域截图到剪贴板
- `音量键`: 音量控制
- `亮度键`: 亮度调节

## 配置文件结构

```
home/desktop/niri/external/
├── niri/
│   └── config.kdl              # Niri 主配置文件
├── waybar/
│   ├── config                  # Waybar 配置
│   └── style.css              # Waybar 样式
├── fuzzel/
│   └── fuzzel.ini             # Fuzzel 启动器配置
├── dunst/
│   └── dunstrc                # Dunst 通知配置
├── swaylock/
│   └── config                 # Swaylock 锁屏配置
└── scripts/
    ├── screenshot.sh          # 截图脚本
    ├── volume.sh             # 音量控制脚本
    ├── brightness.sh         # 亮度控制脚本
    └── toggle-display.sh     # 显示器切换脚本
```

## 自定义配置

### 修改主题颜色

编辑 `niri/config.kdl` 中的颜色设置：

```kdl
border {
    active-color "#你的颜色"
    active-gradient from="#起始色" to="#结束色" angle=45
}
```

### 调整工作区

修改 `waybar/config` 中的工作区设置：

```json
"persistent-workspaces": {
    "1": [],
    "2": [],
    "3": [],
    "4": [],
    "5": []
}
```

### 自定义快捷键

在 `niri/config.kdl` 的 `binds` 部分添加或修改快捷键：

```kdl
"Mod+你的按键" { spawn "你的命令"; }
```

## 故障排除

### 黑屏问题
如果启动 Niri 后出现黑屏，尝试：
1. 检查显卡驱动是否正确安装
2. 确认内核模式设置已启用
3. 查看 `journalctl -u display-manager` 日志

### X11 应用问题
如果 X11 应用无法运行：
1. 确认 `xwayland-satellite` 服务正在运行
2. 检查环境变量设置是否正确

### 性能问题
如果遇到性能问题：
1. 禁用动画：在 `config.kdl` 中设置 `animations { off true }`
2. 调整渲染设备：修改 `debug` 部分的 `render-drm-device`

## 参考资源

- [Niri 官方文档](https://github.com/YaLTeR/niri/wiki)
- [Niri 配置参考](https://github.com/YaLTeR/niri/wiki/Configuration:-Introduction)
- [Waybar 模块文档](https://github.com/Alexays/Waybar/wiki/Module:-Niri)
- [NixOS Wayland 指南](https://nixos.wiki/wiki/Wayland)

## 贡献

欢迎提交 Issue 和 Pull Request 来改进这个配置！
