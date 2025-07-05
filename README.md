# NixOS + Home Manager 分层模块化配置系统

本项目实现了一个高度模块化的 NixOS 和 Home Manager 配置系统，采用**主机完全控制**模式，每台主机可以独立决定启用哪些功能模块。

## 🎯 设计原则

### 1. 主机完全控制
- **所有模块开关都在主机配置中决定**：`hosts/{hostname}/configuration.nix` 和 `hosts/{hostname}/home.nix`
- **default.nix 只做模块导入**：不设置顶层模块的 enable 默认值
- **一目了然的主机配置**：所有启用的功能模块在主机配置文件中清晰可见

### 2. 选项就近定义
- **无中间层**：删除了 `lib/options.nix`、`modules.nix` 等中间层
- **选项定义在功能模块内**：每个功能模块内部定义自己的 `enable` 选项
- **系统模块**：`system/*.nix` 中定义 `mySystem.*` 选项
- **Home 模块**：`home/*/default.nix` 中定义 `myHome.*` 选项

### 3. 分层默认值仅用于功能子模块
- **顶层模块无默认值**：`mySystem.*` 和 `myHome.*` 顶层模块不设置默认 enable 值
- **功能子模块有合理默认值**：如 `myHome.apps.editors.enable = lib.mkDefault true`
- **主机配置优先级最高**：主机显式配置会覆盖所有默认值

### 4. 适配多主机场景
- **灵活的模块组合**：不同主机可以选择不同的模块组合
- **配置模板清晰**：桌面版、服务器版等不同场景有对应的配置示例

## 分层架构

### 顶层模块 (home/default.nix)
- 统一启用下级模块: apps, development, profiles, toolkits

### 二级模块

#### apps/ - 应用程序模块
- 选项: `myHome.apps.enable` (默认: true)
- editors/ - 编辑器配置: `myHome.apps.editors.enable` (默认: false)
  - vim, vscode, micro, zed 支持
- shells/ - Shell 配置: `myHome.apps.shells.enable` (默认: true)  
  - fish, zsh, nushell, aliases, prompts 支持
- terminals/ - 终端配置: `myHome.apps.terminals.enable` (默认: false)
  - ghostty 支持
- yazi/ - 文件管理器: `myHome.apps.yazi.enable` (默认: false)

#### development/ - 开发环境模块
- 选项: `myHome.development.enable` (默认: false)
- languages/ - 编程语言: `myHome.development.languages.enable` (默认: false)
  - c, cpp, javascript (默认启用), python (默认启用), rust, typescript 支持
- versionControl/ - 版本控制: `myHome.development.versionControl.enable` (默认: false)  
  - git, lazygit 支持 (默认启用)
- embedded/ - 嵌入式开发: `myHome.development.embedded.enable` (默认: false)
  - toolchain 支持 (默认启用)

#### profiles/ - 配置文件模块
- 选项: `myHome.profiles.enable` (默认: true)
- envVar/ - 环境变量: `myHome.profiles.envVar.enable` (默认: true)
  - environment 配置 (默认启用)
- fonts/ - 字体配置: `myHome.profiles.fonts.enable` (默认: true)
  - 基础字体支持 (默认启用)

#### toolkits/ - 工具包模块
- 选项: `myHome.toolkits.enable` (默认: true)  
- user/ - 用户工具: `myHome.toolkits.user.enable` (默认: true)
  - utilities 实用工具 (默认启用)
- system/ - 系统工具: `myHome.toolkits.system.enable` (默认: true)
  - utilities, hardware, network, monitor 工具 (默认启用)

## 🚀 使用方法

### 1. 主机配置示例

#### 桌面/笔记本配置（完整功能）

**`hosts/laptop/configuration.nix`**：
```nix
{
  imports = [ ./hardware-configuration.nix ../../system ];
  
  # 系统模块配置 - 完全由主机决定启用哪些模块
  mySystem = {
    desktop.enable = true;      # 桌面环境
    hardware.enable = true;     # 硬件配置
    localization.enable = true; # 本地化配置
    users.enable = true;        # 用户配置
    packages.enable = true;     # 系统包
  };
}
```

**`hosts/laptop/home.nix`**：
```nix
{
  imports = [ ../../home ];
  
  # Home Manager 模块配置 - 完全由主机决定启用哪些模块
  myHome = {
    apps.enable = true;         # 应用程序
    development.enable = true;  # 开发环境
    profiles.enable = true;     # 配置文件
    toolkits.enable = true;     # 工具包
  };
}
```

#### 服务器配置（最小化）

**`hosts/server/configuration.nix`**：
```nix
{
  imports = [ ./hardware-configuration.nix ../../system ];
  
  # 服务器配置 - 仅启用必需模块
  mySystem = {
    desktop.enable = false;     # 服务器不需要桌面
    hardware.enable = true;     # 基础硬件配置
    localization.enable = true; # 本地化配置
    users.enable = true;        # 用户配置
    packages.enable = false;    # 服务器不需要桌面软件包
  };
}
```

**`hosts/server/home.nix`**：
```nix
{
  imports = [ ../../home ];
  
  # 服务器用户配置 - 仅启用开发和shell
  myHome = {
    apps.enable = true;         # 基础应用（编辑器、shell）
    development.enable = true;  # 开发工具
    profiles.enable = false;    # 不需要字体等桌面配置
    toolkits.enable = true;     # 系统管理工具
  };
}
```

### 2. 构建和激活

```bash
# 构建系统配置
nix build .#nixosConfigurations.{hostname}.config.system.build.toplevel

# 构建 Home Manager 配置
nix build .#homeConfigurations.{username}.activationPackage

# 应用系统配置
sudo nixos-rebuild switch --flake .#{hostname}

# 应用 Home Manager 配置
home-manager switch --flake .#{username}
```

## 实现状态

✅ **已完成**:
- 所有系统模块的 enable 选项和分层默认值
- 所有 home 模块的 enable 选项和分层默认值  
- 统一的 myHome 命名空间
- 分层默认值配置 (apps, development, profiles, toolkits)
- 所有子模块的 enable 选项 (editors, shells, languages, version-control, embedded, env-var, fonts, toolkits 等)
- **移除中间配置文件**: modules.nix 和 home-modules.nix 已删除，所有配置直接在主机文件中
- **移除顶层默认值**: system/default.nix 和 home/default.nix 不再设置模块默认值
- **主机完全控制**: 每台主机在 configuration.nix 和 home.nix 中完全决定启用哪些模块

✅ **多主机配置支持**:
- laptop: 完整桌面环境 (所有模块启用)
- server示例: 最小化服务器配置 (仅必需模块)
- 功能模块内部仍保持合理的分层默认值

✅ **分层默认值设计** (功能模块内部):
- apps: shells(true), editors(true), terminals(false), yazi(true)
- development: languages中js/python(true), version-control中git/lazygit(true), embedded(true)
- profiles: env-var(true), fonts(true)  
- toolkits: user/system所有工具(true)

**多主机分层模块化配置系统已完全实现！** 每台主机可以根据用途独立配置模块，同时保持功能模块内部的合理默认值。

## 配置架构

### 模块选项定义位置

所有模块选项都直接在对应的模块文件中定义，使配置更加直观：

**系统模块选项** (在各自的 `system/*.nix` 中):
```nix
# system/desktop-environment.nix
options.mySystem.desktop.enable = lib.mkEnableOption "桌面环境";

# system/hardware.nix  
options.mySystem.hardware.enable = lib.mkEnableOption "硬件配置";

# system/localization.nix
options.mySystem.localization.enable = lib.mkEnableOption "本地化配置";

# system/users.nix
options.mySystem.users.enable = lib.mkEnableOption "用户配置";

# system/packages.nix
options.mySystem.packages.enable = lib.mkEnableOption "系统包配置";
```

**Home Manager模块选项** (在各自的 `home/*/default.nix` 中):
```nix
# home/apps/default.nix
options.myHome.apps.enable = lib.mkEnableOption "应用程序模块";

# home/development/default.nix
options.myHome.development.enable = lib.mkEnableOption "开发环境模块";

# home/profiles/default.nix
options.myHome.profiles.enable = lib.mkEnableOption "配置文件模块";

# home/toolkits/default.nix
options.myHome.toolkits.enable = lib.mkEnableOption "工具包模块";
```

### 主机完全控制配置模式

**顶层 default.nix 不设置默认值**，完全由主机配置决定启用哪些模块，适合多主机环境：

**系统配置** (`hosts/laptop/configuration.nix` - 桌面主机):
```nix
{
  imports = [ 
    ./hardware-configuration.nix
    ../../system
  ];

  # 桌面主机：启用完整功能
  mySystem = {
    desktop.enable = true;      # 图形界面
    hardware.enable = true;     # 硬件支持
    localization.enable = true; # 中文环境
    users.enable = true;        # 用户配置
    packages.enable = true;     # 完整软件
  };
}
```

**用户配置** (`hosts/laptop/home.nix` - 桌面用户):
```nix
{
  imports = [ ../../home ];
  
  # 桌面用户：完整开发和办公环境
  myHome = {
    apps.enable = true;         # 图形应用
    development.enable = true;  # 开发工具
    profiles.enable = true;     # 字体配置
    toolkits.enable = true;     # 实用工具
  };
}
```

### 不同主机类型示例

**服务器配置** (`hosts/server/configuration.nix`):
```nix
mySystem = {
  desktop.enable = false;     # 无图形界面
  hardware.enable = true;     # 基础硬件
  localization.enable = false; # 英文环境
  users.enable = true;        # SSH访问
  packages.enable = false;    # 最小安装
};
```

**服务器用户配置** (`hosts/server/home.nix`):
```nix
myHome = {
  apps.enable = false;        # 无图形应用
  development.enable = true;  # 开发工具
  profiles.enable = false;    # 无字体需求
  toolkits.enable = true;     # 系统管理工具
};
```

所有模块启用配置直接在主机的配置文件中进行：

**系统配置** (`hosts/laptop/configuration.nix`):
```nix
{
  imports = [ 
    ./hardware-configuration.nix
    ../../system
  ];

  # 直接配置系统模块
  mySystem = {
    desktop.enable = true;
    hardware.enable = true;
    localization.enable = true;
    users.enable = true;
    packages.enable = true;
  };
}
```

**用户配置** (`hosts/laptop/home.nix`):
```nix
{
  imports = [ ../../home ];
  
  # 直接配置 Home Manager 模块
  myHome = {
    apps.enable = true;
    development.enable = true;
    profiles.enable = true;
    toolkits.enable = true;
  };
}
```

### 优势

1. **配置直观**: 所有模块启用配置直接在主机文件中，一目了然
2. **选项就近定义**: 选项定义在对应模块中，无需查找外部文件
3. **无中间层**: 移除了 modules.nix、home-modules.nix 和 lib/options.nix
4. **分层默认值**: 每层 default.nix 提供合理的默认策略
5. **灵活覆盖**: 可以精确控制任何子模块的启用状态
6. **易维护**: 配置变更直接在主机文件中进行
7. **减少重复**: 选项定义不再重复，只在模块中定义一次
8. **类型安全**: 通过 NixOS 模块系统保证配置正确性

## 测试状态

✅ NixOS 配置构建成功  
✅ Home Manager 配置构建成功  
✅ 中间配置文件已移除 (modules.nix, home-modules.nix, lib/options.nix)
✅ 所有模块配置直接在主机文件中
✅ 选项定义就近放置在对应模块中
✅ 分层默认值系统正常工作
