# 输入和鼠标配置

此部分涵盖与鼠标交互、键盘协议和输入行为相关的配置选项。

## 鼠标配置

### mouse_mode
切换启用鼠标模式。在某些配置或终端中，这可能会干扰文本复制。

**可选值:**
- `true` (默认) - 启用鼠标模式
- `false` - 禁用鼠标模式

**注意:** 需要重启生效

```kdl
mouse_mode false
```

### advanced_mouse_actions
是否启用鼠标悬停效果和多选功能（窗格分组）

**可选值:**
- `true` (默认) - 启用高级鼠标操作
- `false` - 禁用高级鼠标操作

```kdl
advanced_mouse_actions false
```

## 复制粘贴配置

### copy_command
执行复制文本时使用的命令。文本将通过 stdin 管道传输到程序来执行复制。适用于不支持 OSC 52 ANSI 控制序列的终端模拟器。

**示例:**
```kdl
copy_command "xclip -selection clipboard"  // X11
copy_command "wl-copy"                     // Wayland
copy_command "pbcopy"                      // macOS
```

### copy_clipboard
选择复制文本的目标位置

**可选值:**
- `"system"` (默认) - 系统剪贴板
- `"primary"` - 主选择缓冲区（X11/Wayland）

**注意:** 使用 `copy_command` 时此选项无效

```kdl
copy_clipboard "primary"
```

### copy_on_select
启用或禁用释放鼠标时自动复制选择内容

**可选值:**
- `true` (默认) - 自动复制选择内容
- `false` - 禁用自动复制

```kdl
copy_on_select false
```

## 键盘协议支持

### support_kitty_keyboard_protocol
启用或禁用对增强型 Kitty 键盘协议的支持（主机终端也必须支持）

**可选值:**
- `true` (默认，如果主机终端支持)
- `false` - 禁用协议支持

**注意:** 需要重启生效

```kdl
support_kitty_keyboard_protocol false
```

## 滚动和缓冲区

### scroll_buffer_size
配置滚动历史缓冲区大小。这是 Zellij 为每个窗格存储的行数。超出的行数将按 FIFO 方式丢弃。

**有效值:** 正整数
**默认值:** 10000

**注意:** 需要重启生效

```kdl
scroll_buffer_size 5000
```

## 样式和渲染

### styled_underlines
切换是否支持扩展的"styled_underlines" ANSI 协议

**可选值:**
- `true` (默认) - 支持样式下划线
- `false` - 忽略样式下划线（可解决某些不支持的终端问题）

```kdl
styled_underlines false
```

## 窗格操作行为

### auto_layout
切换 Zellij 是否根据预定义的布局集合自动排列窗格

**可选值:**
- `true` (默认) - 启用自动布局
- `false` - 禁用自动布局

```kdl
auto_layout false
```

### stacked_resize
在非方向性调整大小时（默认为 `Alt+/-`），尝试与相邻窗格堆叠

**可选值:**
- `true` (默认) - 启用堆叠调整
- `false` - 禁用堆叠调整

```kdl
stacked_resize false
```

## 输入模式建议

对于不同的使用场景，建议的配置组合：

### 最小干扰模式
```kdl
mouse_mode false
copy_on_select false
simplified_ui true
```

### 高性能模式
```kdl
scroll_buffer_size 1000
advanced_mouse_actions false
styled_underlines false
```

### 触摸板友好模式
```kdl
mouse_mode true
advanced_mouse_actions true
copy_on_select true
```
