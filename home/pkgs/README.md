# Home Package Management - 月相主题设计

本文档说明 `home/pkgs` 模块的月相主题重构设计，与 `system/pkgs` 保持一致的结构。

## 📦 Toolkits (工具包)

### 🌒 峨眉月 (waxing-crescent) - 基础家庭工具
- **目标**: 提供最基础的命令行工具
- **包含**: bat, eza, fd, ripgrep, tree, fzf, zoxide, 基础压缩工具, fastfetch, jq, openssh
- **适用**: 所有用户的基础配置

### 🌓 上弦月 (first-quarter) - 开发和终端工具
- **目标**: 提供进阶的开发和系统监控工具
- **包含**: 高级文件工具, 文本处理, Git工具, 基础监控, 网络工具, 开发辅助
- **适用**: 需要开发能力的用户

### 🌔 盈凸月 (waxing-gibbous) - 高级工具套件
- **目标**: 提供专业级的工具套件
- **包含**: 高级压缩, 云同步, 文件管理器, 硬件信息, 高级网络工具, 安全工具
- **适用**: 专业用户和高级场景

### 🌕 满月 (full-moon) - 完整工具生态
- **目标**: 提供最完整的工具生态
- **包含**: 网络分析, 系统调试, 性能分析, 虚拟化, 多媒体处理, 科学计算
- **适用**: 专业开发者和系统管理员

## 📱 Apps (应用程序)

### 🌘 残月 (waning-crescent) - 基础应用核心
- **目标**: 提供最基础的桌面应用
- **包含**: fish, nushell, ghostty, qutebrowser
- **适用**: 轻量级桌面使用

### 🌗 下弦月 (last-quarter) - 开发和终端应用
- **目标**: 提供开发相关的应用程序
- **包含**: 开发编辑器, 进阶终端, 文件管理器
- **适用**: 开发者和重度终端用户

### 🌖 亏凸月 (waning-gibbous) - 桌面生产力套件
- **目标**: 提供完整的桌面生产力应用
- **包含**: 主流浏览器, 通讯工具, 办公软件, 媒体工具
- **适用**: 日常办公和多媒体需求

### 🌑 新月 (new-moon) - 完整应用生态
- **目标**: 提供最完整的应用生态
- **包含**: 游戏平台, 网络工具, 专业开发工具, 专业媒体工具, 虚拟化
- **适用**: 专业用户和特殊需求

## 🚀 使用示例

### 轻量级配置 (zlritsu)
```nix
toolkits = {
  waxingCrescent.enable = true;  # 仅基础工具
};
apps = {
  waningCrescent.enable = true;  # 仅基础应用
};
```

### 开发者配置 (laptop)
```nix
toolkits = {
  waxingCrescent.enable = true;  # 基础工具
  firstQuarter.enable = true;    # 开发工具
  waxingGibbous.enable = true;   # 高级工具
};
apps = {
  waningCrescent.enable = true;  # 基础应用
  lastQuarter.enable = true;     # 开发应用
};
```

### 专业工作配置 (work)
```nix
toolkits = {
  waxingCrescent.enable = true;  # 基础工具
  firstQuarter.enable = true;    # 开发工具
  waxingGibbous.enable = true;   # 高级工具
  fullMoon.enable = true;        # 完整工具生态
};
apps = {
  waningCrescent.enable = true;  # 基础应用
  lastQuarter.enable = true;     # 开发应用
  waningGibbous.enable = true;   # 生产力套件
  newMoon.enable = true;         # 完整应用生态
};
```

## 🔄 与 system/pkgs 的一致性

- **结构一致**: 相同的月相主题命名和层级设计
- **渐进式**: 从基础到高级的渐进式启用
- **模块化**: 每个月相阶段都是独立的功能模块
- **配置灵活**: 可根据用户需求灵活组合不同阶段
