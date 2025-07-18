# Ghostty Home Manager 配置优化说明

## 重构概述

基于 [mynixos.com](https://mynixos.com) 和 [Ghostty 官方文档](https://ghostty.org/docs/config/reference) 的配置选项，对 Ghostty 的 Home Manager 配置进行了全面重构和优化。

## 主要改进

### 1. 配置分类和注释
将配置选项按功能分类，并添加了详细的中文注释：
- 字体配置
- 窗口配置  
- 终端行为配置
- 显示和主题配置
- 光标配置
- 音效和视觉反馈
- 鼠标配置
- 调整大小和布局
- 剪贴板配置
- 链接和标题配置
- Shell 集成功能
- 高级配置

### 2. 新增配置选项

#### 窗口管理
```nix
window-padding-balance = true;         # 自动平衡内边距
window-padding-color = "background";   # 内边距颜色
window-inherit-working-directory = true;  # 新窗口继承工作目录
window-vsync = true;                   # 垂直同步（减少撕裂）
```

#### 终端行为
```nix
abnormal-command-exit-runtime = 2000;  # 异常退出检测时间（毫秒）
wait-after-command = false;            # 命令退出后保持终端开启
grapheme-width-method = "unicode";     # 字符宽度计算方法
```

#### 安全和隐私
```nix
clipboard-read = "ask";                # 读取剪贴板权限：ask/allow/deny
clipboard-paste-protection = true;     # 粘贴保护（防止恶意命令）
title-report = false;                  # 允许程序查询标题（安全风险）
```

#### 性能优化
```nix
image-storage-limit = 320000000;       # 图像存储限制（字节）
background-opacity = 1.0;             # 背景透明度
background-blur = false;               # 背景模糊
```

### 3. Home Manager 集成选项
```nix
enableFishIntegration = true;          # Fish shell 集成
enableBashIntegration = true;          # Bash shell 集成  
enableZshIntegration = true;           # Zsh shell 集成
clearDefaultKeybinds = false;          # 清除默认键绑定
installBatSyntax = false;              # 为 bat 安装语法高亮
installVimSyntax = false;              # 为 Vim 安装语法高亮
```

### 4. 键绑定示例
提供了常用键绑定的注释示例：
- 标签管理（新建、关闭、切换标签）
- 分割窗口（水平、垂直分割）
- 复制粘贴（系统剪贴板集成）
- 字体大小调整（放大、缩小、重置）
- 窗口管理（全屏、新窗口）

### 5. 主题系统优化
- 详细注释了 Catppuccin Macchiato 主题的色彩定义
- 提供了额外主题模板（如 Gruvbox Dark）
- 说明了 16 色调色板的含义

## 配置特点

### 性能优先
- 默认关闭不必要的视觉效果
- 优化内存和 CPU 使用
- 合理的缓冲区大小设置

### 安全考虑
- 默认拒绝不安全的终端查询
- 启用粘贴保护防止恶意命令执行
- 合理的剪贴板权限设置

### 用户体验
- 智能的窗口和目录继承
- 响应式的光标和鼠标行为
- 清晰的视觉反馈

### 可维护性
- 结构化的配置分组
- 详细的中文注释
- 示例配置模板

## 使用建议

1. **根据需要启用功能**：大部分高级功能都已注释，可根据个人需求取消注释
2. **自定义键绑定**：参考提供的键绑定示例，配置适合自己工作流的快捷键
3. **主题定制**：可以基于现有主题模板创建自己的颜色方案
4. **性能调优**：根据硬件性能调整相关参数（如滚动缓冲区大小、图像存储限制等）

## 兼容性说明

- 所有配置选项都基于最新的 Ghostty 版本
- Home Manager 集成功能经过测试验证
- 配置文件兼容 Nix flakes 和传统 Nix 配置

这个重构的配置提供了一个功能完整、性能优化、安全可靠的 Ghostty 终端配置基础，可以根据个人需求进行进一步定制。
