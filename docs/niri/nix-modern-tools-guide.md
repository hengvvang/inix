# Nix 现代化工具链使用指南

本文档详细介绍了现代 Nix 生态系统中的重要工具，包括 `nh`、`nom`、`nvd`、`nix-tree` 等工具的使用方法和最佳实践。

## 目录

- [NH - Nix Helper](#nh---nix-helper)
- [NOM - Nix Output Monitor](#nom---nix-output-monitor)
- [NVD - Nix Version Diff](#nvd---nix-version-diff)
- [Nix-Tree - 依赖关系可视化](#nix-tree---依赖关系可视化)
- [其他相关工具](#其他相关工具)
- [工作流最佳实践](#工作流最佳实践)

---

## NH - Nix Helper

`nh` 是一个现代化的 NixOS 和 Home Manager 管理工具，提供了比 `nixos-rebuild` 更好的用户体验。

### 基本用法

#### 系统管理 (`nh os`)

```bash
# 构建并激活新配置（等同于 nixos-rebuild switch）
nh os switch

# 构建新配置并设为启动默认（等同于 nixos-rebuild boot）
nh os boot

# 构建并激活配置但不设为启动默认（等同于 nixos-rebuild test）
nh os test

# 仅构建配置不激活（等同于 nixos-rebuild build）
nh os build

# 构建 VM 镜像
nh os build-vm

# 回滚到上一个生成
nh os rollback

# 显示系统配置信息
nh os info

# 加载系统配置到 REPL
nh os repl
```

#### Home Manager 管理 (`nh home`)

```bash
# 构建并激活 Home Manager 配置
nh home switch

# 仅构建 Home Manager 配置
nh home build

# 回滚 Home Manager 配置
nh home rollback

# 显示 Home Manager 信息
nh home info
```

#### 清理管理 (`nh clean`)

```bash
# 清理所有旧配置和缓存
nh clean all

# 仅清理用户配置
nh clean user

# 仅清理系统配置
nh clean system

# 显示清理统计信息
nh clean --dry-run
```

#### 包搜索 (`nh search`)

```bash
# 搜索包
nh search firefox
nh search "text editor"

# 详细搜索结果
nh search --verbose vim
```

### 高级选项

```bash
# 详细输出
nh os switch --verbose

# 指定主机配置
nh os switch --hostname laptop

# 使用远程 flake
nh os switch --flake github:user/repo

# 更新 flake 后再构建
nh os switch --update

# 离线模式
nh os switch --offline

# 不询问确认
nh os switch --no-confirm
```

### 配置文件

`nh` 可以通过配置文件进行个性化设置：

```toml
# ~/.config/nh/config.toml
[config]
flake = "/home/hengvvang/inix"
default-hostname = "laptop"

[clean]
keep-generations = 3
keep-since = "4d"

[logging]
use-colors = true
verbosity = "info"
```

---

## NOM - Nix Output Monitor

`nom` 美化 Nix 构建输出，提供实时进度显示和彩色输出。

### 基本用法

```bash
# 替代 nix build
nom build .#package-name

# 替代 nix develop
nom develop

# 替代 nix shell
nom shell nixpkgs#firefox

# 替代 nix run
nom run nixpkgs#hello

# 替代 nixos-rebuild
nom shell nixpkgs#nixos-rebuild -- nixos-rebuild switch --flake .
```

### 与其他工具结合

```bash
# 与 nh 结合使用（通过环境变量）
export NIX_COMMAND_PREFIX="nom"
nh os switch

# 与 flake 结合
nom build .#nixosConfigurations.laptop.config.system.build.toplevel
nom build .#homeConfigurations."user@host".activationPackage

# 构建特定架构
nom build .#packages.x86_64-linux.myapp

# 构建并显示构建日志
nom build --log-format raw .#package
```

### 输出格式选项

```bash
# 简洁模式
nom --quiet build .#package

# 详细模式
nom --verbose build .#package

# JSON 格式输出
nom --json build .#package

# 禁用颜色
nom --no-color build .#package
```

---

## NVD - Nix Version Diff

`nvd` 用于比较不同 Nix 配置版本之间的差异。

### 基本用法

#### 比较系统配置

```bash
# 比较最新两个系统生成
nvd diff /nix/var/nix/profiles/system-{1,2}-link

# 比较指定系统生成
nvd diff /nix/var/nix/profiles/system-10-link /nix/var/nix/profiles/system-11-link

# 比较当前系统与构建结果
nvd diff /run/current-system ./result
```

#### 比较 Home Manager 配置

```bash
# 比较 Home Manager 生成
nvd diff ~/.local/state/nix/profiles/home-manager-{1,2}-link

# 比较当前 Home Manager 配置
nvd diff ~/.local/state/nix/profiles/home-manager result
```

#### 比较 flake 配置

```bash
# 比较 flake 构建结果
nvd diff \
  $(nix build --no-link --print-out-paths .#nixosConfigurations.laptop.config.system.build.toplevel) \
  $(nix build --no-link --print-out-paths .#nixosConfigurations.laptop.config.system.build.toplevel)
```

### 输出格式

```bash
# 彩色输出（默认）
nvd diff path1 path2

# 无颜色输出
nvd --no-color diff path1 path2

# JSON 格式
nvd --json diff path1 path2

# 详细模式
nvd --verbose diff path1 path2
```

### 实用脚本

创建便捷脚本来比较配置：

```bash
#!/bin/bash
# system-diff.sh - 比较系统配置差异

CURRENT=$(readlink /run/current-system)
NEW=$(nix build --no-link --print-out-paths .#nixosConfigurations.laptop.config.system.build.toplevel)

echo "比较当前系统配置与新构建的配置："
nvd diff "$CURRENT" "$NEW"
```

---

## Nix-Tree - 依赖关系可视化

`nix-tree` 提供交互式的 Nix store 依赖关系查看器。

### 基本用法

```bash
# 查看包的依赖树
nix-tree /nix/store/xxx-package-name

# 查看当前用户环境
nix-tree ~/.nix-profile

# 查看系统环境
nix-tree /run/current-system

# 查看构建结果
nix-tree ./result
```

### 交互式操作

启动 `nix-tree` 后的快捷键：

- `h` - 显示帮助
- `j/k` - 上下移动
- `l` - 展开节点
- `h` - 收起节点
- `g` - 跳到顶部
- `G` - 跳到底部
- `/` - 搜索
- `n` - 下一个搜索结果
- `N` - 上一个搜索结果
- `q` - 退出

### 高级功能

```bash
# 显示包大小信息
nix-tree --size /nix/store/xxx-package

# 反向依赖查看
nix-tree --reverse /nix/store/xxx-package

# 导出为文本
nix-tree --text /nix/store/xxx-package > dependencies.txt

# 导出为 JSON
nix-tree --json /nix/store/xxx-package > dependencies.json
```

### 与其他工具结合

```bash
# 查看刚构建的包依赖
nix build .#mypackage
nix-tree ./result

# 查看系统更新后的依赖变化
nvd diff /run/current-system ./result
nix-tree ./result
```

---

## 其他相关工具

### nix-output-monitor 别名

```bash
# 创建便捷别名
alias nb="nom build"
alias ns="nom shell"
alias nr="nom run"
alias nd="nom develop"
```

### nix-du - 磁盘使用分析

```bash
# 分析 Nix store 磁盘使用
nix-du

# 分析特定路径
nix-du /nix/store/xxx-package
```

### nix-diff - 包差异比较

```bash
# 比较两个包的差异
nix-diff package1 package2

# 比较 flake 输出
nix-diff .#package .#package --flake
```

---

## 工作流最佳实践

### 1. 日常系统管理工作流

```bash
# 1. 更新 flake inputs
nix flake update

# 2. 构建新配置（使用 nom 美化输出）
nom build .#nixosConfigurations.laptop.config.system.build.toplevel

# 3. 比较配置差异
nvd diff /run/current-system ./result

# 4. 查看新配置的依赖树
nix-tree ./result

# 5. 应用新配置
nh os switch

# 6. 清理旧配置
nh clean user --keep 3
```

### 2. 调试配置问题

```bash
# 1. 详细构建输出
nh os build --verbose

# 2. 查看构建日志
nom build --log-format raw .#nixosConfigurations.laptop.config.system.build.toplevel

# 3. 检查依赖关系
nix-tree ./result

# 4. 比较工作配置
nvd diff /nix/var/nix/profiles/system-{good,bad}-link
```

### 3. 包开发工作流

```bash
# 1. 进入开发环境
nom develop

# 2. 构建包
nom build .#mypackage

# 3. 查看包依赖
nix-tree ./result

# 4. 测试包
nom run .#mypackage

# 5. 检查包大小和依赖
nix-tree --size ./result
```

### 4. 性能优化

```bash
# 1. 分析磁盘使用
nix-du

# 2. 清理旧生成
nh clean all --keep-since 7d

# 3. 优化 Nix store
nix-store --optimise

# 4. 垃圾回收
nix-collect-garbage -d
```

### 5. 配置备份和恢复

```bash
# 备份当前配置信息
nvd diff /dev/null /run/current-system > system-backup.txt
nix-tree --text /run/current-system > system-deps.txt

# 回滚到特定生成
nh os rollback
# 或指定生成号
sudo nix-env --profile /nix/var/nix/profiles/system --switch-generation 10
```

---

## 环境变量和配置

### 全局配置

```bash
# ~/.bashrc 或 ~/.zshrc
export NIX_COMMAND_PREFIX="nom"  # 自动使用 nom
export NH_FLAKE="/home/hengvvang/inix"  # 默认 flake 路径

# 别名设置
alias nos="nh os switch"
alias nob="nh os build"
alias nhs="nh home switch"
alias nclean="nh clean all"
alias nsearch="nh search"
```

### Fish Shell 配置

```fish
# ~/.config/fish/config.fish
set -gx NIX_COMMAND_PREFIX nom
set -gx NH_FLAKE /home/hengvvang/inix

# 别名
alias nos "nh os switch"
alias nob "nh os build"
alias nhs "nh home switch"
alias nclean "nh clean all"
alias nsearch "nh search"
```

---

## 故障排除

### 常见问题

1. **构建失败时的调试步骤**：
   ```bash
   nh os build --verbose
   nom build --log-format raw .#nixosConfigurations.laptop.config.system.build.toplevel
   ```

2. **检查配置差异**：
   ```bash
   nvd diff /nix/var/nix/profiles/system-{1,2}-link
   ```

3. **磁盘空间不足**：
   ```bash
   nh clean all
   nix-collect-garbage -d
   nix-store --optimise
   ```

4. **依赖问题排查**：
   ```bash
   nix-tree /run/current-system
   nix why-depends /run/current-system /nix/store/problematic-package
   ```

通过合理使用这些现代化工具，可以大大提升 Nix 系统的管理效率和用户体验。
