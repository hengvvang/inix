# Lib 模块重构说明

## 文件结构

```
lib/
├── default.nix      # 入口文件，负责导入和导出
├── utils.nix        # 核心工具函数库
└── architectures.nix # 支持的系统架构列表
```

## 主要函数

### `supportedSystems`
支持的系统架构列表，替代了原来的 `architectures`。

### `pkgsForSystem`
为每个系统生成 pkgs 集合的属性集，替代了原来的 `pkgsFor`。

### `forEachSystem`
为每个系统执行函数的辅助工具，功能与原来相同。

### `pkgsFor`
为特定系统获取 pkgs 的函数，用法：`pkgsFor "x86_64-linux"`。

## 向后兼容

为了确保现有代码的兼容性，`default.nix` 中保留了：
- `architectures` 作为 `supportedSystems` 的别名

## 迁移指南

如果要完全迁移到新的命名，可以：
1. 将 `architectures` 替换为 `supportedSystems`
2. 将 `pkgsFor.${system}` 替换为 `pkgsForSystem.${system}` 或 `pkgsFor system`
