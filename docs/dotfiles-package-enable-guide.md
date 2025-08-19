# Dotfiles 软件包启用开关使用指南

## 概述

为了解决在非NixOS系统上可能不需要安装Nix软件包，而只需要配置文件的问题，我们为所有dotfiles配置添加了`packageEnable`选项。

## 新增功能

### packageEnable 选项

每个dotfiles配置现在都有一个`packageEnable`选项：

```nix
packageEnable = lib.mkOption {
  type = lib.types.bool;
  default = true;
  description = "是否安装软件包 (设为 false 时仅应用配置文件)";
};
```

## 已更新的Dotfiles

以下所有dotfiles配置都已添加`packageEnable`选项：

- ✅ alacritty
- ✅ bash
- ✅ fish
- ✅ git
- ✅ ghostty
- ✅ lazygit
- ✅ nushell
- ✅ obs-studio
- ✅ qutebrowser
- ✅ rio
- ✅ rmpc
- ✅ rofi
- ✅ sherlock
- ✅ starship
- ✅ tmux
- ✅ vim
- ✅ vscode
- ✅ yazi
- ✅ zed
- ✅ zellij
- ✅ zsh

## 使用示例

### 1. 默认用法（同时安装软件包和配置）

```nix
myHome.dotfiles = {
  enable = true;
  alacritty = {
    enable = true;
    # packageEnable = true; # 默认值，可省略
    method = "homemanager";
  };
};
```

### 2. 仅应用配置文件，不安装软件包

```nix
myHome.dotfiles = {
  enable = true;
  alacritty = {
    enable = true;
    packageEnable = false;  # 只应用配置，不安装软件包
    method = "external";    # 推荐使用external或xdirect方法
  };
};
```

### 3. 批量配置（适用于非NixOS系统）

```nix
myHome.dotfiles = {
  enable = true;

  # 只需要配置文件的应用
  alacritty = {
    enable = true;
    packageEnable = false;
    method = "external";
  };

  fish = {
    enable = true;
    packageEnable = false;
    method = "external";
  };

  git = {
    enable = true;
    packageEnable = false;
    method = "external";
  };

  # 仍需要软件包的应用（如通过Nix管理）
  starship = {
    enable = true;
    packageEnable = true;
    method = "homemanager";
  };
};
```

## 配置方式说明

当使用`packageEnable = false`时，推荐的配置方式：

1. **external**: 使用外部配置文件，适合已经有现成配置文件的情况
2. **xdirect**: 使用builtins.readFile读取外部文件，灵活性更高
3. **homemanager**: 如果软件支持程序模块，即使不安装包也可以生成配置
4. **direct**: 直接写入配置文件，适合简单配置

## 实现原理

### 在配置实现中的应用

原来的软件包安装：
```nix
home.packages = with pkgs; [ alacritty ];
```

现在变为：
```nix
home.packages = lib.optionals config.myHome.dotfiles.alacritty.packageEnable (with pkgs; [ alacritty ]);
```

对于Home Manager程序模块：
```nix
programs.alacritty = {
  enable = true;
  package = lib.mkIf config.myHome.dotfiles.alacritty.packageEnable pkgs.alacritty;
  # ... 其他配置保持不变
};
```

## 适用场景

1. **跨操作系统配置同步**: 在macOS、Ubuntu等系统上只需配置文件
2. **已安装软件的配置管理**: 软件通过其他方式安装，只需要Nix管理配置
3. **测试和开发**: 快速测试配置而不安装软件包
4. **资源限制环境**: 在存储空间有限的环境中只同步配置

## 注意事项

1. 当`packageEnable = false`时，确保目标软件已通过其他方式安装
2. 某些配置可能依赖特定版本的软件，注意兼容性
3. 推荐在非NixOS系统上使用`external`或`xdirect`配置方式
4. Home Manager的程序模块可能仍会创建配置文件，即使不安装软件包
