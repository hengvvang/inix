# 模块化 NixOS 和 Home Manager 配置系统

## 概述

本配置系统实现了完全模块化的设计，每个最底层模块都有自己的可选开关，默认关闭。所有模块都在 default.nix 中引入，然后在主机的 configuration.nix 和 home.nix 中直接选择开启所需的模块。

## 架构说明

### 系统模块 (NixOS)

位于 `system/` 目录，包含以下可选模块：

- **desktop-environment.nix** - 桌面环境配置 (Cosmic/Gnome/KDE)
  - 选项: `mySystem.desktop.enable` (默认: false)
- **hardware.nix** - 硬件配置 (NVIDIA/音频/触摸板/打印)
  - 选项: `mySystem.hardware.enable` (默认: false)
- **localization.nix** - 本地化配置 (中文输入法/时区/语言)
  - 选项: `mySystem.localization.enable` (默认: false)
- **users.nix** - 用户配置 (用户账户/Docker/SSH)
  - 选项: `mySystem.users.enable` (默认: false)
- **packages.nix** - 系统级软件包
  - 选项: `mySystem.packages.enable` (默认: false)

### 用户模块 (Home Manager)

位于 `home/` 目录，包含以下可选模块：

- **apps/** - 应用程序配置
  - 选项: `myHome.apps.enable` (默认: false)
  - editors/ - 编辑器配置: `myHome.apps.editors.enable` (默认: false)
  - shells/ - Shell 配置
  - terminals/ - 终端配置
  - yazi/ - 文件管理器: `myHome.apps.yazi.enable` (默认: false)
- **development/** - 开发环境
  - 选项: `myHome.development.enable` (默认: false)
  - languages/ - 编程语言支持
  - version-control/ - 版本控制工具
  - embedded/ - 嵌入式开发工具
- **profiles/** - 配置文件
  - 选项: `myHome.profiles.enable` (默认: false)
  - env-var/ - 环境变量配置
  - fonts/ - 字体配置
- **toolkits/** - 工具包
  - 选项: `myHome.toolkits.enable` (默认: false)
  - system/ - 系统工具
  - user/ - 用户工具

## 主机特定配置

### laptop 配置

当前 laptop 主机配置位于 `hosts/laptop/`，包含：

- **configuration.nix** - NixOS 系统配置入口，直接包含模块选择
- **home.nix** - Home Manager 用户配置入口，直接包含模块选择
- **hardware-configuration.nix** - 硬件特定配置

在 laptop 的 configuration.nix 中直接启用所有系统模块：

```nix
# configuration.nix
mySystem = {
  desktop.enable = true;
  hardware.enable = true;
  localization.enable = true;
  users.enable = true;
  packages.enable = true;
};
```

在 laptop 的 home.nix 中直接启用所有 Home Manager 模块：

```nix
# home.nix  
myHome = {
  apps = {
    enable = true;
    yazi.enable = true;
    editors.enable = true;
  };
  development.enable = true;
  profiles.enable = true;
  toolkits.enable = true;
};
```

## 分层默认配置系统

本配置系统实现了**三层默认值控制**：

### 第一层：顶层默认策略 (home/default.nix, system/default.nix)

**Home Manager 顶层策略**:
- `apps.enable = true` - 应用程序默认开启 (用户日常必需)  
- `development.enable = true` - 开发环境默认开启 (开发者机器)
- `profiles.enable = true` - 配置文件默认开启 (字体和环境变量重要)
- `toolkits.enable = false` - 工具包默认关闭 (让用户选择)

**NixOS 系统层策略**:
- `hardware.enable = true` - 硬件配置默认开启 (系统基础需求)
- `users.enable = true` - 用户配置默认开启 (系统必需)  
- `localization.enable = true` - 本地化默认开启 (中文环境常用)
- `desktop.enable = false` - 桌面环境默认关闭 (让用户选择图形界面)
- `packages.enable = false` - 系统包默认关闭 (避免过多软件)

### 第二层：功能模块默认策略

每个功能模块在自己的 default.nix 中设置子模块的默认启用策略：

- **development/default.nix**: 版本控制和语言支持默认开启，嵌入式开发默认关闭
- **profiles/default.nix**: 环境变量和字体配置都默认开启  
- **toolkits/default.nix**: 用户工具默认开启，系统工具默认关闭
- **apps/default.nix**: 核心应用(编辑器、yazi、shells)默认开启，终端默认关闭

### 第三层：最底层模块选项

所有最底层模块都有 `enable` 选项，默认值为 `false`，但会被上层默认策略覆盖。

## 配置优先级

1. **主机显式配置** (configuration.nix, home.nix) - 最高优先级
2. **上层默认策略** (lib.mkDefault) - 中等优先级  
3. **模块默认值** (default = false) - 最低优先级

## 使用示例

### 基础配置 (依赖分层默认值)
```nix
# home.nix - 只启用顶层模块，使用所有默认策略
myHome = {
  apps.enable = true;        # → 自动启用编辑器、yazi、shells
  development.enable = true; # → 自动启用版本控制、语言支持  
  profiles.enable = true;    # → 自动启用字体、环境变量
};
```

### 自定义配置 (覆盖默认值)
```nix  
# home.nix - 覆盖特定默认策略
myHome = {
  apps.enable = true;
  development = {
    enable = true;
    embedded.enable = true;  # 覆盖默认关闭，启用嵌入式开发
  };
  toolkits = {
    enable = true;           # 覆盖默认关闭
    system.enable = true;    # 启用系统工具
  };
};
```

## 使用方法

### 构建配置

1. **构建 NixOS 配置**:

   ```bash
   nix build .#nixosConfigurations.hengvvang.config.system.build.toplevel
   ```

2. **构建 Home Manager 配置**:

   ```bash
   nix build .#homeConfigurations.hengvvang.activationPackage
   ```

### 创建新主机配置

要为新主机创建配置：

1. 在 `hosts/` 下创建新主机目录
2. 复制 `laptop/` 下的配置文件模板
3. 在新主机的 `configuration.nix` 和 `home.nix` 中选择性启用所需模块
4. 更新 `flake.nix` 添加新的配置入口

### 自定义模块组合

通过修改主机的配置文件，可以轻松定制不同的配置组合：

```nix
# 例如：服务器配置 - configuration.nix
mySystem = {
  desktop.enable = false;        # 无桌面环境
  hardware.enable = true;        # 基础硬件支持
  localization.enable = false;   # 无中文输入法
  users.enable = true;           # 用户和SSH
  packages.enable = false;       # 无图形软件
};

# 对应的 home.nix
myHome = {
  apps.enable = false;           # 无图形应用
  development.enable = true;     # 保留开发工具
  profiles.enable = false;       # 无字体配置
  toolkits.enable = true;        # 保留系统工具
};
```

## 优势

1. **简洁明了**: 模块选择直接在主机配置文件中，无需额外的中间文件
2. **默认安全**: 所有模块默认关闭，避免意外启用不需要的功能
3. **模块化**: 每个功能模块独立，可选择性启用
4. **可重用**: 模块在不同主机间可复用
5. **易维护**: 配置变更只影响相关模块
6. **灵活**: 不同主机可有完全不同的配置组合
7. **类型安全**: 通过 NixOS 模块系统保证配置正确性

## 测试状态

✅ NixOS 配置构建成功  
✅ Home Manager 配置构建成功  
✅ 所有模块正确启用并工作
✅ 直接在主机文件中配置模块选择
