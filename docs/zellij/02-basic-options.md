# 基本选项配置 (Options)

基本选项可以直接在配置文件根级别设置，控制 Zellij 的全局行为。

## 会话和退出行为

### on_force_close
当 Zellij 接收到 SIGTERM、SIGINT、SIGQUIT 或 SIGHUP 信号时的行为（如终端窗口被关闭）

**可选值:**
- `"detach"` (默认) - 分离会话，保持后台运行
- `"quit"` - 直接退出会话

```kdl
on_force_close "quit"
```

### mirror_session
在多用户附加到现有会话时的行为模式

**可选值:**
- `true` - 镜像模式，所有用户共享光标
- `false` (默认) - 独立模式，每个用户有自己的光标

```kdl
mirror_session true
```

## 界面显示选项

### simplified_ui
向插件请求简化界面（不使用箭头字体）

**可选值:**
- `true` - 启用简化界面
- `false` (默认) - 使用标准界面

```kdl
simplified_ui true
```

### pane_frames
切换窗格周围是否显示边框

**可选值:**
- `true` (默认) - 显示窗格边框
- `false` - 隐藏窗格边框

```kdl
pane_frames false
```

### rounded_corners
设置窗格边框（如果可见）是否应该有圆角

```kdl
ui {
    pane_frames {
        rounded_corners true
    }
}
```

### hide_session_name
在界面中隐藏会话名称

```kdl
ui {
    pane_frames {
        hide_session_name true
    }
}
```

### show_startup_tips
在 Zellij 启动时显示使用技巧

**可选值:**
- `true` (默认) - 显示启动技巧
- `false` - 不显示启动技巧

```kdl
show_startup_tips false
```

### show_release_notes
在新版本首次运行时显示发布说明

**可选值:**
- `true` (默认) - 显示发布说明
- `false` - 不显示发布说明

```kdl
show_release_notes false
```

## Shell 和编辑器配置

### default_shell
Zellij 用于打开新窗格的默认 shell 路径

**默认值:** `$SHELL` 环境变量

```kdl
default_shell "fish"
```

### scrollback_editor
用于编辑窗格滚动缓冲区以及 CLI 和布局 `edit` 命令的默认编辑器路径

**默认值:** `$EDITOR` 或 `$VISUAL` 环境变量

```kdl
scrollback_editor "/usr/bin/vim"
```

## 主题和布局

### theme
指定要使用的 Zellij 颜色主题名称

**默认值:** `"default"`

```kdl
theme "dracula"
```

### default_layout
启动时加载的布局名称（必须在 layouts 文件夹中）

**默认值:** `"default"`

```kdl
default_layout "compact"
```

### default_mode
Zellij 启动时使用的模式

**可选值:**
- `"normal"` (默认) - 普通模式
- `"locked"` - 锁定模式

```kdl
default_mode "locked"
```

## 目录配置

### layout_dir
Zellij 查找布局文件的文件夹路径

```kdl
layout_dir "/path/to/my/layout_dir"
```

### theme_dir
Zellij 查找主题文件的文件夹路径

```kdl
theme_dir "/path/to/my/theme_dir"
```

## 环境变量

### env
为 Zellij 启动的每个终端窗格设置的环境变量键值映射

```kdl
env {
    RUST_BACKTRACE "1"
    FOO "bar"
    EDITOR "nvim"
}
```
