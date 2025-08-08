# Yazi 配置完全指南

Yazi 是一个用 Rust 编写的现代文件管理器，拥有丰富的配置选项。本文档将详细介绍 Yazi 的所有配置项及其可能的值和效果。

## 配置文件概览

Yazi 主要使用以下配置文件：

### 核心配置文件

1. **yazi.toml** - 主配置文件，控制文件管理器的核心行为
2. **keymap.toml** - 键盘快捷键配置
3. **theme.toml** - 颜色主题和样式配置

### 可选配置文件

4. **init.lua** - Lua 初始化脚本，用于插件配置和自定义
5. **flavors/\*.yazi/** - 预制主题包
6. **plugins/\*.yazi/** - 插件目录

## 配置目录结构

```
~/.config/yazi/
├── yazi.toml        # 主配置文件
├── keymap.toml      # 键盘快捷键
├── theme.toml       # 主题配置
├── init.lua         # Lua 初始化脚本
├── plugins/         # 插件目录
│   ├── plugin1.yazi/
│   │   ├── main.lua
│   │   ├── README.md
│   │   └── LICENSE
│   └── plugin2.yazi/
└── flavors/         # 预制主题目录
    ├── flavor1.yazi/
    │   ├── flavor.toml
    │   ├── tmtheme.xml
    │   ├── README.md
    │   ├── preview.png
    │   ├── LICENSE
    │   └── LICENSE-tmtheme
    └── flavor2.yazi/
```

## 配置混合机制

Yazi 支持配置混合，允许你在默认配置的基础上进行修改：

- `prepend_*` - 在默认配置前添加规则
- `append_*` - 在默认配置后添加规则
- `*` - 完全覆盖默认配置

例如：
```toml
# 在默认键绑定前添加新的绑定
[mgr]
prepend_keymap = [
    { on = "<C-a>", run = "my-cmd1", desc = "My custom command" },
]

# 在默认键绑定后添加新的绑定
append_keymap = [
    { on = ["g", "d"], run = "cd ~/Downloads", desc = "Go to Downloads" },
]
```

## 自定义配置目录

你可以通过设置环境变量来使用自定义的配置目录：

```bash
export YAZI_CONFIG_HOME="~/.config/yazi-alt"
yazi
```

这将使用 `~/.config/yazi-alt` 作为配置目录。

## 配置文件优先级

1. 用户配置文件（`~/.config/yazi/`）
2. 预制主题（flavors）
3. 系统默认配置

用户配置始终优先于预制主题和系统默认配置。

## 配置验证

你可以使用 TOML 验证工具检查配置文件的正确性：

```bash
# 使用 taplo 检查 theme.toml
taplo check --schema https://yazi-rs.github.io/schemas/theme.json theme.toml
```

## 调试配置

如需调试配置问题，可以设置日志级别：

```bash
YAZI_LOG=debug yazi
```

日志文件位置：
- Unix-like 系统：`~/.local/state/yazi/yazi.log`
- Windows：`%AppData%\yazi\state\yazi.log`

日志级别（从详细到简略）：
- `debug` - 最详细的调试信息
- `info` - 一般信息
- `warn` - 警告信息
- `error` - 仅错误信息

## 快速开始

如果你想快速开始配置 Yazi：

1. 复制默认配置文件到你的配置目录
2. 根据需要修改相应的配置项
3. 重启 Yazi 以应用更改

默认配置文件可以在 [GitHub 仓库](https://github.com/sxyazi/yazi/tree/shipped/yazi-config/preset) 中找到。

接下来的章节将详细介绍每个配置文件的所有可配置项。
