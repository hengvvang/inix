# Dunst - macOS Tahoe 风格通知系统

基于 **Dunst** 的 macOS Tahoe 风格通知系统配置，为 Niri 窗口管理器提供优雅的通知体验。

## ✨ 特性

- 🎨 **macOS Tahoe 风格设计**：模仿 macOS 通知中心的视觉效果
- 🌓 **双主题支持**：深色和浅色主题可切换
- 💎 **毛玻璃效果**：透明背景和模糊效果
- 🎯 **智能分类**：根据应用和内容自动调整样式
- ⌨️ **快捷键支持**：键盘快捷键控制通知
- 🔧 **丰富的脚本**：提供多种实用控制脚本

## 📁 文件结构

```
dunst/
├── config              # 深色主题配置
├── config-light        # 浅色主题配置
├── default.nix         # NixOS 配置
└── README.md          # 说明文档
```

## 🎨 主题样式

### 深色主题 (config)
- 背景色：`#1d1d1f18` (深色毛玻璃)
- 文本色：`#f2f2f7ff` (浅色文本)
- 边框色：`#ffffff10` (半透明白色)
- 适合：深色壁纸和夜间使用

### 浅色主题 (config-light)
- 背景色：`#f2f2f720` (浅色毛玻璃)
- 文本色：`#1d1d1fff` (深色文本)
- 边框色：`#00000015` (半透明黑色)
- 适合：浅色壁纸和日间使用

## 🚀 快速开始

### 1. 启用配置

在你的 NixOS 配置中确保启用了 Niri 桌面环境：

```nix
myHome.desktop = {
  enable = true;
  preset = "niri";
  niri.method = "external";
};
```

### 2. 重建系统

```bash
sudo nixos-rebuild switch
```

### 3. 启动 Dunst

Dunst 会自动启动，或手动启动：

```bash
dunst &
```

## 🎮 控制命令

### 基础控制

```bash
# 显示通知历史
dunst-control show

# 清除所有通知
dunst-control clear

# 关闭当前通知
dunst-control close

# 重新加载配置
dunst-control reload

# 测试通知
dunst-control test
```

### 主题切换

```bash
# 切换到深色主题
dunst-theme-switcher dark

# 切换到浅色主题
dunst-theme-switcher light

# 自动根据系统主题切换
dunst-theme-switcher auto

# 在深浅主题间切换
dunst-theme-switcher toggle
```

### 智能通知

```bash
# 发送智能通知（自动判断优先级）
smart-notify "应用名" "标题" "内容"

# 音量变化通知
volume-notify volume

# 亮度变化通知
volume-notify brightness

# 媒体播放通知
media-notify

# 电池状态通知
battery-notify

# 网络状态通知
network-notify
```

## ⌨️ 快捷键

### 内置快捷键
- `Ctrl + Space`：关闭当前通知
- `Ctrl + Shift + Space`：关闭所有通知
- `Ctrl + \``：显示历史记录
- `Ctrl + Shift + .`：上下文菜单

### 鼠标操作
- **左键**：关闭当前通知
- **中键**：执行操作并关闭
- **右键**：关闭所有通知

## 🎯 通知优先级

### 低优先级 (Low)
- 颜色：淡灰色
- 超时：3秒
- 用途：成功消息、完成通知

### 普通优先级 (Normal)
- 颜色：标准色调
- 超时：5秒
- 用途：一般信息、状态更新

### 高优先级 (Critical)
- 颜色：红色强调
- 超时：永不消失
- 用途：错误、警告、紧急信息

## 🎨 应用样式

### 系统通知
- 背景：蓝色调 (`#007aff20`)
- 用途：系统级别的通知

### 媒体播放器
- 背景：绿色调 (`#32d74b20`)
- 图标：较大 (40-60px)
- 用途：音乐、视频播放器

### 聊天应用
- 背景：紫色调 (`#5856d620`)
- 用途：Discord、Telegram、Signal

### 邮件应用
- 背景：橙色调 (`#ff950020`)
- 用途：邮件客户端

## 🔧 自定义配置

### 修改主题

1. 编辑配置文件：
   ```bash
   vim ~/.config/dunst/dunstrc
   ```

2. 修改颜色值：
   ```ini
   [urgency_normal]
   background = "#你的颜色"
   foreground = "#你的文本颜色"
   ```

3. 重新加载配置：
   ```bash
   dunstctl reload
   ```

### 添加应用规则

在配置文件中添加：

```ini
[appname_你的应用]
background = "#自定义背景色"
foreground = "#自定义文本色"
frame_color = "#自定义边框色"
timeout = 自定义超时时间
```

### 添加内容过滤

```ini
[summary_关键词]
summary = "*关键词*"
background = "#特定背景色"
urgency = critical
```

## 📋 测试命令

```bash
# 基础测试
notify-send "测试" "这是一个测试通知"

# 紧急通知测试
notify-send -u critical "错误" "这是一个错误通知"

# 低优先级测试
notify-send -u low "成功" "操作完成"

# 带图标测试
notify-send -i "dialog-information" "信息" "带图标的通知"

# 进度条测试
notify-send "下载" "正在下载文件..." -h int:value:75
```

## 🛠️ 故障排除

### Dunst 未启动
```bash
# 检查进程
pgrep dunst

# 手动启动
dunst &

# 查看日志
journalctl --user -u dunst
```

### 配置不生效
```bash
# 重新加载配置
dunstctl reload

# 检查配置语法
dunst -config ~/.config/dunst/dunstrc -print
```

### 字体显示问题
确保安装了所需字体：
```bash
# 检查字体
fc-list | grep "LXGW WenKai"
```

### 图标不显示
确保安装了图标主题：
```bash
# 检查图标路径
ls /run/current-system/sw/share/icons/Papirus-Dark
```

## 📚 相关资源

- [Dunst 官方文档](https://dunst-project.org/)
- [Dunst GitHub](https://github.com/dunst-project/dunst)
- [Niri 窗口管理器](https://github.com/YaLTeR/niri)
- [macOS 设计指南](https://developer.apple.com/design/human-interface-guidelines/)

## 🤝 贡献

欢迎提交 Issue 和 Pull Request 来改进这个配置！

## 📄 许可证

本配置遵循 MIT 许可证。