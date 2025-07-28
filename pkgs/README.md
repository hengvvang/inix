# 自定义软件包：Raycast Linux

这个目录包含了为 Raycast Linux 创建的自定义 Nix 软件包。

## 软件包信息

- **名称**: raycast-linux
- **版本**: 0.1.0
- **描述**: Linux 版本的 Raycast 启动器
- **许可证**: MIT
- **源码**: [GitHub 仓库](https://github.com/ByteAtATime/raycast-linux)

## 功能特性

- 可扩展的命令面板
- 扩展支持
- 智能计算器
- 剪贴板历史
- 代码片段管理
- AI 集成

## 使用方法

### 在 Home Manager 配置中使用

在用户配置文件中添加：

```nix
{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    raycast-linux
  ];
}
```

### 在 NixOS 系统配置中使用

在系统配置中添加：

```nix
{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    raycast-linux
  ];
}
```

### 直接运行

使用 nix run：

```bash
nix run .#raycast-linux
```

## 构建信息

这个包基于 AppImage 构建，避免了复杂的从源码编译过程。实际的 hash 值需要在首次构建时计算。

## 系统要求

- Linux 系统
- glibc 2.38+
- 对于 Wayland 用户：需要设置 udev 规则以支持全局代码片段扩展

## 注意事项

1. 首次使用需要下载 AppImage 文件
2. hash 值需要实际计算后填入
3. 某些功能可能需要额外的系统权限配置
