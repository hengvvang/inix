# 蓝牙模块简化说明

## 简化原则

蓝牙模块从复杂的多文件结构简化为单一文件，遵循以下原则：

### 简化前的问题
- **文件过多**：原有 default.nix + core.nix + audio.nix 结构过于复杂
- **配置冗余**：多层次配置选项造成配置复杂度过高
- **维护困难**：分散的配置增加了维护成本

### 简化后的优势
- **单一文件**：所有功能集中在 `default.nix` 一个文件中
- **配置极简**：只保留最核心的 `enable` 和 `gui` 两个选项
- **功能完整**：包含所有必要的蓝牙功能，无需额外配置

## 文件结构

```
system/services/drivers/bluetooth/
└── default.nix                    # 蓝牙模块完整实现
```

## 配置选项

```nix
mySystem.services.drivers.bluetooth = {
  enable = false;                   # 是否启用蓝牙支持
  gui = true;                      # 是否启用图形管理工具
};
```

## 内置功能

### 核心功能
- ✅ 蓝牙硬件支持（hardware.bluetooth）
- ✅ 开机自动启动蓝牙
- ✅ 实验性功能支持
- ✅ 蓝牙服务（systemd.services.bluetooth）

### 音频支持
- ✅ PipeWire 蓝牙音频集成
- ✅ A2DP 高质量音频协议
- ✅ 音频控制工具（pavucontrol, pulseaudio-ctl）

### 设备支持
- ✅ 输入设备（键盘、鼠标）
- ✅ HID 设备支持
- ✅ 内核模块自动加载

### 管理工具
- ✅ 命令行工具（bluez, bluez-tools, bluetuith）
- ✅ 图形管理工具（blueman, blueberry）- 可选
- ✅ 设备权限和用户组管理

## 使用示例

### 基础启用（无GUI）
```nix
mySystem.services.drivers.bluetooth = {
  enable = true;
  gui = false;  # 仅使用命令行工具
};
```

### 完整启用（含GUI）
```nix
mySystem.services.drivers.bluetooth = {
  enable = true;
  gui = true;   # 包含图形管理工具
};
```

## 验证方法

### 检查服务状态
```bash
systemctl status bluetooth
```

### 检查蓝牙控制器
```bash
bluetoothctl show
```

### 检查已安装工具
```bash
which blueman-manager  # GUI 管理器
which bluetuith        # TUI 管理器
which pavucontrol      # 音频控制面板
```

## 简化效果

- **文件数量**：从 3 个文件减少到 1 个文件
- **配置选项**：从 8+ 个选项简化到 2 个核心选项
- **维护复杂度**：大幅降低，易于理解和修改
- **功能完整性**：保持所有必要功能，无功能损失

这种简化方式在保持功能完整的同时，大幅降低了配置复杂度，体现了"简单即美"的设计原则。
