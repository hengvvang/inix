# VSCode 和 Zed Editor 配置指南

## 概述

本配置为您的 NixOS Home Manager 环境添加了 Visual Studio Code 和 Zed Editor 的完整配置支持。两个编辑器都提供了三种配置方式，您可以根据需要选择最适合的方式。

## 配置结构

```
home/dotfiles/
├── vscode/                    # VSCode 配置目录
│   ├── default.nix           # 主配置文件
│   ├── homemanager.nix       # Home Manager 方式 (推荐)
│   ├── direct.nix            # 直接安装方式
│   ├── external.nix          # 外部配置文件方式
│   └── configs/              # 外部配置文件
│       ├── settings.json
│       ├── keybindings.json
│       └── extensions.json
└── zed/                      # Zed Editor 配置目录
    ├── default.nix           # 主配置文件
    ├── homemanager.nix       # Home Manager 方式 (推荐)
    ├── direct.nix            # 直接安装方式
    ├── external.nix          # 外部配置文件方式
    └── configs/              # 外部配置文件
        ├── settings.json
        ├── keymap.json
        └── themes/
            └── custom-dark.json
```

## 启用配置

在您的 Home Manager 配置中启用所需的编辑器：

### 启用 VSCode

```nix
{
  # 启用 VSCode 配置
  myHome.dotfiles.vscode.enable = true;
  myHome.dotfiles.vscode.method = "homemanager";  # 或 "direct" 或 "external"
}
```

### 启用 Zed Editor

```nix
{
  # 启用 Zed Editor 配置
  myHome.dotfiles.zed.enable = true;
  myHome.dotfiles.zed.method = "homemanager";     # 或 "direct" 或 "external"
}
```

## 配置方式说明

### 1. HomeManager 方式 (推荐)

**优点：**
- 声明式配置，版本控制友好
- 自动管理扩展和设置
- 配置更改后自动应用

**适用场景：**
- 希望完全声明式管理配置
- 需要在多台机器间同步配置
- 喜欢 Nix 的声明式风格

**使用方法：**
```nix
myHome.dotfiles.vscode.method = "homemanager";
```

### 2. Direct 方式

**优点：**
- 简单直接，仅安装软件包
- 保持原生的配置体验
- 灵活性最高

**适用场景：**
- 希望手动配置编辑器
- 不需要配置管理
- 临时使用或测试

**使用方法：**
```nix
myHome.dotfiles.vscode.method = "direct";
```

### 3. External 方式

**优点：**
- 配置文件独立管理
- 可以复用现有配置文件
- 配置文件可读性好

**适用场景：**
- 有现有的配置文件需要迁移
- 希望配置文件独立于 Nix 表达式
- 需要复杂的配置文件结构

**使用方法：**
```nix
myHome.dotfiles.vscode.method = "external";
```

## VSCode 特性

### 预装扩展
- Python 开发支持
- C/C++ 开发支持
- Rust 开发支持
- TypeScript/JavaScript 支持
- Nix 语言支持
- Git 增强工具 (GitLens)
- 代码格式化 (Prettier, ESLint)
- Vim 键位绑定
- Catppuccin 主题
- Material 图标主题

### 配置特点
- 使用 JetBrains Mono 字体
- 启用字体连字
- 自动保存和格式化
- Vim 模式集成
- 暗色主题 (Catppuccin Mocha)
- 关闭遥测数据收集

## Zed Editor 特性

### 语言支持
- Nix 语言服务器
- Rust 分析器
- Python 语言服务器
- TypeScript 语言服务器
- HTML/CSS/JSON 支持

### 配置特点
- 高性能渲染
- 内建协作功能
- 现代化界面
- Vim 键位支持
- 智能代码补全
- 实时语法检查

## 常用快捷键

### 通用快捷键
- `Ctrl+Shift+P`: 命令面板
- `Ctrl+P`: 快速文件打开
- `Ctrl+Shift+E`: 文件资源管理器
- `Ctrl+Shift+G`: Git 面板
- `Ctrl+/`: 切换注释

### Vim 风格导航
- `Ctrl+H`: 向左导航
- `Ctrl+L`: 向右导航
- `Ctrl+J`: 向下导航
- `Ctrl+K`: 向上导航

## 自定义配置

### 修改 HomeManager 配置
编辑对应的 `homemanager.nix` 文件，然后重新构建：

```bash
home-manager switch
```

### 修改外部配置文件
编辑 `configs/` 目录下的配置文件，然后重新构建：

```bash
home-manager switch
```

## 故障排除

### VSCode 扩展问题
- 检查 `mutableExtensionsDir` 设置
- 确认扩展包在 nixpkgs 中可用
- 尝试手动安装扩展

### Zed 语言服务器问题
- 确认语言服务器已安装在 `extraPackages` 中
- 检查 PATH 环境变量
- 重启 Zed Editor

### 配置不生效
- 运行 `home-manager switch` 重新应用配置
- 重启编辑器
- 检查配置文件语法

## 建议的工作流程

1. **首次使用**: 选择 `homemanager` 方式开始
2. **配置调试**: 根据需要修改配置文件
3. **稳定后**: 继续使用 `homemanager` 方式
4. **特殊需求**: 切换到 `external` 方式进行精细控制

## 版本兼容性

- 配置基于 Home Manager 稳定版本
- 扩展版本会随 nixpkgs 更新
- 建议定期更新 nixpkgs 频道

---

享受您的高效编码体验！ 🚀
