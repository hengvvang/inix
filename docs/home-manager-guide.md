# Home Manager 模块化配置

## 配置结构

```
modules/home-manager/
├── default.nix              # 主模块入口
├── development/              # 开发环境配置
│   ├── default.nix          # 开发模块入口
│   ├── git.nix              # Git 配置
│   ├── editors.nix          # 编辑器配置 (micro, helix)
│   └── languages.nix        # 编程语言环境
└── shell/                   # Shell 配置
    ├── default.nix          # Shell 模块入口
    ├── fish.nix            # Fish Shell 配置
    └── zsh.nix             # Zsh Shell 配置
```

## 支持的开发环境

### 编程语言
- **Rust**: rustup, rust-analyzer, cargo-watch, cargo-edit
- **C/C++**: gcc, clang, cmake, gdb, clang-tools
- **Python**: python3, pip, virtualenv, pyright
- **TypeScript/JavaScript**: nodejs, npm, typescript, prettier, eslint
- **Nix**: nil (语言服务器), nixpkgs-fmt

### 开发工具
- **Git**: git, lazygit
- **编辑器**: micro, helix
- **现代化工具**: fd, ripgrep, bat, exa
- **环境管理**: direnv (支持 shell.nix)

### Shell 环境
- **Fish Shell**: 现代化交互式 Shell，包含 Pure 主题
- **Zsh Shell**: 强大的 Shell，配置 Oh-My-Zsh
- **FZF**: 模糊搜索工具

## 使用方法

### 1. 在 home.nix 中导入模块
```nix
{
  imports = [
    ../modules/home-manager
  ];
}
```

### 2. 环境变量自动配置
- `EDITOR=micro`
- `CARGO_HOME=~/.cargo`
- `RUSTUP_HOME=~/.rustup`
- 自动添加开发工具到 PATH

### 3. 常用别名
- `ls` → `exa` (现代化的 ls)
- `cat` → `bat` (语法高亮的 cat)
- `grep` → `rg` (ripgrep)
- `find` → `fd` (现代化的 find)
- `g` → `git`
- `lg` → `lazygit`
- `cr` → `cargo run`
- `py` → `python3`
- `nr` → `npm run`

## 项目级别环境配置

使用 direnv 可以为每个项目配置特定的开发环境：

### 创建 .envrc 文件
```bash
# Rust 项目
echo "use flake" > .envrc

# 或者使用 shell.nix
echo "use nix" > .envrc
```

### 创建 shell.nix 示例
```nix
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    rustc
    cargo
    rust-analyzer
  ];
}
```

## 自定义配置

如果需要修改配置，编辑对应的模块文件：
- Git 配置: `modules/home-manager/development/git.nix`
- 编辑器配置: `modules/home-manager/development/editors.nix`
- 开发环境: `modules/home-manager/development/languages.nix`
- Shell 配置: `modules/home-manager/shell/`

修改后运行 `home-manager switch --flake .#hengvvang` 应用更改。
