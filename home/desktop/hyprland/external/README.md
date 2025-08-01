# Hyprland External 配置

这是一个完全重新配置的 Hyprland external 配置，基于您的 Cosmic 桌面快捷键映射，遵循 Hyprland 最佳实践。

## ✨ 主要特性

### 🎨 主题
- 使用 **Catppuccin Mocha** 主题
- 统一的深色主题配色
- 圆角设计和现代视觉效果

### ⌨️ 快捷键 (基于 Cosmic 配置)

#### 🔧 系统快捷键
- `Super + Enter` - 打开终端 (rio)
- `Super` - 应用启动器 (rofi)
- `Super + E` - 文件管理器 (nautilus)
- `Super + Shift + Q` - 退出 Hyprland
- `Super + Q` - 关闭当前窗口
- `Super + L` - 锁定屏幕

#### 🪟 窗口管理
- `Super + Ctrl + F` - 切换窗口浮动
- `Super + Ctrl + T` - 切换平铺模式
- `Super + N` - 最小化窗口
- `Super + P` - 切换窗口置顶
- `Super + S` - 切换布局方向
- `Super + Ctrl + S` - 切换堆叠模式
- `Super + F` - 全屏切换

#### 🎯 窗口焦点
- `Super + ←/→/↑/↓` - 移动焦点
- `Super + H/J/K/L` - Vim 风格焦点移动
- `Super + O` - 切换显示器焦点

#### 📱 工作区切换 (基于 Cosmic)
- `Super + Ctrl + 1-9` - 切换到工作区 1-9
- `Super + Ctrl + Shift + 1-8` - 移动窗口到工作区 1-8
- `Super + Ctrl + Shift + 9` - 移动到上一个工作区

#### 📸 截图
- `Print` - 区域截图并复制
- `Shift + Print` - 全屏截图并复制
- `Ctrl + Print` - 区域截图并保存
- `Super + Print` - 区域截图并通知

#### 🔊 系统控制
- `音量键` - 音量控制
- `亮度键` - 亮度控制
- `媒体键` - 媒体播放控制

#### 🛠️ 实用工具
- `Super + V` - 剪贴板历史
- `Super + Shift + C` - 颜色选择器
- `Alt + Tab` - 窗口选择器
- `Super + Shift + E` - 电源菜单

## 📦 包含的软件

### 核心工具
- `hyprpicker` - 颜色选择器
- `hyprpaper` - 壁纸管理
- `hypridle` - 空闲管理
- `hyprlock` - 屏幕锁定

### 截图工具
- `grimblast` - Hyprland 优化截图工具
- `grim` + `slurp` - Wayland 截图工具
- `swappy` - 截图编辑器

### 界面工具
- `waybar` - 状态栏
- `dunst` - 通知守护进程
- `rofi-wayland` - 应用启动器
- `wlogout` - 电源菜单

### 系统工具
- `brightnessctl` - 亮度控制
- `pamixer` - 音量控制
- `playerctl` - 媒体控制
- `cliphist` - 剪贴板历史
- `networkmanagerapplet` - 网络管理
- `blueman` - 蓝牙管理

## 📁 配置文件结构

```
home/desktop/hyprland/external/
├── default.nix                    # 主配置文件
├── hypr/
│   ├── hyprland.conf              # Hyprland 主配置
│   ├── hypridle.conf              # 空闲管理配置
│   ├── hyprlock.conf              # 屏幕锁定配置
│   ├── hyprpaper.conf             # 壁纸配置
│   └── themes/
│       └── catppuccin.conf        # Catppuccin 主题
├── waybar/
│   ├── config                     # Waybar 配置
│   └── style.css                  # Waybar 样式
├── dunst/
│   └── dunstrc                    # 通知配置
├── rofi/
│   └── config.rasi                # Rofi 配置
├── swappy/
│   └── config                     # 截图编辑器配置
└── wlogout/
    ├── layout                     # 电源菜单布局
    └── style.css                  # 电源菜单样式
```

## 🚀 启动过程

系统启动时会自动启动以下服务：
1. Waybar (状态栏)
2. Dunst (通知)
3. Hyprpaper (壁纸)
4. Hypridle (空闲管理)
5. NetworkManager 托盘
6. 蓝牙管理器
7. 剪贴板历史服务

## 🎨 视觉效果

- **动画**: 流畅的窗口动画和过渡效果
- **模糊**: 半透明窗口的模糊效果
- **圆角**: 8px 圆角设计
- **阴影**: 窗口投影效果
- **边框**: 彩色窗口边框

## ⚙️ 自定义

### 修改主题
编辑 `hypr/themes/catppuccin.conf` 来调整颜色方案。

### 修改快捷键
编辑 `hypr/hyprland.conf` 中的 `bind` 部分。

### 修改状态栏
编辑 `waybar/config` 和 `waybar/style.css`。

### 修改壁纸
1. 将壁纸放到 `~/Pictures/Wallpapers/wallpaper.jpg`
2. 或修改 `hypr/hyprpaper.conf` 中的路径

## 📝 注意事项

1. 确保您的壁纸路径正确设置
2. 某些功能需要额外的系统配置 (如多媒体键)
3. 首次使用时请检查所有快捷键是否正常工作
4. 如需调整，请参考 [Hyprland 官方文档](https://wiki.hyprland.org/)

## 🔧 故障排除

如果遇到问题：
1. 检查 Hyprland 日志: `journalctl -u hyprland`
2. 重新加载配置: `Super + Shift + R`
3. 检查依赖包是否正确安装
4. 确保环境变量正确设置
