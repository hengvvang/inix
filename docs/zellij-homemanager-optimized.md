# Zellij Home Manager 配置优化文档

## 概述

本文档描述了优化后的 Zellij Home Manager 配置，基于 [mynixos.com](https://mynixos.com) 和 [Zellij 官方文档](https://zellij.dev/documentation) 的最佳实践。

## 配置特性

### 1. Shell 集成
- **Fish 集成**: 启用 Fish shell 集成（`enableFishIntegration = true`）
- **Bash 集成**: 启用 Bash 集成作为备用（`enableBashIntegration = true`）
- **Zsh 集成**: 禁用未使用的 Zsh 集成以减少资源占用

### 2. 自动启动和会话管理
- **自动附加**: 启动时自动附加到现有会话（`attachExistingSession = true`）
- **保持 Shell**: Zellij 退出时不退出底层 shell（`exitShellOnExit = false`）
- **会话序列化**: 启用会话持久化，重启后可恢复（`session_serialization = true`）
- **序列化间隔**: 每5分钟自动保存会话状态（`serialization_interval = 300`）

### 3. 用户界面设置
- **主题**: 使用默认主题，可轻松切换到其他内置主题
- **窗格边框**: 启用带圆角的窗格边框（`pane_frames = true`, `rounded_corners = true`）
- **完整 UI**: 使用带图标字体的完整界面（`simplified_ui = false`）
- **会话名显示**: 显示会话名称（`hide_session_name = false`）

### 4. 鼠标和复制功能
- **鼠标支持**: 完全启用鼠标操作（`mouse_mode = true`）
- **自动复制**: 选择文本时自动复制到剪贴板（`copy_on_select = true`）
- **系统剪贴板**: 复制到系统剪贴板而非主选择缓冲区（`copy_clipboard = "system"`）
- **复制命令**: 提供 Wayland 和 X11 的复制命令示例（已注释）

### 5. 滚动和历史
- **滚动缓冲区**: 每个窗格保存 10,000 行历史（`scroll_buffer_size = 10000`）
- **滚动编辑器**: 使用 vim 编辑滚动缓冲区（`scrollback_editor = "vim"`）
- **视图序列化**: 禁用窗格视图序列化以节省资源（`pane_viewport_serialization = false`）

### 6. 布局和窗格管理
- **默认布局**: 使用标准默认布局（`default_layout = "default"`）
- **自动布局**: 启用智能自动布局管理（`auto_layout = true`）
- **堆叠调整**: 调整大小时尝试堆叠相邻窗格（`stacked_resize = true`）
- **默认模式**: 以普通模式启动（`default_mode = "normal"`）

### 7. 高级功能
- **样式化下划线**: 支持扩展 ANSI 下划线协议（`styled_underlines = true`）
- **镜像会话**: 多用户时各自独立光标（`mirror_session = false`）
- **强制关闭**: 收到关闭信号时分离而非退出（`on_force_close = "detach"`）

### 8. 用户体验优化
- **启动提示**: 禁用启动提示以获得干净启动（`show_startup_tips = false`）
- **发布说明**: 禁用自动显示发布说明（`show_release_notes = false`）

### 9. 环境变量
- 预配置常用环境变量（EDITOR、BROWSER）
- 可根据需要添加更多环境变量

### 10. 自定义主题
- 包含一个自定义深色主题示例（`custom_dark`）
- 基于 Nord 配色方案
- 可作为主题定制的起点

## 使用建议

### 主题切换
```nix
# 在 settings 中修改主题
theme = "catppuccin-mocha";  # 或其他可用主题
```

### 常用主题选项
- `"default"` - 默认主题
- `"dark"` - 深色主题
- `"catppuccin-mocha"` - Catppuccin Mocha
- `"custom_dark"` - 自定义深色主题

### 复制命令配置
根据您的系统选择合适的复制命令：

```nix
# Wayland 系统
copy_command = "wl-copy";

# X11 系统
copy_command = "xclip -selection clipboard";

# macOS 系统
copy_command = "pbcopy";
```

### 性能调优
对于资源受限的系统，可以调整以下选项：

```nix
# 减少滚动缓冲区
scroll_buffer_size = 5000;

# 增加序列化间隔
serialization_interval = 600;  # 10分钟

# 禁用会话序列化
session_serialization = false;
```

## 键盘快捷键

配置保持 Zellij 的默认键绑定：
- `Ctrl + p` - 进入窗格模式
- `Ctrl + t` - 进入标签页模式
- `Ctrl + n` - 进入调整大小模式
- `Ctrl + h` - 进入移动模式
- `Ctrl + s` - 进入搜索模式
- `Ctrl + q` - 退出当前模式或 Zellij

## 故障排除

### 字体显示问题
如果图标显示不正确，可以启用简化 UI：
```nix
simplified_ui = true;
```

### 复制功能问题
如果自动复制不工作，可以：
1. 检查系统是否支持 OSC 52
2. 配置适当的 `copy_command`
3. 临时禁用 `copy_on_select`

### 性能问题
如果系统响应缓慢：
1. 减少 `scroll_buffer_size`
2. 禁用 `session_serialization`
3. 增加 `serialization_interval`

## 更新和维护

此配置基于 Zellij 当前版本的最佳实践。随着 Zellij 的更新，可能需要调整某些选项。建议定期查看：
- [Zellij 官方文档](https://zellij.dev/documentation)
- [Home Manager Zellij 选项](https://mynixos.com/home-manager/options/programs.zellij)

## 扩展配置

### 添加自定义布局
```nix
# 在 settings 中指定布局目录
layout_dir = "/path/to/custom/layouts";
```

### 添加更多主题
```nix
themes = {
  my_theme = {
    # 自定义主题配置
  };
  # 其他主题...
};
```

### 自定义环境变量
```nix
env = {
  RUST_BACKTRACE = "1";
  DEVELOPMENT_MODE = "true";
  # 其他环境变量...
};
```
