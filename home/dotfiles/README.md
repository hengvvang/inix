# Dotfiles 配置模块

这个模块提供了各种工具的 dotfiles 配置，每个工具都支持3种不同的配置方式，遵循项目的可启用配置风格。

## 目录结构

```bash
dotfiles/
├── default.nix           # 主配置入口
├── README.md            # 说明文档
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
```

## 已支持的工具配置

✅ **Vim** - 3种配置方式完整实现  
✅ **Zsh** - 3种配置方式完整实现  
✅ **Fish** - 3种配置方式完整实现  
✅ **Nushell** - 3种配置方式完整实现  
✅ **Yazi** - 3种配置方式完整实现  
✅ **Ghostty** - 3种配置方式完整实现  

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

## 自定义配置

每个工具的配置都可以通过覆盖相应的文件来自定义。配置文件位置：

- Vim: `~/.vimrc`
- Zsh: `~/.zshrc`
- Fish: `~/.config/fish/config.fish`
- Nushell: `~/.config/nushell/config.nu` 和 `~/.config/nushell/env.nu`
- Yazi: `~/.config/yazi/yazi.toml`、`~/.config/yazi/keymap.toml`、`~/.config/yazi/theme.toml`
- Ghostty: `~/.config/ghostty/config`

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
