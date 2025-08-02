# Niri Waybar 配置说明

## 概述
这是一个专为 Niri 窗口管理器设计的 Waybar 配置，采用了 Rose Pine 主题配色方案。

## 功能特性

### 布局结构
- **左侧模块**: 工作区、窗口标题
- **中间模块**: 时钟
- **右侧模块**: 系统托盘、待机抑制器、音频、网络、CPU、内存、温度、电池、语言

### Niri 特定模块

#### 工作区 (niri/workspaces)
- 支持图标显示不同状态的工作区
- 支持命名工作区（需要在 niri 配置中设置）
- 鼠标滚轮切换工作区
- 图标含义：
  - `󰊠` - 当前焦点工作区
  - `󰮯` - 活跃工作区
  - `󰑊` - 默认/空工作区
  - 特殊图标用于命名工作区（浏览器、代码、终端等）

#### 窗口标题 (niri/window)
- 显示当前聚焦窗口的标题
- 支持应用图标
- 智能重写规则，为常见应用显示友好名称
- 根据应用类型改变状态栏颜色

#### 语言切换 (niri/language)
- 显示当前键盘布局
- 支持自定义语言显示格式

### Rose Pine 主题配色

采用 Rose Pine Main 配色方案：

- **Base**: `#191724` (主背景)
- **Surface**: `#1f1d2e` (次要背景)
- **Overlay**: `#26233a` (第三级背景)
- **Text**: `#e0def4` (主文本)
- **Love**: `#eb6f92` (错误/警告)
- **Gold**: `#f6c177` (高亮/时钟)
- **Pine**: `#31748f` (网络/电池)
- **Foam**: `#9ccfd8` (音频/信息)
- **Iris**: `#c4a7e7` (CPU/交互)
- **Rose**: `#ebbcba` (内存/装饰)

### 交互功能

#### 鼠标操作
- **工作区**：点击切换，滚轮上下切换
- **音频**：左键静音，右键打开音量控制，滚轮调节音量
- **网络**：点击打开网络管理器
- **时钟**：右键切换显示模式，滚轮调节日历
- **温度**：点击显示传感器信息

#### 状态指示
- **电池**：根据电量显示不同颜色，低电量时闪烁
- **CPU/内存**：超过阈值时改变颜色
- **网络**：断线时显示警告色
- **待机抑制器**：激活时高亮显示

## 配置要求

### 依赖项
- Niri >= 0.1.9
- Waybar
- 支持 Nerd Font 的字体（推荐 JetBrainsMono Nerd Font）

### Niri 配置
确保在 niri 配置中启用了相应的功能：

```kdl
// 在 niri 配置中启用 IPC
ipc {
    // IPC 套接字路径（可选）
}

// 如果使用命名工作区，需要在这里定义
workspace "browser" 
workspace "code"
workspace "terminal"
// 等等...
```

### 系统命令
配置中使用了以下系统命令，请确保已安装：
- `pactl` (PulseAudio 控制)
- `pavucontrol` (音量控制面板)
- `nm-connection-editor` (网络管理器)
- `sensors` (硬件传感器)

## 自定义

### 修改颜色主题
如果要使用其他 Rose Pine 变体：

- **Rose Pine Moon**: 替换 `style.css` 中的颜色值为 Moon 配色
- **Rose Pine Dawn**: 替换为 Dawn 配色（浅色主题）

### 添加/移除模块
在 `config` 文件的相应数组中添加或移除模块：

```json
"modules-left": ["niri/workspaces", "niri/window"],
"modules-center": ["clock"],
"modules-right": ["tray", "idle_inhibitor", "pulseaudio", "network", "cpu", "memory", "temperature", "battery", "niri/language"]
```

### 调整温度监控
修改 `temperature` 模块的路径以匹配您的系统：

```json
"temperature": {
    "thermal-zone": 0,
    "hwmon-path": "/sys/class/hwmon/hwmon2/temp1_input",
    // 或者使用 "thermal-zone": 1 等其他值
}
```

## 故障排除

### 常见问题

1. **工作区不显示**: 确保 Niri 版本 >= 0.1.9
2. **字体图标显示为方框**: 安装 Nerd Font 字体
3. **温度不显示**: 检查并调整 `hwmon-path` 或 `thermal-zone`
4. **网络模块无响应**: 确保 NetworkManager 正在运行

### 日志调试
运行 waybar 时加入调试参数：

```bash
waybar -l debug
```

### 测试配置
在终端中测试配置：

```bash
waybar -c ~/.config/waybar/config -s ~/.config/waybar/style.css
```

## 更新和维护

定期检查：
- Niri 新版本的功能更新
- Waybar 模块的新选项
- Rose Pine 主题的更新

配置文件位置：
- 配置: `~/.config/waybar/config`
- 样式: `~/.config/waybar/style.css`
