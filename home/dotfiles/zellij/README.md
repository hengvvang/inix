# Zellij 终端多路复用器配置

Zellij 是一个现代化的终端多路复用器，提供简洁的用户界面和强大的功能。

## 配置特点

### 🎯 三种配置方式
- **homemanager**: 使用 Home Manager 原生配置模块（推荐）
- **direct**: 直接文件管理，简化配置
- **external**: 外部配置文件，完全自定义

### ⚡ 核心功能
- **现代化界面**: Catppuccin Mocha 主题
- **Vi风格导航**: 熟悉的 hjkl 键位
- **智能布局**: 多种预设布局（默认、开发、工作）
- **Shell集成**: Fish/Bash 自动启动和会话管理
- **剪贴板支持**: Wayland 原生支持

## 快速使用

### 基础键绑定
```
# 基础控制
Ctrl+q          # 退出 Zellij
Ctrl+d          # 分离会话

# 窗格导航（Vi风格）
Alt+h/j/k/l     # 左/下/上/右移动焦点

# 窗格分割
Alt+|           # 垂直分割
Alt+-           # 水平分割

# 标签页管理
Alt+n           # 新建标签页
Alt+1/2/3...    # 切换到指定标签页

# 模式切换
Ctrl+p          # 窗格模式
Ctrl+t          # 标签页模式
Ctrl+r          # 调整大小模式
Ctrl+s          # 滚动模式
```

### Shell 函数
```fish
# Fish Shell 中的便捷函数
zj              # 附加到默认会话
zj my-project   # 附加到指定会话
zj-dev          # 启动开发布局
zj-work         # 启动工作布局
```

## 预设布局

### 默认布局 (default)
- **Editor**: 80% 编辑器 + 20% 侧边栏
- **Terminal**: 纯终端环境

### 开发布局 (dev)
- **Code**: 主编辑器 + 终端 + 工具栏
- **Test**: 测试运行 + 结果展示
- **Monitor**: 系统监控 + 日志

### 工作布局 (work)
- **Project-1/2**: 多项目管理
- **Communication**: 沟通工具
- **System**: 系统管理

## 配置启用

在您的用户配置中启用：

```nix
myHome.dotfiles = {
  enable = true;
  zellij = {
    enable = true;
    method = "homemanager";  # 或 "direct" / "external"
  };
};
```

## 高级功能

### 会话管理
- 自动会话恢复
- 会话序列化保存
- 多会话并行管理

### 插件支持
- 状态栏插件
- 文件管理器
- 标签栏增强

### 主题定制
- Catppuccin 主题系列
- 自定义颜色方案
- 圆角界面设计

## 与其他工具集成

### Tmux 迁移
- 类似的概念和键绑定
- 更现代的配置语法
- 更好的性能表现

### Fish Shell 集成
- 自动启动逻辑
- 会话管理函数
- 智能会话选择

### Neovim 集成
- 滚动历史编辑器设置
- 无缝终端切换
- 开发环境优化

## 故障排除

### 常见问题
1. **剪贴板不工作**: 确保安装 `wl-clipboard`
2. **主题不显示**: 检查终端颜色支持
3. **键绑定冲突**: 调整配置中的键位映射

### 调试命令
```bash
# 检查配置
zellij setup --check

# 列出会话
zellij list-sessions

# 查看配置路径
zellij setup --dump-config
```
