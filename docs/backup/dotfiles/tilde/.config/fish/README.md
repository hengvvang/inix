# Fish Shell 配置结构说明

## 概述

这是一个完整的 Fish Shell 配置，使用外部文件方式通过 Home Manager 管理。配置采用模块化设计，便于维护和扩展。

## 目录结构

```
configs/
├── config.fish              # 主配置文件
├── conf.d/                   # 自动加载的配置片段
│   ├── aliases.fish         # 别名配置
│   ├── exports.fish         # 环境变量配置
│   ├── colors.fish          # 颜色主题配置
│   ├── keybindings.fish     # 键绑定配置
│   └── init.fish            # 初始化配置
├── functions/                # 自定义函数
│   ├── backup.fish          # 文件备份函数
│   ├── cdl.fish             # 切换目录并列出内容
│   ├── cheat.fish           # 命令参考查询
│   ├── extract.fish         # 智能解压函数
│   ├── fcd.fish             # 模糊查找并进入目录
│   ├── fe.fish              # 模糊查找并编辑文件
│   ├── gac.fish             # Git 快速提交
│   ├── mkcd.fish            # 创建目录并进入
│   └── weather.fish         # 天气查询
├── completions/              # 自定义补全
│   └── custom.fish          # 自定义函数的补全规则
├── fish_plugins             # 插件管理文件（官方支持）
├── fish_variables.template  # Fish 变量模板（用于版本控制）
└── README.md                # 详细说明文档
```

### 配置文件说明

| 文件/目录 | 用途 | 自动加载 |
|-----------|------|----------|
| `config.fish` | 主配置文件 | ✅ |
| `conf.d/` | 配置模块目录 | ✅ |
| `functions/` | 自定义函数目录 | 按需加载 |
| `completions/` | 自定义补全目录 | 按需加载 |
| `fish_plugins` | 插件管理文件 | ✅ (by fisher) |
| `fish_variables` | Fish 变量存储 | ✅ (自动生成) |

**注意**: 
- `fish_variables` 文件由 Fish 自动生成和管理，不应手动编辑
- `fish_variables.template` 仅用于版本控制参考
- `fish_plugins` 需要 fisher 插件管理器支持

### 主要功能
- 🎨 **现代化配色方案** - 优化的语法高亮和颜色主题
- ⚡ **智能别名** - 使用现代工具替换传统命令
- 🔍 **模糊查找集成** - 支持 fzf 的文件和目录查找
- 📝 **实用函数** - 丰富的自定义函数库
- ⌨️ **人性化快捷键** - 符合人体工程学的键绑定
- 🔧 **工具集成** - 自动初始化 starship、zoxide 等工具

### 现代工具替换
- `ls` → `eza` (更美观的文件列表)
- `cat` → `bat` (语法高亮的文件查看)
- `find` → `fd` (更快的文件查找)
- `grep` → `rg` (更快的文本搜索)
- `du` → `dust` (可视化磁盘使用)
- `top` → `btop` (现代化系统监控)

### 自定义函数

| 函数名 | 功能描述 | 用法示例 |
|--------|----------|----------|
| `mkcd` | 创建目录并进入 | `mkcd new-project` |
| `extract` | 智能解压各种格式 | `extract archive.tar.gz` |
| `backup` | 创建时间戳备份 | `backup important.txt` |
| `weather` | 查询天气信息 | `weather Beijing` |
| `cheat` | 命令用法参考 | `cheat tar` |
| `cdl` | 切换目录并列出内容 | `cdl ~/Documents` |
| `gac` | Git 快速提交 | `gac "Fix bug"` |
| `fe` | 模糊查找编辑文件 | `fe` |
| `fcd` | 模糊查找进入目录 | `fcd` |

### 键绑定

| 快捷键 | 功能 |
|--------|------|
| `Ctrl+F` | 接受自动建议 |
| `Ctrl+R` | 历史记录搜索 |
| `Ctrl+→/←` | 词汇间跳转 |
| `Alt+L` | 清屏 |
| `Alt+E` | 在编辑器中编辑命令 |

## 依赖工具

配置中使用了以下现代化工具，建议通过 Nix 包管理器安装：

### 必需工具
- `fish` - Fish Shell 本身
- `eza` - 现代化的 ls 替代
- `bat` - 带语法高亮的 cat 替代
- `fd` - 现代化的 find 替代
- `ripgrep` - 现代化的 grep 替代

### 可选工具
- `fzf` - 模糊查找工具
- `zoxide` - 智能目录跳转
- `starship` - 现代化提示符
- `dust` - 磁盘使用分析
- `btop` - 系统监控
- `gping` - 现代化 ping

## 使用说明

### 基础安装

1. 确保已安装 Fish Shell 和相关工具
2. 通过 Home Manager 应用配置
3. 重新启动终端或运行 `source ~/.config/fish/config.fish`

### 插件管理（可选）

如果需要使用插件功能：

1. 安装 fisher 插件管理器：
   ```fish
   curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
   ```

2. 安装插件：
   ```fish
   fisher install
   ```

3. 更新插件：
   ```fish
   fisher update
   ```

### 享受现代化体验

配置完成后即可享受现代化的 Fish Shell 体验！

## 自定义

- **添加别名**: 编辑 `conf.d/aliases.fish`
- **修改环境变量**: 编辑 `conf.d/exports.fish`
- **调整颜色**: 编辑 `conf.d/colors.fish`
- **自定义快捷键**: 编辑 `conf.d/keybindings.fish`
- **添加函数**: 在 `functions/` 目录下创建新的 `.fish` 文件
- **添加补全**: 在 `completions/` 目录下添加补全规则

## 注意事项

- 配置采用模块化设计，`conf.d/` 目录下的文件会被 Fish 自动加载
- 函数文件需要放在 `functions/` 目录下，Fish 会按需加载
- 补全文件需要放在 `completions/` 目录下
- 避免在主配置文件中定义太多内容，优先使用模块化配置
