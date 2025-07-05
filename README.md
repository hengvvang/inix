# NixOS + Home Manager 分层配置

基于 NixOS + Home Manager 的分层模块化配置系统，提供层次化的可选功能管理。

## 特点

- **分层默认值管理**：每层 default.nix 负责管理子模块的启用/禁用默认值
- **完全可选功能**：所有功能模块都可独立开关
- **优先级明确**：用户配置 > 分层默认值 > 模块默认值
- **简化主机配置**：主机只需启用顶层模块，分层默认值自动生效

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

## 使用方法

### 主机配置示例

```nix
# hosts/laptop/home.nix  
{
  imports = [ ../../home ];
  
  # 仅需启用顶层模块，分层默认值自动生效
  myHome = {
    apps.enable = true;        # 启用基础应用 (shells, 部分编辑器)
    development.enable = true; # 启用开发环境 (js, python, git)
    profiles.enable = true;    # 启用基础配置 (环境变量, 字体)
    toolkits.enable = true;    # 启用实用工具
  };
  
  # 可选：覆盖特定子模块
  myHome.apps.editors.enable = true;  # 启用编辑器
  myHome.development.languages.rust.enable = true; # 启用 Rust
}
```

### 分层默认值策略

每个 default.nix 为子模块设置合理的默认值：

- **apps**: shells 默认启用，editors/terminals/yazi 默认禁用
- **development.languages**: javascript/python 默认启用，其他禁用  
- **development.versionControl**: git/lazygit 默认启用
- **profiles**: 基础配置 (环境变量、字体) 默认启用
- **toolkits**: 所有实用工具默认启用

### 优先级规则

1. **用户显式配置** (最高优先级)
2. **分层默认值** (lib.mkDefault)
3. **模块默认值** (最低优先级)

## 构建测试

```bash
# 构建 Home Manager 配置
nix build .#homeConfigurations.hengvvang.activationPackage

# 构建系统配置  
nix build .#nixosConfigurations.hengvvang.config.system.build.toplevel

# 构建并切换 Home Manager
home-manager switch --flake .

# 构建并切换系统
sudo nixos-rebuild switch --flake .
```

## 实现状态

✅ **已完成**:
- 所有系统模块的 enable 选项和分层默认值
- 所有 home 模块的 enable 选项和分层默认值  
- 统一的 myHome 命名空间
- 分层默认值配置 (apps, development, profiles, toolkits)
- 所有子模块的 enable 选项 (editors, shells, languages, version-control, embedded, env-var, fonts, toolkits 等)
- 主机配置简化 (只需启用顶层模块)
- 构建测试通过 (系统和 Home Manager)
- **移除中间配置文件**: modules.nix 和 home-modules.nix 已删除，所有配置直接在主机文件中

✅ **分层默认值设计**:
- apps: shells(true), editors(false), terminals(false), yazi(false)
- development: languages中js/python(true), version-control中git/lazygit(true), embedded(true)
- profiles: env-var(true), fonts(true)  
- toolkits: user/system所有工具(true)

**分层模块化配置系统已完全实现！** 用户只需在主机配置中启用顶层模块，即可获得合理的默认配置，同时保持细粒度控制能力。

## 配置架构

### 直接主机配置 (当前实现)

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
2. **无中间层**: 移除了 modules.nix 和 home-modules.nix，简化配置结构
3. **分层默认值**: 每层 default.nix 提供合理的默认策略
4. **灵活覆盖**: 可以精确控制任何子模块的启用状态
5. **易维护**: 配置变更直接在主机文件中进行
6. **类型安全**: 通过 NixOS 模块系统保证配置正确性

## 测试状态

✅ NixOS 配置构建成功  
✅ Home Manager 配置构建成功  
✅ 中间配置文件已移除 (modules.nix, home-modules.nix)
✅ 所有模块配置直接在主机文件中
✅ 分层默认值系统正常工作
