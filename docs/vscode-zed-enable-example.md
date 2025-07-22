# VSCode 和 Zed Editor 配置启用示例

## 在用户配置中启用

编辑您的用户配置文件（例如 `users/hengvvang/laptop.nix`），在 `dotfiles` 部分添加：

```nix
dotfiles = {
  enable = true;  # 启用 dotfiles 模块
  
  # 现有配置...
  vim.enable = true;
  zsh.enable = true;
  # ... 其他现有配置 ...
  
  # === 新增编辑器配置 ===
  
  # Visual Studio Code 配置
  vscode = {
    enable = true;                    # 启用 VSCode
    method = "homemanager";           # 使用 Home Manager 方式 (推荐)
    # method = "direct";              # 或使用直接安装方式
    # method = "external";            # 或使用外部配置文件方式
  };
  
  # Zed Editor 配置
  zed = {
    enable = true;                    # 启用 Zed Editor
    method = "homemanager";           # 使用 Home Manager 方式 (推荐)
    # method = "direct";              # 或使用直接安装方式
    # method = "external";            # 或使用外部配置文件方式
  };
};
```

## 应用配置

添加配置后，运行以下命令应用：

```bash
# 构建并应用 Home Manager 配置
home-manager switch

# 或者使用您项目的构建任务
nix build .#homeConfigurations."hengvvang@laptop".activationPackage
```

## 配置方式对比

### HomeManager 方式（推荐）
- ✅ 完全声明式配置
- ✅ 自动管理扩展和设置
- ✅ 版本控制友好
- ✅ 跨机器同步方便

### Direct 方式
- ✅ 简单直接
- ✅ 原生配置体验
- ✅ 高度灵活
- ❌ 需要手动配置

### External 方式
- ✅ 配置文件独立
- ✅ 可复用现有配置
- ✅ 配置文件可读性好
- ❌ 配置管理复杂度稍高

## 快速开始

1. 选择一种配置方式（推荐 `homemanager`）
2. 在用户配置文件中启用对应编辑器
3. 运行 `home-manager switch` 应用配置
4. 启动编辑器享受预配置环境

VSCode 启动：`code` 或在应用程序菜单中找到 "Visual Studio Code"
Zed Editor 启动：`zed` 或在应用程序菜单中找到 "Zed"
