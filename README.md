# NixOS + Home Manager 模块化配置

## 📋 概述

这是一个完整的、模块化的 NixOS 和 Home Manager 配置，专为现代软件开发环境设计。支持多种编程语言、嵌入式开发、现代化 Linux 工具和高效的开发工作流。

## 🏗️ 架构结构

```
flake/
├── flake.nix                    # 主 Flake 配置
├── nixos/
│   ├── configuration.nix        # NixOS 主配置
│   └── hardware-configuration.nix
├── modules/
│   ├── nixos/                   # NixOS 模块
│   │   ├── default.nix
│   │   ├── hardware.nix
│   │   ├── localization.nix
│   │   ├── users.nix
│   │   ├── packages.nix
│   │   └── desktop-environment.nix
│   └── home-manager/            # Home Manager 模块
│       ├── default.nix
│       ├── development/         # 开发环境模块
│       │   ├── default.nix
│       │   ├── git.nix
│       │   ├── editors.nix
│       │   ├── languages.nix
│       │   ├── embedded.nix
│       │   └── modern-tools.nix
│       └── shell/               # Shell 环境模块
│           ├── default.nix
│           ├── fish.nix
│           ├── zsh.nix
│           └── starship.nix
├── home-manager/
│   └── home.nix                 # Home Manager 入口
└── docs/                        # 文档
    ├── home-manager-guide.md
    └── embedded-modern-tools-guide.md
```

## 🚀 快速开始

### 1. 系统构建

```bash
# 构建并切换 NixOS 配置
sudo nixos-rebuild switch --flake .#hengvvang

# 构建 Home Manager 配置
home-manager switch --flake .#hengvvang
```

### 2. 检查配置

```bash
# 检查 Flake 语法和完整性
nix flake check

# 查看开发环境信息
~/.local/bin/dev-info
```

## 🛠️ 开发环境特性

### 编程语言支持

#### Rust 🦀
- **编译器**: rustc, cargo
- **工具链**: rustup, rust-analyzer, rustfmt, clippy
- **增强工具**: cargo-edit, cargo-generate, cargo-expand, cargo-outdated, cargo-audit
- **嵌入式**: cargo-binutils
- **别名**: `cr` (cargo run), `cb` (cargo build), `ct` (cargo test), `cc` (cargo check), `cf` (cargo fmt), `ccl` (cargo clippy)

#### C/C++ 💻
- **编译器**: gcc, clang, g++
- **构建系统**: cmake, ninja, meson
- **调试**: gdb, lldb, valgrind
- **工具**: clang-tools, ccache, pkg-config

#### JavaScript/TypeScript ⬢
- **运行时**: nodejs, deno, bun
- **包管理**: npm, yarn, pnpm
- **构建**: esbuild, webpack, vite
- **质量**: eslint, prettier, typescript

#### Python 🐍
- **解释器**: python3, python3-pip
- **工具**: pipenv, poetry, black, flake8, mypy
- **数据科学**: jupyter, pandas, numpy

#### 其他语言
- **Nix**: nixfmt, nil (LSP)
- **Go**: go, golangci-lint
- **Java**: openjdk, maven, gradle

### 嵌入式开发 🔧

#### ARM 开发
- **工具链**: gcc-arm-embedded
- **调试**: openocd, gdb
- **分析**: binutils (objdump, nm, readelf)

#### RISC-V 支持
- **交叉编译**: riscv64-embedded 工具链

#### 硬件工具
- **串口**: minicom, picocom, screen
- **分析**: sigrok-cli, hexdump, xxd

### 现代化工具 ⚡

#### 系统监控
- **进程**: btop, bottom, procs
- **网络**: bandwhich, dog, gping
- **磁盘**: dust, duf, ncdu

#### 文件操作
- **浏览**: lsd, ranger, nnn, broot
- **搜索**: fd, ripgrep, fzf, skim
- **导航**: zoxide, mcfly

#### 开发增强
- **版本控制**: delta, gh, git-absorb
- **容器**: dive, lazydocker, ctop
- **文档**: glow, mdcat, tealdeer

## 🐚 Shell 环境

### Fish Shell 🐟
- **特性**: 智能补全、语法高亮、历史搜索
- **插件**: Pure 提示符主题
- **集成**: Git 快捷命令、现代化别名

### Zsh Shell 🎯
- **框架**: Oh-My-Zsh
- **插件**: git, docker, rust, node, npm
- **特性**: 历史共享、自动 cd、智能补全

### Starship 提示符 ⭐
- **显示**: Git 状态、语言版本、目录信息
- **支持**: 所有主要编程语言
- **主题**: 现代化图标和颜色

## 📝 常用别名

### 文件操作
```bash
ls      # lsd (现代化 ls)
ll      # lsd -l
la      # lsd -la
tree    # lsd --tree
cat     # bat (语法高亮的 cat)
grep    # ripgrep
find    # fd
```

### 系统监控
```bash
top     # btop
du      # dust
df      # duf
ps      # procs
ping    # gping
```

### Git 增强
```bash
gdiff   # git diff | delta
glog    # git log --oneline --graph --decorate
```

### 开发工具
```bash
benchmark  # hyperfine
count      # tokei (代码统计)
help       # tldr
```

## 🔧 配置管理

### 模块结构

1. **NixOS 模块** (`modules/nixos/`):
   - `hardware.nix`: 硬件配置和优化
   - `localization.nix`: 本地化和时区
   - `users.nix`: 用户账户管理
   - `packages.nix`: 系统级软件包
   - `desktop-environment.nix`: 桌面环境配置

2. **Home Manager 模块** (`modules/home-manager/`):
   - `development/`: 开发环境配置
   - `shell/`: Shell 环境配置

### 添加新软件包

1. **系统级包**: 添加到 `modules/nixos/packages.nix`
2. **用户级包**: 添加到相应的开发模块
3. **语言特定**: 添加到 `modules/home-manager/development/languages.nix`
4. **现代工具**: 添加到 `modules/home-manager/development/modern-tools.nix`

### 自定义配置

1. **环境变量**: 在模块中的 `home.sessionVariables`
2. **别名**: 在模块中的 `home.shellAliases`
3. **程序配置**: 在 `programs.* = { ... }`

## 📚 更多文档

- [Home Manager 详细指南](docs/home-manager-guide.md)
- [嵌入式和现代工具指南](docs/embedded-modern-tools-guide.md)

## 🐛 故障排除

### 常见问题

1. **Flake 检查失败**:
   ```bash
   nix flake check --show-trace
   ```

2. **Home Manager 构建错误**:
   ```bash
   home-manager switch --flake . --show-trace
   ```

3. **包名不存在**:
   ```bash
   nix search nixpkgs package-name
   ```

### 更新配置

```bash
# 更新 flake.lock
nix flake update

# 重新构建系统
sudo nixos-rebuild switch --flake .

# 重新构建 Home Manager
home-manager switch --flake .
```

## 📄 许可证

此配置基于 MIT 许可证。你可以自由使用、修改和分发。

## 🤝 贡献

欢迎提交 Issue 和 Pull Request 来改进这个配置！

---

**享受你的现代化 NixOS 开发环境！** 🎉
