# NixOS + Home Manager Flake 配置系统

这是一个基于 Nix Flakes 的完整系统配置，采用模块化设计，统一管理 NixOS 系统配置和 Home Manager 用户配置。

## 🏗️ 架构设计

### 统一的模块化架构

本配置系统的核心理念是**统一性**和**模块化**：

- **统一的配置语法**：`myHome` 和 `mySystem` 使用完全相同的配置模式
- **模块化设计**：每个功能模块独立，易于维护和扩展
- **选项/实现分离**：选项定义和具体实现分离，结构清晰

### 目录结构

```
flake/
├── flake.nix                    # Flake 入口文件
├── flake.lock                   # 依赖锁定文件
├── README.md                    # 本文档
├── docs/                        # 文档目录
│   └── README.md               # 详细文档
├── hosts/                       # 主机特定配置
│   └── laptop/
│       ├── configuration.nix   # NixOS 系统配置
│       ├── home.nix            # Home Manager 用户配置
│       └── hardware-configuration.nix
├── system/                      # 系统级模块 (NixOS)
│   ├── default.nix             # 系统模块入口
│   ├── desktop/                # 桌面环境模块
│   ├── hardware/               # 硬件配置模块
│   ├── users/                  # 用户管理模块
│   ├── packages/               # 系统包管理模块
│   └── localization/           # 本地化配置模块
├── home/                        # 用户级模块 (Home Manager)
│   ├── default.nix             # 用户模块入口
│   ├── apps/                   # 应用程序模块
│   ├── development/            # 开发环境模块
│   ├── profiles/               # 配置文件模块
│   └── toolkits/               # 工具包模块
├── overlays/                    # Nixpkgs 覆盖
├── pkgs/                        # 自定义包
└── .vscode/                     # VS Code 配置
    └── tasks.json              # 构建任务
```

## 🚀 快速开始

### 1. 构建配置

```bash
# 构建 NixOS 系统配置
nixos-rebuild switch --flake .#hengvvang

# 构建 Home Manager 用户配置
home-manager switch --flake .#hengvvang

# 或使用 VS Code 任务（推荐）
# 打开 VS Code 命令面板 (Ctrl+Shift+P)
# 运行 "Tasks: Run Task" -> "Build Home Manager Configuration"
```

### 2. 测试配置

```bash
# 干运行测试 NixOS 配置
nix build .#nixosConfigurations.hengvvang.config.system.build.toplevel --dry-run

# 干运行测试 Home Manager 配置
nix build .#homeConfigurations.hengvvang.activationPackage --dry-run
```

## ⚙️ 配置方式

### 系统配置 (mySystem)

在 `hosts/laptop/configuration.nix` 中配置系统级功能：

```nix
mySystem = {
  # 桌面环境 (三选一)
  desktop.cosmic = true;        # COSMIC 桌面环境
  # desktop.plasma = true;      # KDE Plasma 桌面环境
  # desktop.gnome = true;       # GNOME 桌面环境
  
  # 基础模块
  hardware = true;              # 硬件配置 (NVIDIA 等)
  users = true;                 # 用户管理
  packages = true;              # 系统包
  
  # 本地化配置
  localization = {
    # 时区选择 (只能选择一个)
    timeZone.shanghai = true;   # 中国上海时区
    # timeZone.newYork = true;  # 美国纽约时区
    
    # 输入法选择 (只能选择一个)
    inputMethod.fcitx5 = true;  # Fcitx5 输入法框架
    # inputMethod.ibus = true;  # IBus 输入法框架
  };
};
```

### 用户配置 (myHome)

在 `hosts/laptop/home.nix` 中配置用户级功能：

```nix
myHome = {
  # 应用程序
  apps = {
    editors = {
      vim = true;               # Vim 编辑器
      vscode = true;            # VSCode 编辑器
      # micro = true;           # Micro 编辑器
      # zed = true;             # Zed 编辑器
    };
    shells = {
      fish = true;              # Fish Shell
      aliases = true;           # Shell 别名
      prompts.starship = true;  # Starship 提示符
      # zsh = true;             # Zsh Shell
      # nushell = true;         # Nushell
    };
    terminals = {
      # ghostty = true;         # Ghostty 终端
    };
    # yazi = true;              # Yazi 文件管理器
  };
  
  # 开发环境
  development = {
    versionControl = {
      git = true;               # Git 版本控制
      lazygit = true;           # Lazygit TUI
    };
    languages = {
      rust = true;              # Rust 开发环境
      python = true;            # Python 开发环境
      javascript = true;        # JavaScript 开发环境
      typescript = true;        # TypeScript 开发环境
      # cpp = true;             # C++ 开发环境
      # c = true;               # C 开发环境
    };
    embedded = {
      # toolchain = true;       # 嵌入式工具链
    };
  };
  
  # 配置文件
  profiles = {
    fonts = {
      fonts = true;             # 字体配置
    };
    envVar = {
      environment = true;       # 环境变量配置
    };
  };
  
  # 工具包
  toolkits = {
    system = {
      hardware = true;          # 硬件工具
      monitor = true;           # 系统监控
      network = true;           # 网络工具
      utilities = true;         # 系统工具
    };
    user = {
      utilities = true;         # 用户工具
    };
  };
};
```

## 📦 模块详解

### 系统模块 (system/)

#### 桌面环境 (desktop/)
- **COSMIC**: 新一代 Rust 编写的桌面环境
- **Plasma**: KDE Plasma 6 桌面环境
- **GNOME**: GNOME 桌面环境

#### 硬件配置 (hardware/)
- NVIDIA 显卡驱动配置
- 硬件加速支持
- 电源管理

#### 用户管理 (users/)
- 用户账户配置
- 用户组管理
- Shell 设置

#### 系统包 (packages/)
- 基础系统工具
- 命令行工具
- 系统服务

#### 本地化 (localization/)
- **时区配置**: 支持多个时区选择
- **输入法配置**: Fcitx5/IBus 输入法框架

### 用户模块 (home/)

#### 应用程序 (apps/)
- **编辑器**: Vim, VSCode, Micro, Zed
- **Shell**: Fish, Zsh, Nushell + 别名和提示符
- **终端**: Ghostty 等现代终端
- **文件管理**: Yazi 文件管理器

#### 开发环境 (development/)
- **版本控制**: Git, Lazygit
- **编程语言**: Rust, Python, JavaScript, TypeScript, C/C++
- **嵌入式开发**: 嵌入式工具链

#### 配置文件 (profiles/)
- **字体配置**: 系统字体设置
- **环境变量**: 用户环境变量

#### 工具包 (toolkits/)
- **系统工具**: 硬件工具、系统监控、网络工具
- **用户工具**: 用户级实用工具

## 🔧 自定义配置

### 添加新的桌面环境

1. 在 `system/desktop/` 下创建新的实现文件，如 `hyprland.nix`
2. 在 `system/desktop/default.nix` 中添加选项定义：
   ```nix
   options.mySystem.desktop = {
     # ...existing options...
     hyprland = lib.mkEnableOption "Hyprland 窗口管理器";
   };
   ```
3. 添加到导入列表：
   ```nix
   imports = [
     # ...existing imports...
     ./hyprland.nix
   ];
   ```

### 添加新的开发语言

1. 在 `home/development/languages/` 下创建新的实现文件，如 `go.nix`
2. 在 `home/development/languages/default.nix` 中添加选项定义：
   ```nix
   options.myHome.development.languages = {
     # ...existing options...
     go = lib.mkEnableOption "Go 开发环境";
   };
   ```
3. 添加到导入列表并在主机配置中启用

## 🎯 最佳实践

### 1. 模块设计原则
- **单一职责**: 每个模块只负责一个特定功能
- **选项分离**: 选项定义和实现分离
- **条件加载**: 使用 `lib.mkIf` 进行条件配置

### 2. 配置管理
- **版本控制**: 所有配置文件都应该在 Git 版本控制下
- **测试优先**: 在应用配置前先进行干运行测试
- **渐进式迁移**: 逐步启用新功能，避免一次性大幅修改

### 3. 调试技巧
```bash
# 检查配置语法
nix flake check

# 查看可用输出
nix flake show

# 详细错误信息
nix build --show-trace

# 查看构建日志
nix log /nix/store/...
```

## 🔍 故障排除

### 常见问题

1. **构建失败**
   - 检查语法错误: `nix flake check`
   - 查看详细错误: `--show-trace`
   - 验证选项路径是否正确

2. **模块冲突**
   - 确保只启用一个桌面环境
   - 检查是否有重复的配置定义

3. **权限问题**
   - 确保 Flake 目录有正确的权限
   - 检查 Git 仓状态 (commit 未提交的更改)

### 调试命令

```bash
# 检查系统配置
nixos-option system.stateVersion

# 检查 Home Manager 配置
home-manager option home.stateVersion

# 查看当前生成
nixos-rebuild list-generations
home-manager generations
```

## 📚 参考资源

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Nix Flakes](https://nixos.wiki/wiki/Flakes)
- [NixOS Options Search](https://search.nixos.org/options)
- [Home Manager Options Search](https://nix-community.github.io/home-manager/options.html)

## 🤝 贡献

欢迎提交 Issue 和 Pull Request 来改进这个配置系统！

---

**享受您的 NixOS + Home Manager 配置系统！** 🎉
