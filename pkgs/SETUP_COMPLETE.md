# 使用说明

## 已成功创建的自定义包

你的配置中现在已经包含了一个自定义的 `raycast-linux` 软件包！

### 文件结构

```text
pkgs/
├── default.nix              # 导出自定义包
├── README.md               # 说明文档
├── usage-example.nix       # 使用示例
└── raycast-linux/
    ├── default.nix         # raycast-linux 包定义
    └── calculate-hash.sh   # 计算 hash 的辅助脚本
```

### 如何使用

#### 1. 在 Home Manager 配置中使用

编辑 `/home/hengvvang/config.d/users/hengvvang/laptop.nix`（或其他主机配置）：

```nix
{ config, pkgs, lib, ... }:
{
  config = lib.mkIf (config.host == "laptop") {
    home.packages = with pkgs; [
      # 其他软件包...
      raycast-linux  # 添加自定义的 raycast-linux 包
    ];
  };
}
```

#### 2. 直接运行

```bash
# 使用 nix run 直接运行
nix run .#raycast-linux

# 或者构建后运行
nix build .#raycast-linux
./result/bin/raycast-linux
```

#### 3. 在系统级别安装

在 `hosts/laptop/default.nix` 中添加：

```nix
{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    raycast-linux
  ];
}
```

### 包功能

- ✅ 可扩展的命令面板
- ✅ 扩展支持  
- ✅ 智能计算器
- ✅ 剪贴板历史
- ✅ 代码片段管理
- ✅ AI 集成

### 系统要求

- glibc 2.38+ (Ubuntu 24.04, Fedora 40, 或新版 Arch Linux)
- 对于 Wayland 用户：需要 udev 规则支持全局代码片段扩展

### 下一步

1. 将包添加到你的用户配置中
2. 重建 Home Manager 配置: `home-manager switch --flake .#hengvvang@laptop`
3. 设置快捷键启动 raycast-linux
4. 享受使用！

这是一个完整的 Nix 自定义软件包示例，展示了如何：

- 创建自定义 pkgs 目录
- 定义 AppImage 类型的软件包  
- 在 flake.nix 中集成自定义包
- 通过 overlay 系统提供包
- 在用户或系统配置中使用自定义包
