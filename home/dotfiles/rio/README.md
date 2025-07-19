# Rio Terminal Home Manager 配置说明

## 配置概述

Rio 是一个现代化的 GPU 加速终端模拟器，本配置文件提供了完整的 Home Manager 原生配置选项。

## 主要配置特性

### 字体配置
- **主字体**: FiraCode Nerd Font (支持编程连字和图标)
- **字体大小**: 14px (可根据显示器调整)
- **字体特性**: 启用了 Stylistic Sets (ss02, ss03, ss05)
- **符号映射**: 为 Powerline 和 Nerd Font 图标配置了特殊字符映射

### 窗口设置
- **初始尺寸**: 1000x700 像素
- **窗口模式**: 窗口化 (可选择最大化或全屏)
- **装饰**: 启用原生窗口装饰
- **透明度**: 默认不透明 (可调整为半透明)

### 导航/标签
- **导航模式**: Bookmark (书签式导航)
- **分屏支持**: 启用分屏功能
- **智能隐藏**: 单标签时自动隐藏导航栏
- **颜色自动化**: 
  - Vim/Neovim: 红色标签
  - Git 工具: 绿色标签

### 渲染性能
- **性能模式**: 高性能
- **渲染后端**: 自动选择最佳后端
- **优化策略**: 失焦和遮挡时停止渲染
- **渲染策略**: 事件驱动 (节能)

### Shell 集成
- **默认 Shell**: Fish shell
- **启动参数**: --login (加载完整环境)
- **环境变量**: 自动设置 TERM 和 COLORTERM

### 键盘和输入
- **IME 支持**: 启用 IME 光标定位 (改善中文输入)
- **控制序列**: 保持 ALT 键控制序列
- **光标设置**: 块状光标，关闭闪烁

## 可选配置

### 主题支持
取消注释 `theme = "dracula"` 行并在 `~/.config/rio/themes/` 目录下放置主题文件。

### 背景效果
可以启用:
- 窗口透明度 (`opacity < 1.0`)
- 背景模糊 (`blur = true`)
- 背景图片 (配置 `window.background-image`)

### 着色器效果
在非 GL 后端下可以启用 CRT 等复古效果:
```nix
renderer.filters = ["NewPixieCrt"];
```

### 平台特定配置
已包含 Linux 特定配置，可以添加 Windows 或 macOS 的专用设置。

## 使用建议

1. **性能优化**: 当前配置已优化性能，保持失焦渲染禁用
2. **字体选择**: 确保系统已安装 FiraCode Nerd Font
3. **颜色主题**: 建议使用外部主题文件而非内联颜色定义
4. **开发环境**: 配置的编辑器快捷键使用 Neovim

## 故障排除

- 如果字体显示异常，检查 `fonts.disable-warnings-not-found` 设置
- 如果性能问题，可以降低 `renderer.performance` 为 "Low"
- 如果输入法问题，确保 `keyboard.ime-cursor-positioning` 启用

## 相关文件

- `homemanager.nix`: 本配置文件 (Home Manager 原生)
- `direct.nix`: 简化的直接文件管理方式
- `external.nix`: 外部配置文件方式
- `configs/config.toml`: 外部 TOML 配置文件

### 🚀 三种配置方式

- **homemanager**: 使用 Home Manager 直接配置（推荐）
- **direct**: 直接文件管理，简化配置
- **external**: 外部配置文件，完全自定义

### ⚡ 核心特性

- **GPU 加速**: WebGPU 渲染引擎，流畅的视觉体验
- **现代主题**: Catppuccin Mocha 默认主题
- **字体连字**: FiraCode Nerd Font 支持编程连字符
- **高性能**: 优化的渲染和内存管理
- **多平台**: 跨平台支持

## 快速使用

### 基础键绑定

```
# 复制粘贴
Ctrl+Shift+C    # 复制
Ctrl+Shift+V    # 粘贴
Ctrl+Shift+A    # 全选

# 字体大小
Ctrl++          # 增大字体
Ctrl+-          # 减小字体
Ctrl+0          # 重置字体大小

# 窗口管理
F11             # 切换全屏
Alt+Return      # 切换全屏（备用）

# 标签页管理
Ctrl+Shift+T    # 新建标签页
Ctrl+Shift+W    # 关闭标签页
Ctrl+Tab        # 下一个标签页
Ctrl+Shift+Tab  # 上一个标签页

# 数字键快速切换标签页
Ctrl+1-9        # 切换到指定标签页

# 滚动控制
Shift+PageUp    # 向上翻页
Shift+PageDown  # 向下翻页
Shift+Home      # 滚动到顶部
Shift+End       # 滚动到底部

# 搜索功能
Ctrl+Shift+F    # 向前搜索
Ctrl+Shift+B    # 向后搜索

# Vi 风格滚动
Ctrl+Shift+K    # 向上滚动一行
Ctrl+Shift+J    # 向下滚动一行
Ctrl+Shift+U    # 向上翻半页
Ctrl+Shift+D    # 向下翻半页
```

### Shell 函数（External 模式）

```fish
# Fish Shell 中的便捷函数
rio-config      # 编辑配置文件
rio-reload      # 重载配置（需手动重启）
rio-theme       # 列出可用主题
rio-theme mocha # 切换到指定主题
rio-performance # 显示性能信息
```

## 主题支持

### 内置主题

1. **Catppuccin Mocha** (默认)
   - 深色现代主题
   - 护眼色彩搭配
   
2. **Catppuccin Latte**
   - 亮色主题
   - 适合白天使用
   
3. **Nord**
   - 北欧风格主题
   - 冷色调设计

### 主题切换

```bash
# 使用 external 配置模式时
rio-theme catppuccin-mocha
rio-theme catppuccin-latte
rio-theme nord
```

## 配置启用

在您的用户配置中启用：

```nix
myHome.dotfiles = {
  enable = true;
  rio = {
    enable = true;
    method = "homemanager";  # 或 "direct" / "external"
  };
};
```

## 高级特性

### GPU 加速渲染

- **WebGPU 后端**: 自动选择最佳渲染方式
- **硬件加速**: 利用 GPU 进行文本渲染
- **性能优化**: 失去焦点时停止渲染

### 字体特性

- **连字符支持**: 编程字体连字符显示
- **多字体族**: 支持常规、粗体、斜体变体
- **高 DPI 支持**: 适配高分辨率显示器

### 透明度和模糊

- **窗口透明度**: 可调节透明度效果
- **背景模糊**: 现代化视觉效果
- **自适应渲染**: 根据性能自动调整

## 性能优化

### 渲染优化

```toml
[renderer]
backend = "automatic"
disable-renderer-when-unfocused = true

[performance]
disable-renderer-when-unfocused = true
use-fork = false
```

### 内存管理

```toml
[scroll]
history = 10000  # 滚动历史行数
auto-scroll = true

[behavior]
hide-cursor-when-typing = true
```

## 与其他工具集成

### Shell 集成

- **Fish Shell**: 优化的提示符和别名
- **Bash**: 兼容的函数和环境变量
- **环境检测**: 自动检测 Rio 环境

### 桌面集成

- **XDG 桌面条目**: 系统应用菜单集成
- **MIME 类型**: 默认终端模拟器支持
- **图标支持**: 系统图标主题适配

### 剪贴板支持

- **Wayland**: wl-clipboard 集成
- **X11**: xclip 支持
- **跨平台**: 自适应剪贴板解决方案

## 故障排除

### 常见问题

1. **GPU 渲染问题**
   ```bash
   # 检查 GPU 支持
   rio --help
   # 查看渲染后端信息
   ```

2. **字体显示问题**
   - 确保安装 Nerd Fonts
   - 检查字体路径配置
   - 验证连字符支持

3. **性能问题**
   - 调整滚动历史大小
   - 禁用不必要的视觉效果
   - 检查 GPU 驱动支持

### 调试选项

```toml
[developer]
log-level = "DEBUG"  # 启用调试日志
enable-fps-counter = true  # 显示 FPS 计数器
```

### 配置验证

```bash
# 检查配置文件语法
rio --validate-config

# 查看当前配置
rio --dump-config

# 重置配置
rio --reset-config
```

## 系统要求

### 最低要求

- **操作系统**: Linux, macOS, Windows
- **GPU**: 支持 WebGPU 的显卡
- **内存**: 至少 512MB 可用内存

### 推荐配置

- **GPU**: 现代独立显卡或集成显卡
- **驱动**: 最新的图形驱动程序
- **字体**: Nerd Fonts 字体族

## 开发者信息

Rio Terminal 使用 Rust 开发，基于 WebGPU 渲染引擎，提供跨平台的高性能终端体验。

项目特点：
- 现代化架构设计
- GPU 硬件加速
- 低延迟渲染
- 丰富的定制选项
