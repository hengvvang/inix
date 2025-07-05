# Localization 模块重构说明

## 概述

`system/localization` 模块已按照模块化设计原则进行重构，采用分布式配置架构。用户只需选择具体的 inputMethod 和 timeZone，即可获得完整的本地化配置，无需额外的 enable 开关。

## 核心设计理念

**"选择即配置"** - 当用户选择具体的输入法时，系统会自动应用相关的 locale、字体等完整本地化配置。

## 目录结构

```
system/localization/
├── default.nix              # 统一入口，仅做导入
├── timeZone/
│   ├── default.nix          # 时区选项定义
│   ├── shanghai.nix         # 上海时区实现
│   ├── newYork.nix          # 纽约时区实现
│   └── losAngeles.nix       # 洛杉矶时区实现
└── inputMethod/
    ├── default.nix          # 输入法选项定义
    ├── fcitx5.nix           # Fcitx5 输入法实现（包含完整本地化配置）
    └── ibus.nix             # IBus 输入法实现（包含完整本地化配置）
```

## 设计原则

### 1. 分布式配置
- **顶层 (`default.nix`)**：仅负责模块导入，不包含任何配置
- **中层选项定义**：定义可用的选项，不设置默认值
- **底层实现**：包含完整的功能实现和相关配置

### 2. 完整性原则
- 每个输入法实现都包含完整的本地化配置（locale、字体等）
- 用户选择一个输入法，即可获得完整的中文环境

### 3. 无默认值设计
- 不设置任何默认值，用户必须显式选择
- 避免隐式配置，增强配置的明确性

## 使用示例

### 基础配置
```nix
{
  mySystem.localization = {
    # 时区选择 (必选其一)
    timeZone.shanghai = true;
    
    # 输入法选择 (必选其一，会自动包含 locale 和字体)
    inputMethod.fcitx5 = true;
  };
}
```

### 美国时区配置
```nix
{
  mySystem.localization = {
    timeZone.newYork = true;      # 纽约时区
    inputMethod.ibus = true;      # IBus 输入法 + 完整本地化
  };
}
```

## 配置包含的内容

### 输入法配置自动包含
当选择任一输入法时，会自动配置：

**基础本地化设置**：
- `i18n.defaultLocale = "zh_CN.UTF-8"`
- 完整的 `extraLocaleSettings`

**字体支持**：
- Noto 字体系列（CJK 支持）
- Source Han 字体系列
- WenQuanYi 字体系列

**输入法特定配置**：
- Fcitx5：完整的插件和主题支持
- IBus：多语言引擎支持

### 时区配置
- 精确的时区设置
- NTP 时间同步
- 互斥逻辑保护

## 支持的配置

### 时区选项
- `mySystem.localization.timeZone.shanghai`：中国上海时区
- `mySystem.localization.timeZone.newYork`：美国纽约时区  
- `mySystem.localization.timeZone.losAngeles`：美国洛杉矶时区

### 输入法选项  
- `mySystem.localization.inputMethod.fcitx5`：Fcitx5 输入法 + 完整本地化
- `mySystem.localization.inputMethod.ibus`：IBus 输入法 + 完整本地化

## 互斥逻辑

### 时区互斥
同时只能启用一个时区配置。

### 输入法互斥
同时只能启用一个输入法配置。

## 移除的内容

- **`localization.enable` 选项**：不再需要额外的开关
- **全局默认值**：用户必须显式选择配置
- **Fcitx4 支持**：已完全移除

## 配置迁移

### 从旧配置迁移
```nix
# 旧配置方式
mySystem.localization = {
  enable = true;                    # ❌ 移除
  timeZone.shanghai = true;         # ✅ 保持不变  
  inputMethod.fcitx5 = true;        # ✅ 保持不变
};

# 新配置方式
mySystem.localization = {
  timeZone.shanghai = true;         # ✅ 直接选择
  inputMethod.fcitx5 = true;        # ✅ 自动包含完整本地化
};
```

## 构建验证

```bash
# 构建系统配置验证
nix build .#nixosConfigurations.hengvvang.config.system.build.toplevel

# 构建 Home Manager 配置验证  
nix build .#homeConfigurations.hengvvang.activationPackage
```

## 示例配置文件

- `hosts/newyork-example-configuration.nix`：纽约时区 + IBus 示例
- `hosts/losangeles-example-configuration.nix`：洛杉矶时区 + Fcitx5 示例
- `hosts/laptop/configuration.nix`：实际使用的配置文件

## 优势总结

1. **简化配置**：选择输入法即获得完整本地化环境
2. **模块内聚**：相关配置集中在一个地方
3. **配置明确**：用户必须显式选择，避免隐式行为
4. **维护简单**：减少配置层级和依赖关系
5. **扩展友好**：添加新选项只需创建对应实现文件
