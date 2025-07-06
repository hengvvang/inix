# NixOS 模块重复定义问题 - 系统化解决方案

## 问题分析
您的 NixOS 配置中存在系统性的重复属性定义问题，这是因为：

1. **设计缺陷**：每个功能模块都单独定义了相同的属性（如 `environment.systemPackages`）
2. **缺乏合并机制**：没有使用 NixOS 的 `lib.mkMerge` 等合并函数
3. **模块分离不当**：相关功能分散在多个文件中，但没有正确协调

## 解决方案架构

### 方案 A：模块重构（推荐）
将每个驱动类别重构为单一文件架构：

```
drivers/
├── touchpad.nix      # 合并所有 touchpad 功能
├── wacom.nix         # 合并所有 wacom 功能  
├── usb.nix           # 合并所有 USB 功能
├── ssd.nix           # 合并所有 SSD 功能
├── wifi.nix          # 合并所有 WiFi 功能
└── printing.nix      # 合并所有打印功能
```

### 方案 B：使用合并辅助函数
在每个模块中正确使用 `lib.mkMerge`：

```nix
# 示例：正确的模块合并
{
  config = lib.mkIf cfg.enable (lib.mkMerge [
    # 基础配置
    {
      environment.systemPackages = with pkgs; [ ... ];
    }
    
    # 条件配置 1
    (lib.mkIf cfg.feature1.enable {
      environment.systemPackages = with pkgs; [ ... ];
    })
    
    # 条件配置 2  
    (lib.mkIf cfg.feature2.enable {
      boot.kernelModules = [ ... ];
    })
  ]);
}
```

### 方案 C：创建集中式包管理器
创建一个统一的包管理模块：

```nix
# system/packages.nix
{
  environment.systemPackages = lib.flatten [
    # 基础系统包
    (with pkgs; [ ... ])
    
    # 驱动相关包
    (lib.optionals config.mySystem.services.drivers.touchpad.enable 
      (import ./drivers/touchpad-packages.nix { inherit pkgs lib config; }))
      
    (lib.optionals config.mySystem.services.drivers.wacom.enable
      (import ./drivers/wacom-packages.nix { inherit pkgs lib config; }))
  ];
}
```

## 立即可执行的修复步骤

### 步骤 1：创建模块合并工具
