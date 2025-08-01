# Niri 与系统服务集成指南

本文档说明如何将 Niri 桌面环境与现有的 `system/services` 模块正确集成，避免配置冲突。

## 🔧 必需的系统服务配置

要使 Niri 正常工作，您需要在主配置中启用以下服务模块：

### 1. 音频支持
```nix
mySystem.services.drivers.audio.enable = true;
```

### 2. 蓝牙支持
```nix
mySystem.services.drivers.bluetooth = {
  enable = true;
  gui = true;  # 启用蓝牙管理器 GUI
};
```

### 3. 网络管理
```nix
mySystem.services.network.manager = {
  enable = true;
  preset = "networkmanager";
  tools.gui = true;  # 启用网络管理器 GUI
};
```

### 4. 打印支持 (可选)
```nix
mySystem.services.drivers.printing = {
  enable = true;
  tools.gui = true;
  service.discovery = true;
};
```

### 5. 显卡驱动 (根据您的硬件选择)
```nix
# Intel 显卡
mySystem.services.drivers.intel.enable = true;

# AMD 显卡
mySystem.services.drivers.amd.enable = true;

# NVIDIA 显卡
mySystem.services.drivers.nvidia = {
  enable = true;
  driver.openSource = false;  # 使用专有驱动
};
```

## 📋 完整配置示例

在您的 NixOS 配置中：

```nix
{
  # ========== 桌面环境 ==========
  mySystem.desktop = {
    enable = true;
    preset = "niri";
  };

  # ========== 必需服务 ==========
  mySystem.services = {
    enable = true;
    
    # 驱动程序
    drivers = {
      audio.enable = true;
      bluetooth = {
        enable = true;
        gui = true;
      };
      intel.enable = true;  # 或 amd/nvidia
    };
    
    # 网络服务
    network.manager = {
      enable = true;
      preset = "networkmanager";
      tools.gui = true;
    };
  };

  # ========== Home Manager ==========
  myHome.desktop = {
    enable = true;
    niri = {
      enable = true;
      method = "external";
    };
  };
}
```

## 🚫 避免的重复配置

经过优化，Niri 配置已移除以下重复项：

### ❌ 已移除的配置
- `services.pipewire.*` → 使用 `drivers.audio`
- `hardware.bluetooth.*` → 使用 `drivers.bluetooth`
- `services.printing.*` → 使用 `drivers.printing`
- `networking.networkmanager.*` → 使用 `network.manager`
- `services.blueman.*` → 包含在 `drivers.bluetooth.gui`

### ✅ 保留的 Niri 特定配置
- Niri 窗口管理器本身
- Wayland 环境变量
- XDG 桌面门户配置
- Niri 特定的 Systemd 服务
- 字体配置 (使用 `mkDefault`)
- OpenGL 优化 (使用 `mkDefault`)

## 🔍 配置冲突检查

如果遇到配置冲突，请检查：

1. **音频**: 确保只有一个地方启用 PipeWire
2. **蓝牙**: 确保只有一个地方配置 `hardware.bluetooth`
3. **网络**: 确保只有一个地方启用 NetworkManager
4. **打印**: 确保只有一个地方配置 CUPS

## 🛠️ 故障排除

### 如果服务未启动
检查依赖的服务模块是否已启用：
```bash
sudo systemctl status pipewire
sudo systemctl status bluetooth
sudo systemctl status NetworkManager
```

### 如果出现配置错误
使用以下命令检查配置：
```bash
sudo nixos-rebuild dry-build
```

### 查看 Niri 日志
```bash
journalctl --user -u niri
```

## 📚 相关文档

- [System Services 模块文档](../services/README.md)
- [Niri 官方配置指南](./README.md)
- [音频驱动配置](../services/drivers/audio/README.md)
- [蓝牙驱动配置](../services/drivers/bluetooth/README.md)
