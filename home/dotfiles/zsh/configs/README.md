# Zsh Shell 官方配置结构

## 概述

这是一个完全符合 Zsh 官方规范的配置，使用外部文件方式通过 Home Manager 管理。所有配置文件都是 Zsh 官方原生支持的。

## 目录结构

```
configs/
├── .zshenv      # 环境变量配置（所有 shell 都会读取）
├── .zprofile    # 登录 shell 配置（在 .zshrc 之前执行）
├── .zshrc       # 交互式 shell 配置（主要配置文件）
├── .zlogin      # 登录 shell 配置（在 .zshrc 之后执行）
├── .zlogout     # 退出时执行的配置
└── README.md    # 说明文档
```

## 配置文件说明

### 官方启动顺序

Zsh 按以下顺序读取配置文件：

1. **`/etc/zshenv`** → **`$ZDOTDIR/.zshenv`** (总是执行)
2. **`/etc/zprofile`** → **`$ZDOTDIR/.zprofile`** (仅登录 shell)
3. **`/etc/zshrc`** → **`$ZDOTDIR/.zshrc`** (仅交互式 shell)
4. **`/etc/zlogin`** → **`$ZDOTDIR/.zlogin`** (仅登录 shell)
5. **`/etc/zlogout`** → **`$ZDOTDIR/.zlogout`** (退出时，仅登录 shell)

### 文件用途

| 文件 | 执行时机 | 用途 |
|------|----------|------|
| `.zshenv` | 所有 shell 启动时 | 环境变量、路径设置 |
| `.zprofile` | 登录 shell 启动时（.zshrc 前） | 登录特定设置 |
| `.zshrc` | 交互式 shell 启动时 | 别名、函数、键绑定、补全 |
| `.zlogin` | 登录 shell 启动时（.zshrc 后） | 欢迎信息、系统检查 |
| `.zlogout` | 登录 shell 退出时 | 清理工作、保存状态 |

## 配置特性

### 🎯 完全官方标准
- 使用 Zsh 官方配置文件结构
- 遵循官方推荐的配置顺序
- 符合 XDG 基础目录规范

### ⚡ 现代化功能
- 智能别名（使用 eza、bat、rg 等现代工具）
- 实用函数（mkcd、extract、backup）
- Git 集成提示符
- 历史记录优化
- 自动补全增强

### 🔧 工具集成
- Starship 提示符支持
- Zoxide 目录跳转
- FZF 模糊查找
- 现代化命令行工具

## 自定义函数

| 函数名 | 功能 | 用法 |
|--------|------|------|
| `mkcd` | 创建目录并进入 | `mkcd new-dir` |
| `extract` | 智能解压文件 | `extract file.tar.gz` |
| `backup` | 创建时间戳备份 | `backup important.txt` |

## 键绑定

| 快捷键 | 功能 |
|--------|------|
| `Ctrl+A` | 移动到行首 |
| `Ctrl+E` | 移动到行尾 |
| `Ctrl+K` | 删除到行尾 |
| `Ctrl+U` | 删除整行 |
| `Ctrl+W` | 删除前一个词 |
| `Ctrl+R` | 历史记录搜索 |
| `Ctrl+←/→` | 词汇间跳转 |

## 使用说明

1. 通过 Home Manager 应用配置
2. 重新启动终端或运行 `exec zsh`
3. 配置会自动按官方顺序加载

## 依赖工具

### 必需
- `zsh` - Zsh Shell 本身

### 可选（现代化增强）
- `eza` - 现代化 ls
- `bat` - 带语法高亮的 cat
- `fd` - 现代化 find
- `rg` - 现代化 grep
- `dust` - 磁盘使用分析
- `btop` - 系统监控
- `starship` - 现代化提示符
- `zoxide` - 智能目录跳转
- `fzf` - 模糊查找

## 注意事项

- 所有配置文件都放在 `$ZDOTDIR` (`~/.config/zsh/`) 中
- 使用 XDG 目录规范，保持家目录整洁
- 配置兼容不同的系统环境
- 可以安全地在不同机器间同步

这个配置结构完全遵循 Zsh 官方规范，确保了最佳的兼容性和稳定性！
