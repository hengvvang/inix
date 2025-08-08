# Zellij 配置完全指南

本指南提供了 Zellij 终端多路复用器的完整配置文档，涵盖所有可配置项、可能的值以及它们的作用和效果。

## 文档结构

### [01-配置概览](01-configuration-overview.md)
- 配置文件位置和查找顺序
- 快速开始指南
- 配置文件结构说明
- 实时配置更新
- 配置验证方法

### [02-基本选项配置](02-basic-options.md)
- 会话和退出行为配置
- 界面显示选项
- Shell 和编辑器配置
- 主题和布局设置
- 目录配置
- 环境变量设置

### [03-输入和鼠标配置](03-input-mouse-config.md)
- 鼠标配置选项
- 复制粘贴设置
- 键盘协议支持
- 滚动和缓冲区配置
- 样式和渲染选项
- 窗格操作行为

### [04-会话管理配置](04-session-management.md)
- 会话序列化设置
- 会话恢复配置
- 会话元数据管理
- Web 服务器配置
- 最佳实践建议

### [05-键绑定模式配置](05-keybindings-modes.md)
- 键绑定基本结构
- 各种操作模式详解
  - normal, locked, pane, tab, resize, move
  - scroll, search, session 等模式
- 共享键绑定配置
- 自定义键绑定示例

### [06-键绑定动作参考](06-keybind-actions.md)
- 完整的动作类型列表
- 模式切换动作
- 窗格操作动作
- 标签页操作动作
- 滚动和搜索动作
- 系统操作动作
- 每个动作的参数说明

### [07-插件配置](07-plugins-config.md)
- 插件别名配置
- 内置插件详解
- 自定义插件配置
- 后台插件加载
- 插件在键绑定中的使用
- 插件开发配置
- 插件管理最佳实践

### [08-主题配置](08-themes-config.md)
- 内置主题使用
- 主题定义结构
- UI 组件详细说明
- 多用户颜色配置
- 完整主题示例
- 主题应用方式
- 主题开发技巧

### [09-完整配置示例](09-complete-config-examples.md)
- 基础配置示例
- 完整键绑定配置
- 插件配置示例
- 自定义主题示例
- 高级配置示例（开发者、服务器管理、最小化）
- 配置验证和技巧

## 快速参考

### 配置文件位置
```bash
~/.config/zellij/config.kdl
```

### 生成默认配置
```bash
mkdir ~/.config/zellij
zellij setup --dump-config > ~/.config/zellij/config.kdl
```

### 验证配置
```bash
zellij setup --check
```

### 使用自定义配置启动
```bash
zellij --config /path/to/config.kdl
```

## 配置语言

Zellij 使用 [KDL (KuneForm Document Language)](https://kdl.dev/) 作为配置语言，这是一种人类友好且功能强大的配置格式。

## 主要配置块

- **基本选项** - 直接在根级别设置的全局选项
- **keybinds** - 键绑定配置，按模式组织
- **plugins** - 插件别名和配置
- **themes** - 颜色主题定义
- **load_plugins** - 后台加载的插件列表

## 配置更新

大部分配置更改会实时生效，无需重启 Zellij。需要重启的配置项会在相应文档中特别说明。

## 获取帮助

1. 查看官方文档：https://zellij.dev/documentation/
2. 查看默认配置：https://github.com/zellij-org/zellij/blob/main/zellij-utils/assets/config/default.kdl
3. 社区支持：
   - Discord: https://discord.gg/CrUAFH3
   - GitHub Issues: https://github.com/zellij-org/zellij/issues

---

本文档基于 Zellij 官方文档和源码创建，涵盖了所有主要配置选项及其可能的值和效果。
