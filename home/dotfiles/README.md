# 人体工程学 Dotfiles 配置指南

这个配置提供了一个现代化、符合人体工程学的终端和shell环境，包含了以下主要组件：

- **终端**: Ghostty (主要) + Alacritty (备选)
- **Shell**: Fish (主要) + Zsh (备选)
- **会话管理**: Tmux
- **提示符**: Starship
- **文件管理**: Yazi
- **现代化工具**: 替代传统命令行工具

## 🎯 人体工程学特性

### 1. 键位优化
- **Tmux 前缀键**: `Ctrl+a` (比 `Ctrl+b` 更易按)
- **快速面板切换**: Vi 风格的 `hjkl` 键位
- **智能补全**: Fish shell 的自动建议
- **模糊搜索**: 使用 `fzf` 进行快速文件/目录搜索

### 2. 视觉优化
- **Tokyo Night 主题**: 护眼的暗色主题
- **Nerd Font 字体**: 带图标的 JetBrains Mono
- **美观的提示符**: 双行显示，信息丰富
- **语法高亮**: 所有工具都支持语法高亮

### 3. 效率提升
- **现代化工具**: 使用 `eza`、`bat`、`fd` 等替代传统工具
- **智能导航**: `zoxide` 智能目录跳转
- **Git 集成**: 丰富的 Git 别名和状态显示
- **自动建议**: Fish shell 的智能命令建议

## 🚀 快速开始

### 1. 启用配置

在 `hosts/laptop/home.nix` 中启用需要的组件：

```nix
dotfiles = {
  enable = true;
  fish.enable = true;      # Fish shell
  ghostty.enable = true;   # Ghostty 终端
  alacritty.enable = true; # Alacritty 终端 (备选)
  tmux.enable = true;      # Tmux 会话管理
  starship.enable = true;  # Starship 提示符
  yazi.enable = true;      # Yazi 文件管理器
  # ... 其他配置
};
```

### 2. 构建配置

```bash
nix build .#homeConfigurations.hengvvang.activationPackage
```

### 3. 激活配置

```bash
./result/activate
```

## 🔧 工具使用指南

### Fish Shell 快捷键

- **自动补全**: `Tab` 键
- **接受建议**: `Ctrl+f` 或 `→`
- **历史搜索**: `Ctrl+r` (向后) / `Ctrl+s` (向前)
- **单词跳转**: `Ctrl+←` / `Ctrl+→`

### Tmux 快捷键 (前缀键: `Ctrl+a`)

#### 基本操作
- `Ctrl+a + r`: 重载配置
- `Ctrl+a + |`: 垂直分割
- `Ctrl+a + -`: 水平分割
- `Ctrl+a + c`: 新建窗口

#### 面板导航
- `Ctrl+a + h/j/k/l`: Vi 风格面板切换
- `Ctrl+a + H/J/K/L`: 调整面板大小
- `Ctrl+a + m`: 面板最大化/最小化

#### 窗口管理
- `Alt+h/l`: 切换窗口
- `Alt+1~9`: 快速切换到指定窗口
- `Ctrl+a + S`: 同步面板输入

### 现代化工具别名

#### 文件操作
- `ll`: `eza -la --icons --group-directories-first`
- `tree`: `eza --tree --icons`
- `cat`: `bat --paging=never`
- `find`: `fd`

#### 系统监控
- `top`: `btop`
- `ps`: `procs`
- `du`: `dust`
- `df`: `duf`

#### Git 操作
- `g`: `git`
- `gs`: `git status`
- `gaa`: `git add --all`
- `gcm`: `git commit -m`
- `gp`: `git push`
- `gl`: `git log --oneline --graph`

### 自定义函数

#### 文件管理
- `mkcd <dir>`: 创建目录并进入
- `extract <file>`: 智能解压缩
- `backup <file>`: 创建时间戳备份

#### 快速搜索
- `fe`: 模糊搜索文件并编辑
- `fcd`: 模糊搜索目录并进入

#### 实用工具
- `weather [city]`: 查看天气
- `cheat <command>`: 查看命令速查表
- `myip`: 获取公网IP
- `localip`: 获取本地IP

## 🎨 主题和字体

### 主题配置
- **终端主题**: Tokyo Night
- **颜色方案**: 护眼的暗色主题
- **透明度**: 95% (可调整)

### 字体配置
- **主要字体**: JetBrainsMono Nerd Font
- **字体大小**: 13px (Alacritty) / 13px (Ghostty)
- **字体特性**: 等宽、连字符、图标支持

## 🛠️ 自定义配置

### 修改配置方法
每个组件都支持三种配置方式：

1. **homemanager**: 使用 Nix Home Manager 配置 (推荐)
2. **direct**: 直接写入配置文件
3. **external**: 外部配置文件引用

### 配置文件位置
- **Fish**: `~/.config/fish/config.fish`
- **Ghostty**: `~/.config/ghostty/config`
- **Alacritty**: `~/.config/alacritty/alacritty.toml`
- **Tmux**: `~/.config/tmux/tmux.conf`
- **Starship**: `~/.config/starship.toml`

### 字体自定义
可以在 `home/profiles/fonts/fonts.nix` 中添加更多字体：

```nix
home.packages = with pkgs; [
  # 添加你喜欢的字体
  your-favorite-font
];
```

## 📈 性能优化

### 启动速度优化
- Fish shell 使用延迟加载
- Starship 使用缓存机制
- Tmux 插件按需加载

### 内存使用优化
- 工具选择轻量级替代品
- 合理设置历史记录限制
- 优化字体渲染设置

## 🔍 故障排除

### 常见问题

1. **字体显示问题**
   - 确保安装了 Nerd Font
   - 检查终端字体设置
   - 更新 fontconfig 缓存

2. **颜色显示问题**
   - 检查 `$TERM` 环境变量
   - 确保终端支持 256 色
   - 验证主题配置

3. **快捷键不工作**
   - 检查键位冲突
   - 确认配置文件语法
   - 重启终端或重载配置

### 日志查看
```bash
# Fish shell 日志
fish --debug

# Tmux 日志
tmux display-message -p "#{version}"

# Starship 日志
starship explain
```

## 🎯 下一步

1. **个性化定制**: 根据个人习惯调整键位和主题
2. **工作流集成**: 配置项目特定的环境和工具
3. **插件扩展**: 添加更多有用的插件和脚本
4. **备份配置**: 定期备份和版本控制你的配置

## 🤝 贡献

如果你有任何改进建议或发现了问题，欢迎：

1. 提交 Issue 反馈问题
2. 提交 Pull Request 贡献代码
3. 分享你的配置经验

---

享受你的新终端环境！🎉
├── vim/                 # Vim 配置
│   ├── default.nix      # Vim 主配置 + 选项定义
│   ├── homemanager.nix  # Home Manager 程序模块方式
│   ├── direct.nix       # 直接文件写入方式
│   ├── external.nix     # 外部文件引用方式
│   └── configs/         # 外部配置文件目录
│       └── vimrc        # 外部 vimrc 文件
├── zsh/                 # Zsh 配置
│   ├── default.nix      # Zsh 主配置 + 选项定义
│   ├── homemanager.nix  # 方式1: Home Manager 程序模块
│   ├── direct.nix       # 方式2: 直接文件写入
│   ├── external.nix     # 方式3: 外部文件引用
│   └── configs/         # 外部配置文件目录
│       └── zshrc        # 外部 zshrc 文件
├── fish/                # Fish 配置
│   ├── default.nix      # Fish 主配置 + 选项定义
│   ├── homemanager.nix  # 方式1: Home Manager 程序模块
│   ├── direct.nix       # 方式2: 直接文件写入
│   ├── external.nix     # 方式3: 外部文件引用
│   └── configs/         # 外部配置文件目录
│       ├── config.fish  # 主配置文件
│       └── functions/   # 函数目录
│           ├── mkcd.fish
│           └── extract.fish
├── nushell/             # Nushell 配置
│   ├── default.nix      # Nushell 主配置 + 选项定义
│   ├── homemanager.nix  # 方式1: Home Manager 程序模块
│   ├── direct.nix       # 方式2: 直接文件写入
│   ├── external.nix     # 方式3: 外部文件引用
│   └── configs/         # 外部配置文件目录
│       ├── config.nu    # 主配置文件
│       └── env.nu       # 环境变量配置
├── yazi/                # Yazi 文件管理器配置
│   ├── default.nix      # Yazi 主配置 + 选项定义
│   ├── homemanager.nix  # 方式1: Home Manager 程序模块
│   ├── direct.nix       # 方式2: 直接文件写入
│   ├── external.nix     # 方式3: 外部文件引用
│   └── configs/         # 外部配置文件目录
│       ├── yazi.toml    # 主配置文件
│       ├── keymap.toml  # 键位配置
│       └── theme.toml   # 主题配置
└── ghostty/             # Ghostty 终端配置
    ├── default.nix      # Ghostty 主配置 + 选项定义
    ├── homemanager.nix  # 方式1: Home Manager 程序模块 (有限支持)
    ├── direct.nix       # 方式2: 直接文件写入
    ├── external.nix     # 方式3: 外部文件引用
    └── configs/         # 外部配置文件目录
        └── config       # Ghostty 配置文件
├── git/                 # Git 版本控制配置
│   ├── default.nix      # Git 主配置 + 选项定义
│   ├── homemanager.nix  # 方式1: Home Manager 程序模块
│   ├── direct.nix       # 方式2: 直接文件写入
│   ├── external.nix     # 方式3: 外部文件引用
│   └── configs/         # 外部配置文件目录
│       ├── gitconfig    # Git 配置文件
│       └── gitignore_global # Git 全局忽略文件
└── lazygit/             # Lazygit Git TUI 配置
    ├── default.nix      # Lazygit 主配置 + 选项定义
    ├── homemanager.nix  # 方式1: Home Manager 程序模块
    ├── direct.nix       # 方式2: 直接文件写入
    ├── external.nix     # 方式3: 外部文件引用
    └── configs/         # 外部配置文件目录
        └── config.yml   # Lazygit 配置文件
└── starship/            # Starship 跨 Shell 提示符配置
    ├── default.nix      # Starship 主配置 + 选项定义
    ├── homemanager.nix  # 方式1: Home Manager 程序模块
    ├── direct.nix       # 方式2: 直接文件写入
    ├── external.nix     # 方式3: 外部文件引用
    └── configs/         # 外部配置文件目录
        └── starship.toml # Starship 配置文件
```

## 已支持的工具配置

✅ **Vim** - 3种配置方式完整实现  
✅ **Zsh** - 3种配置方式完整实现  
✅ **Fish** - 3种配置方式完整实现  
✅ **Nushell** - 3种配置方式完整实现  
✅ **Yazi** - 3种配置方式完整实现  
✅ **Ghostty** - 3种配置方式完整实现  
✅ **Git** - 3种配置方式完整实现  
✅ **Lazygit** - 3种配置方式完整实现  
✅ **Starship** - 3种配置方式完整实现  

## 三种配置方式对比

| 方式 | 文件名 | 优点 | 缺点 | 推荐场景 |
|------|--------|------|------|----------|
| **Home Manager 程序模块** | `homemanager.nix` | 类型安全、Shell集成、验证 | 功能可能有限制 | **推荐** - 主要配置 |
| **直接文件写入** | `direct.nix` | 完全控制、支持所有功能 | 无类型检查、易出错 | 复杂配置、特殊需求 |
| **外部文件引用** | `external.nix` | 配置文件独立、易于管理 | 需要额外文件管理 | 大型配置、团队共享 |

## 使用方法

### 基础启用

在你的 home.nix 配置文件中启用所需的 dotfiles：

```nix
myHome = {
  dotfiles = {
    enable = true;              # 启用 dotfiles 模块
    
    # 各工具配置 (默认使用推荐的配置方式)
    vim.enable = true;          # 使用 Home Manager 方式
    zsh.enable = true;          # 使用 Home Manager 方式
    fish.enable = true;         # 使用 Home Manager 方式
    nushell.enable = true;      # 使用 Home Manager 方式
    yazi.enable = true;         # 使用 Home Manager 方式
    ghostty.enable = true;      # 使用直接文件写入方式
    starship.enable = true;     # 使用 Home Manager 方式
  };
};
```

### 选择配置方式

如果你想为特定工具选择不同的配置方式：

```nix
myHome = {
  dotfiles = {
    enable = true;
    
    vim = {
      enable = true;
      method = "direct";        # 使用直接文件写入配置
    };
    
    zsh = {
      enable = true;
      method = "homemanager";   # 使用 Home Manager (默认)
    };
    
    fish = {
      enable = true;
      method = "external";      # 使用外部文件引用
    };
    
    yazi = {
      enable = true;
      method = "homemanager";   # 使用 Home Manager 程序模块
    };
    
    ghostty = {
      enable = true;
      method = "direct";        # 使用直接文件写入 (默认)
    };
    
    starship = {
      enable = true;
      method = "homemanager";   # 使用 Home Manager 程序模块 (默认)
    };
  };
};
```

## 配置特性

### Vim 配置

- 基础编辑器设置（行号、语法高亮、缩进等）
- 常用键位绑定（快速保存、窗口切换等）
- 智能搜索和补全
- 状态栏显示

### Zsh 配置

- 历史管理和智能补全
- 常用别名（ls、git、现代工具等）
- 目录导航优化
- 自定义提示符

### Fish 配置

- 友好的交互式配置
- 函数定义（mkcd、extract等）
- 现代工具别名
- 智能路径管理

### Nushell 配置

- 结构化数据处理
- 自定义命令和别名
- 智能补全配置
- 现代提示符设计

### Yazi 配置

- 文件类型关联
- 键位绑定优化
- 主题和图标配置
- 预览功能设置

### Ghostty 配置

- Catppuccin Macchiato 主题
- FiraCode Nerd Font 字体配置
- 窗口和标签页设置
- 键位绑定优化

### Git 配置

- 用户信息和核心设置
- 常用 Git 别名和快捷命令
- 全局忽略文件规则
- Delta 集成（美化 diff 显示）
- 颜色主题和显示优化

### Lazygit 配置

- 现代化 Git TUI 界面
- 自定义键位绑定
- 主题和颜色配置
- 自定义命令集成
- 分支和提交可视化

### Starship 配置

- 跨 Shell 统一提示符
- 智能上下文信息显示（Git、语言版本等）
- 现代化图标和颜色主题
- 性能优化和响应式设计
- 支持 Bash、Zsh、Fish、Nushell
- 电池状态、命令执行时间显示
- Nix Shell 环境指示器

## 自定义配置

每个工具的配置都可以通过覆盖相应的文件来自定义。配置文件位置：

- Vim: `~/.vimrc`
- Zsh: `~/.zshrc`
- Fish: `~/.config/fish/config.fish`
- Nushell: `~/.config/nushell/config.nu` 和 `~/.config/nushell/env.nu`
- Yazi: `~/.config/yazi/yazi.toml`、`~/.config/yazi/keymap.toml`、`~/.config/yazi/theme.toml`
- Ghostty: `~/.config/ghostty/config`
- Git: `~/.gitconfig`、`~/.gitignore_global`
- Lazygit: `~/.config/lazygit/config.yml`
- Starship: `~/.config/starship.toml`

## 依赖要求

这些配置假设系统中已安装以下现代工具（可选）：

- `bat` (替代 cat)
- `eza` (替代 ls)
- `fd` (替代 find)
- `ripgrep` (替代 grep)
- `dust` (替代 du)
- `duf` (替代 df)
- `procs` (替代 ps)
- `btop` (替代 top)
- `starship` (跨 Shell 提示符) - 自动安装

如果这些工具未安装，相关别名将回退到传统工具。

## 构建和应用

构建并应用配置：

```bash
# 构建配置
nix build .#homeConfigurations.hengvvang.activationPackage

# 应用配置
./result/activate
```

或者使用 home-manager：

```bash
home-manager switch --flake .
```
