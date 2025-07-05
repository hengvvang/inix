# NixOS 模块化配置问题分析与解决方案

## 问题描述
在进行 NixOS 模块化配置时，将 `configuration.nix` 中的内容迁移到 `modules/nixos/*` 时无法构建。

## 根本原因
1. **模块文件格式错误**：NixOS 模块必须是接受参数的函数，格式为 `{ config, lib, pkgs, ... }: { ... }`
2. **Git 跟踪问题**：新创建的 `modules/` 目录没有被 git 跟踪，导致 Nix flake 无法访问这些文件
3. **flake.nix 配置缺失**：缺少 `inherit system;` 导致系统架构信息传递错误

## 解决步骤

### 1. 修复模块文件格式
**错误的格式：**
```nix
{
  desktop-environment = import ./desktop-environment.nix
}
```

**正确的格式：**
```nix
{ config, lib, pkgs, ... }:

{
  imports = [
    ./desktop-environment.nix
    ./hardware.nix
    ./localization.nix
    ./users.nix
    ./packages.nix
  ];
}
```

### 2. 修复 flake.nix 配置
在 `nixosConfigurations` 中添加 `inherit system;`：
```nix
nixosConfigurations = {
  hengvvang = nixpkgs.lib.nixosSystem {
    inherit system;  # 这一行很重要！
    modules = [
      ./nixos/configuration.nix
      # 其他模块...
    ];
  };
};
```

### 3. 添加文件到 Git 跟踪
```bash
git add modules/ overlays/ pkgs/
```

## 推荐的模块化结构

```
modules/nixos/
├── default.nix          # 主模块入口
├── desktop-environment.nix  # 桌面环境配置
├── hardware.nix         # 硬件相关配置（NVIDIA、音频等）
├── localization.nix     # 本地化设置（时区、语言、输入法）
├── users.nix           # 用户和服务配置
└── packages.nix        # 系统软件包
```

## 模块化的优势
1. **模块化管理**：每个文件专注于特定功能
2. **易于维护**：修改特定功能时只需编辑对应模块
3. **可重用性**：模块可以在不同配置中重用
4. **清晰结构**：配置文件更加清晰易读

## 验证配置
使用以下命令验证配置是否正确：
```bash
# 检查 flake 配置
nix flake check

# 评估配置
nix eval .#nixosConfigurations.hengvvang.config.system.nixos.label

# 测试构建（dry run）
nixos-rebuild dry-build --flake .#hengvvang
```

## 常见问题
1. **路径不存在错误**：通常是因为文件没有被 git 跟踪
2. **函数参数错误**：确保每个模块文件都以 `{ config, lib, pkgs, ... }:` 开头
3. **导入路径错误**：检查 `imports` 列表中的路径是否正确
