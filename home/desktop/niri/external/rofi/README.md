# Rofi macOS 毛玻璃主题

一套精美的 rofi 配置，完美模仿最新 macOS Sonoma/Ventura 的毛玻璃效果，使用 LXGW WenKai Mono 字体，提供深色和浅色两种主题。

## 🎨 主题特性

### ✨ 视觉效果
- **真实毛玻璃效果**: 极低透明度背景（6-8%），营造真实的毛玻璃质感
- **macOS 设计语言**: 18px 圆角、0.5px 细边框、标准间距
- **优雅字体**: LXGW WenKai Mono 13pt，完美中文支持
- **流畅交互**: 悬停效果、选中状态、平滑过渡
- **图标支持**: Papirus 图标主题，28px 大小

### 🌈 双主题支持
- **深色主题** (`macos-glass-dark.rasi`): 适合深色壁纸和夜间使用
- **浅色主题** (`macos-glass-light.rasi`): 适合浅色壁纸和白天使用

### 🎯 macOS 风格功能
- **Spotlight 式搜索**: 居中显示，智能模糊匹配
- **多模式支持**: 应用启动器、窗口切换、命令运行、SSH 连接
- **macOS 快捷键**: Cmd 键支持，符合 macOS 使用习惯
- **智能布局**: 自适应窗口大小，优化的内边距

## 📋 主题详情

### 深色主题 (`macos-glass-dark.rasi`)

**适用场景**:
- 深色或高对比度壁纸
- 夜间使用
- 喜欢深色界面的用户

**关键特性**:
```ini
/* 核心颜色配置 */
macos-bg:           rgba(29, 29, 31, 0.06);    /* 极低透明度深色背景 */
macos-fg:           rgba(242, 242, 247, 1.0);  /* macOS 标准浅色文本 */
macos-accent:       rgba(0, 122, 255, 1.0);    /* macOS 蓝色 #007AFF */
macos-border:       rgba(255, 255, 255, 0.06); /* 极淡白色边框 */
```

**视觉效果**:
- 背景透明度仅 6%，营造深邃的毛玻璃效果
- 浅色文本确保在深色背景上的可读性
- 极细的白色边框和分隔线
- 蓝色强调色用于选中和交互状态

### 浅色主题 (`macos-glass-light.rasi`)

**适用场景**:
- 浅色或明亮壁纸
- 白天使用
- 明亮环境
- 喜欢浅色界面的用户

**关键特性**:
```ini
/* 核心颜色配置 */
macos-bg:           rgba(245, 245, 247, 0.08);  /* 极低透明度浅色背景 */
macos-fg:           rgba(29, 29, 31, 1.0);      /* 深色文本 */
macos-accent:       rgba(0, 122, 255, 1.0);     /* 同样的蓝色强调 */
macos-border:       rgba(0, 0, 0, 0.08);        /* 极淡黑色边框 */
```

**视觉效果**:
- 背景透明度 8%，温和的浅色毛玻璃效果
- 深色文本确保在浅色背景上的清晰度
- 淡蓝色选中效果
- 适合明亮环境的配色方案

## 🚀 快速开始

### 1. 应用主题

编辑 `default.nix` 文件：

```nix
# 使用深色主题（推荐）
programs.rofi = {
  enable = true;
  configPath = "${./rofi}/macos-glass-dark.rasi";
};

# 或使用浅色主题
# programs.rofi = {
#   enable = true;
#   configPath = "${./rofi}/macos-glass-light.rasi";
# };

# 或使用统一配置文件（支持主题切换）
# programs.rofi = {
#   enable = true;
#   configPath = "${./rofi}/config.rasi";
# };
```

### 2. 安装必需依赖

在 NixOS 配置中添加：

```nix
# 字体
fonts.packages = with pkgs; [
  lxgw-wenkai  # LXGW WenKai Mono 字体
];

# 图标主题
environment.systemPackages = with pkgs; [
  papirus-icon-theme  # Papirus 图标主题
];
```

### 3. 重新构建系统

```bash
sudo nixos-rebuild switch
```

### 4. 设置快捷键

在 niri 配置中添加：

```kdl
binds {
    // macOS 风格的 Spotlight 快捷键
    Mod+Space { spawn "rofi" "-show" "drun"; }
    
    // 窗口切换
    Mod+Tab { spawn "rofi" "-show" "window"; }
    
    // 运行命令
    Mod+R { spawn "rofi" "-show" "run"; }
}
```

## 🛠️ 主题切换

### 使用主题切换脚本

我们提供了一个便捷的主题切换脚本：

```bash
# 切换到深色主题
./theme-switcher.sh dark

# 切换到浅色主题  
./theme-switcher.sh light

# 在两个主题间切换
./theme-switcher.sh toggle

# 根据时间自动选择（06:00-18:00 浅色，其他时间深色）
./theme-switcher.sh auto

# 查看当前主题状态
./theme-switcher.sh status
```

### 手动切换

直接复制主题文件：

```bash
# 切换到深色主题
cp ~/.config/rofi/macos-glass-dark.rasi ~/.config/rofi/config.rasi

# 切换到浅色主题
cp ~/.config/rofi/macos-glass-light.rasi ~/.config/rofi/config.rasi
```

## ⚙️ 配置详解

### 窗口布局

```ini
/* 窗口尺寸和位置 */
width:             38%;              /* 屏幕宽度的 38% */
padding:           24px 36px;        /* 内边距：上下 24px，左右 36px */
border-radius:     18px;             /* macOS 标准圆角 */
location:          center;           /* 居中显示 */

/* 列表设置 */
lines:             8;                /* 显示 8 行结果 */
spacing:           2px;              /* 行间距 */
```

### 字体配置

```ini
font: "LXGW WenKai Mono 13";         /* 主字体：13pt */
font: "LXGW WenKai Mono Bold 13";    /* 粗体：用于高亮 */
font: "LXGW WenKai Mono 11";         /* 小字体：用于按钮 */
```

### 图标设置

```ini
show-icons: true;                    /* 启用图标显示 */
icon-theme: "Papirus-Dark";          /* 深色主题使用 Papirus-Dark */
icon-theme: "Papirus-Light";         /* 浅色主题使用 Papirus-Light */
size: 28px;                          /* 图标大小 */
```

### 键盘快捷键

| 快捷键 | 功能 | macOS 风格 |
|--------|------|-----------|
| `Enter` | 启动选中项 | ✓ |
| `Escape` / `Cmd+W` | 取消 | ✓ |
| `↑/↓` / `Ctrl+P/N` | 上下选择 | ✓ |
| `Cmd+Up/Down` | 快速导航 | ✓ |
| `Home/End` / `Cmd+Home/End` | 首末项 | ✓ |
| `Ctrl+Space` | 选择项目 | ✓ |
| `Tab` | 模式切换 | ✓ |

## 🎨 自定义配置

### 调整透明度

如果觉得毛玻璃效果太淡或太重：

```ini
/* 更明显的毛玻璃效果 */
macos-bg: rgba(29, 29, 31, 0.10);   /* 10% 不透明度 */

/* 更淡的毛玻璃效果 */
macos-bg: rgba(29, 29, 31, 0.04);   /* 4% 不透明度 */
```

### 调整窗口大小

```ini
/* 更小的窗口 */
width: 30%;
padding: 20px 30px;

/* 更大的窗口 */
width: 45%;
padding: 30px 40px;
```

### 调整字体大小

```ini
/* 较小字体 */
font: "LXGW WenKai Mono 12";

/* 较大字体 */
font: "LXGW WenKai Mono 14";
```

### 调整圆角半径

```ini
border-radius: 12px;   /* 较小圆角，更传统 */
border-radius: 24px;   /* 较大圆角，更现代 */
```

### 自定义颜色

```ini
/* 自定义强调色 */
macos-accent: rgba(255, 45, 85, 1.0);   /* 粉色 */
macos-accent: rgba(50, 215, 75, 1.0);   /* 绿色 */
macos-accent: rgba(255, 159, 10, 1.0);  /* 橙色 */
```

## 🔧 故障排除

### 字体显示问题

**问题**: 字体显示为方块或不是预期字体

**解决方案**:
1. 检查字体安装：
   ```bash
   fc-list | grep -i "LXGW\|wenkai"
   ```

2. 确保 NixOS 配置包含字体：
   ```nix
   fonts.packages = with pkgs; [ lxgw-wenkai ];
   ```

3. 重建系统：
   ```bash
   sudo nixos-rebuild switch
   ```

### 透明效果不显示

**问题**: 看起来像普通的不透明窗口

**解决方案**:
1. 确认合成器正在运行（niri 用户通常不会遇到此问题）
2. 检查 rofi 配置中的透明度设置：
   ```ini
   transparency: "real";
   ```
3. 尝试调整背景透明度值

### 图标不显示

**问题**: 只显示文本，没有图标

**解决方案**:
1. 安装 Papirus 图标主题：
   ```nix
   environment.systemPackages = with pkgs; [
     papirus-icon-theme
   ];
   ```

2. 检查图标主题设置：
   ```ini
   show-icons: true;
   icon-theme: "Papirus-Dark";  # 或 "Papirus-Light"
   ```

3. 清除图标缓存：
   ```bash
   gtk-update-icon-cache -t ~/.local/share/icons/
   ```

### 性能问题

**问题**: 启动慢或卡顿

**解决方案**:
1. 减少显示行数：
   ```ini
   lines: 6;  # 从 8 减少到 6
   ```

2. 禁用不需要的模式：
   ```ini
   modi: "drun";  # 只启用应用启动器
   ```

3. 优化搜索设置：
   ```ini
   lazy-grab: true;
   ```

### 快捷键冲突

**问题**: 某些快捷键不工作

**解决方案**:
1. 检查系统快捷键绑定
2. 修改 rofi 配置中的快捷键：
   ```ini
   kb-cancel: "Escape,Control+g";  # 移除冲突的快捷键
   ```

## 🎯 使用技巧

### 1. 模糊搜索

- 输入应用名称的任意部分即可搜索
- 支持中文应用的拼音搜索
- 不需要完整输入应用名称

### 2. 多模式操作

```bash
# 应用启动器（默认）
rofi -show drun

# 窗口切换器
rofi -show window

# 命令运行器
rofi -show run

# SSH 连接器
rofi -show ssh

# 组合模式
rofi -show combi
```

### 3. 命令行选项

```bash
# 指定字体
rofi -show drun -font "LXGW WenKai Mono 14"

# 指定主题
rofi -show drun -theme ~/.config/rofi/macos-glass-light.rasi

# 指定位置
rofi -show drun -location 1  # 屏幕顶部

# 指定大小
rofi -show drun -width 50

# 启用图标
rofi -show drun -show-icons
```

### 4. 脚本集成

创建自定义启动脚本：

```bash
#!/bin/bash
# rofi-launcher.sh

# 检测当前时间并选择合适的主题
hour=$(date +%H)
if [[ $hour -ge 6 && $hour -lt 18 ]]; then
    theme="macos-glass-light.rasi"
else
    theme="macos-glass-dark.rasi"
fi

# 启动 rofi
rofi -show drun -theme ~/.config/rofi/$theme
```

## 📚 高级用法

### 1. 自定义模式

创建自定义的 rofi 模式，例如系统控制：

```bash
# 电源管理菜单
echo -e "🔒 锁屏\n🔄 重启\n⚡ 关机\n💤 休眠" | \
    rofi -dmenu -p "系统控制" -theme ~/.config/rofi/macos-glass-dark.rasi
```

### 2. 动态主题切换

根据壁纸亮度自动选择主题：

```bash
#!/bin/bash
# auto-theme-by-wallpaper.sh

# 获取当前壁纸的平均亮度（需要 ImageMagick）
wallpaper=$(grep "wallpaper" ~/.config/niri/config.kdl | cut -d'"' -f2)
brightness=$(convert "$wallpaper" -colorspace Gray -format "%[fx:mean]" info:)

# 根据亮度选择主题
if (( $(echo "$brightness > 0.5" | bc -l) )); then
    cp ~/.config/rofi/macos-glass-light.rasi ~/.config/rofi/config.rasi
    echo "切换到浅色主题（壁纸较亮：$brightness）"
else
    cp ~/.config/rofi/macos-glass-dark.rasi ~/.config/rofi/config.rasi
    echo "切换到深色主题（壁纸较暗：$brightness）"
fi
```

### 3. 工作区集成

为不同工作区设置不同的主题：

```bash
#!/bin/bash
# workspace-theme.sh

workspace=$(niri msg workspaces | jq '.[] | select(.is_active == true) | .name' -r)

case "$workspace" in
    "work")
        theme="macos-glass-light.rasi"  # 工作时使用浅色主题
        ;;
    "gaming"|"media")
        theme="macos-glass-dark.rasi"   # 娱乐时使用深色主题
        ;;
    *)
        theme="macos-glass-dark.rasi"   # 默认深色主题
        ;;
esac

rofi -show drun -theme ~/.config/rofi/$theme
```

## 🎨 配色方案参考

### macOS 标准配色

| 颜色 | 深色模式 | 浅色模式 | 用途 |
|------|----------|----------|------|
| 蓝色 | `#007AFF` | `#007AFF` | 强调色、链接 |
| 红色 | `#FF453A` | `#FF3B30` | 错误、警告 |
| 绿色 | `#32D74B` | `#34C759` | 成功、确认 |
| 橙色 | `#FF9F0A` | `#FF9500` | 警告、提醒 |
| 粉色 | `#FF2D92` | `#FF2D55` | 特殊强调 |
| 紫色 | `#BF5AF2` | `#AF52DE` | 创意、艺术 |

### 透明度级别

| 用途 | 透明度 | RGBA Alpha |
|------|--------|------------|
| 主背景 | 6-8% | 0.06-0.08 |
| 输入框背景 | 90-95% | 0.90-0.95 |
| 选中背景 | 5-8% | 0.05-0.08 |
| 悬停效果 | 8-12% | 0.08-0.12 |
| 边框 | 6-10% | 0.06-0.10 |
| 分隔线 | 10-15% | 0.10-0.15 |

## 📖 参考资料

- [Rofi 官方文档](https://github.com/davatorium/rofi)
- [macOS 设计指南](https://developer.apple.com/design/human-interface-guidelines/)
- [LXGW WenKai 字体](https://github.com/lxgw/LxgwWenKai)
- [Papirus 图标主题](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)
- [RASI 配置语法](https://github.com/davatorium/rofi/blob/next/doc/rofi-theme.5.markdown)

## 🤝 贡献

如果你有改进建议或发现问题，欢迎：

1. 提交 Issue 报告问题
2. 提交 Pull Request 贡献代码
3. 分享你的自定义配色方案
4. 改进文档和使用指南

## 📄 许可证

本主题配置遵循 MIT 许可证，可自由使用、修改和分发。

---

**享受你的 macOS 风格 rofi 体验！** 🎉