# 系统配置变量使用指南

## 概述

现在系统配置也支持变量系统，可以在 `flake.nix` 中定义变量，然后在各个主机配置中使用。

## 在 flake.nix 中定义系统变量

```nix
# 用户变量配置
userVars = {
  userName = {
    hengvvang = "hengvvang";
    zlritsu = "zlritsu";
  };
};

# 系统变量配置
systemVars = {
  hostName = {
    laptop = "laptop";
    work = "work";
    daily = "daily";
  };
};
```

## 在系统配置中使用变量

在 `hosts/hostname/default.nix` 中：

```nix
{ config, lib, pkgs, inputs, outputs, userVars, systemVars, ... }:
{
  # 使用变量配置 Nix 设置
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ userVars.userName.hengvvang userVars.userName.zlritsu ];
  };

  # 使用变量配置用户
  users.users.${userVars.userName.hengvvang} = {
    isNormalUser = true;
    description = userVars.userName.hengvvang;
    extraGroups = [ "networkmanager" "wheel" "docker" "flatpak" "dialout" "plugdev" "input" "mpd" ];
    shell = pkgs.fish;
  };

  users.users.${userVars.userName.zlritsu} = {
    isNormalUser = true;
    description = userVars.userName.zlritsu;
    extraGroups = [ "networkmanager" "wheel" "docker" "flatpak" "dialout" "plugdev" "input" "mpd" ];
    shell = pkgs.fish;
  };
}
```

## 不同主机的差异化配置

### laptop 主机 (开发环境)
- 包含完整的用户组：`docker`, `flatpak`, `dialout`, `plugdev`, `input`, `mpd`

### work 主机 (工作环境)
- 限制权限，只包含基本用户组：`networkmanager`, `wheel`

### daily 主机 (macOS)
- 使用 macOS 特定的用户配置格式
- 用户目录在 `/Users/` 下

## 优势

1. **统一管理**：所有用户名在一个地方定义
2. **减少重复**：避免在每个主机配置中重复用户名
3. **一致性**：确保所有主机使用相同的用户名
4. **可维护性**：修改用户名只需要在 flake.nix 中更改

## 验证

可以使用以下命令验证配置：

```bash
# 查看系统变量
nix eval .#systemVars.hostName

# 查看用户变量  
nix eval .#userVars.userName

# 查看系统中的用户列表
nix eval .#nixosConfigurations.laptop.config.users.users --apply 'users: builtins.attrNames users'
```
