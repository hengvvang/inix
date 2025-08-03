# Fuzzel macOS 毛玻璃效果配置指南

## 概述

本指南将帮助你配置和使用类似最新 macOS 的毛玻璃效果 fuzzel 启动器。我们提供了精心调校的配置，使用 **LXGW WenKai Mono** 字体，完美模仿 macOS Sonoma/Ventura 的视觉设计。

## 快速开始

### 1. 应用 macOS 毛玻璃主题

编辑 `default.nix` 文件：

```nix
# 使用 macOS 毛玻璃深色主题（推荐）
xdg.configFile."fuzzel/fuzzel.ini".source = ./fuzzel-macos-glass.ini;

# 或者使用浅色主题
# xdg.configFile."fuzzel/fuzzel.ini".source = ./fuzzel-macos-glass-light.ini;
```

### 2. 确保字体安装

在你的 NixOS 配置中添加字体：

```nix
fonts.packages = with pkgs; [
  lxgw-wenkai  # LXGW WenKai Mono 字体
];
```

### 3. 重新构建配置

```bash
sudo nixos-rebuild switch
```

## 主题详细说明

### macOS 毛玻璃深色主题 (`fuzzel-macos-glass.ini`)

**适用场景**：
- 深色壁纸
- 夜间使用
- 喜欢深色界面的用户

**关键特性**：
- 极低透明度背景 (`1d1d1f18` - 仅 9.4% 不透明度)
- macOS 标准蓝色强调色 (`#007AFF`)
- 18px 圆角半径，完全模仿 macOS 设计
- 0.5px 极细边框，营造精致感
- 优化的间距：36px 水平，24px 垂直内边距

### macOS 毛玻璃浅色主题 (`fuzzel-macos-glass-light.ini`)

**适用场景**：
- 浅色壁纸
- 白天使用
- 明亮环境
- 喜欢浅色界面的用户

**关键特性**：
- 浅色透明背景 (`f5f5f720` - 12.5% 不透明度)
- 深色文本确保可读性
- 淡蓝色选中效果
- Papirus-Light 图标主题

## 配置参数详解

### 窗口布局参数

```ini
width = 38                # 窗口宽度（屏幕宽度的38%）
horizontal-pad = 36       # 水平内边距（左右各36px空白）
vertical-pad = 24         # 垂直内边距（上下各24px空白）
inner-pad = 20           # 内部填充（文本与边框间距）
lines = 8                # 最大显示8行结果
anchor = center          # 居中显示
```

### 字体设置

```ini
font = LXGW WenKai Mono:size=13
```

**字体选择原因**：
- **中文支持**：完美显示中文字符
- **等宽设计**：确保对齐美观
- **易读性**：13pt 大小在各种屏幕上都清晰可读
- **美观性**：优雅的字形设计

### 毛玻璃效果核心

#### 深色主题颜色值：
```ini
background = 1d1d1f18    # 极低透明度深色背景
border = ffffff10        # 极淡白色边框
selection = ffffff12     # 极淡白色选中背景
```

#### 浅色主题颜色值：
```ini
background = f5f5f720    # 极低透明度浅色背景  
border = 00000015        # 极淡黑色边框
selection = 007aff15     # 极淡蓝色选中背景
```

### 透明度数值解释

| 十六进制 | 十进制 | 百分比 | 效果 |
|---------|--------|--------|------|
| `ff` | 255 | 100% | 完全不透明 |
| `cc` | 204 | 80% | 较重的半透明 |
| `aa` | 170 | 67% | 中等半透明 |
| `88` | 136 | 53% | 明显半透明 |
| `55` | 85 | 33% | 重度半透明 |
| `33` | 51 | 20% | 毛玻璃效果 |
| `20` | 32 | 12.5% | 浅色毛玻璃 |
| `18` | 24 | 9.4% | 深色毛玻璃 |
| `15` | 21 | 8.2% | 极轻毛玻璃 |
| `12` | 18 | 7% | 选中效果 |
| `10` | 16 | 6.3% | 边框效果 |

## 使用技巧

### 1. 启动快捷键

在 niri 配置中设置快捷键：

```kdl
binds {
    // 使用 Super+Space 启动 fuzzel（类似 macOS Spotlight）
    Mod+Space { spawn "fuzzel"; }
    
    // 或者使用传统的 Super+D
    Mod+D { spawn "fuzzel"; }
}
```

### 2. 搜索技巧

- **模糊搜索**：输入应用名称的任意部分
- **拼音搜索**：支持中文应用的拼音搜索
- **即时过滤**：输入时实时显示匹配结果

### 3. 快捷键操作

| 快捷键 | 功能 |
|--------|------|
| `Enter` | 启动选中的应用 |
| `Tab` | 启动应用或移到下一项 |
| `Escape` | 取消并关闭 |
| `↑/↓` | 上下选择 |
| `Ctrl+P/N` | 上下选择（vim 风格） |
| `Home/End` | 跳到第一项/最后一项 |
| `Ctrl+A/E` | 光标到行首/行尾 |
| `Ctrl+K` | 删除到行尾 |
| `Alt+Backspace` | 删除前一个单词 |

## 自定义和调优

### 调整窗口大小

如果觉得窗口太大或太小，调整 `width` 参数：

```ini
width = 30    # 更小的窗口
width = 45    # 更大的窗口
```

### 调整透明度

如果毛玻璃效果太淡或太重，调整背景透明度：

```ini
# 更明显的毛玻璃效果
background = 1d1d1f25

# 更淡的毛玻璃效果  
background = 1d1d1f10
```

### 调整字体大小

根据屏幕分辨率和个人喜好调整：

```ini
font = LXGW WenKai Mono:size=12    # 较小字体
font = LXGW WenKai Mono:size=14    # 较大字体
font = LXGW WenKai Mono:size=15    # 大字体
```

### 调整圆角

```ini
radius = 12    # 较小圆角，更传统
radius = 20    # 较大圆角，更现代
radius = 24    # 大圆角，更圆润
```

## 故障排除

### 字体显示异常

**问题**：字体显示为方块或者不是预期的字体
**解决方案**：

1. 检查字体是否安装：
   ```bash
   fc-list | grep -i "LXGW\|wenkai"
   ```

2. 如果没有安装，在 NixOS 配置中添加：
   ```nix
   fonts.packages = with pkgs; [ lxgw-wenkai ];
   ```

3. 重建系统：
   ```bash
   sudo nixos-rebuild switch
   ```

### 透明效果不显示

**问题**：看起来像普通的不透明窗口
**解决方案**：

1. 确认合成器正在运行（对于 niri 用户这通常不是问题）
2. 检查配置文件中的颜色值格式是否正确
3. 尝试调整透明度值

### 图标不显示

**问题**：只显示文本，没有图标
**解决方案**：

1. 安装图标主题：
   ```nix
   # 在 NixOS 配置中
   environment.systemPackages = with pkgs; [
     papirus-icon-theme
   ];
   ```

2. 检查图标主题设置：
   ```ini
   # 深色主题使用
   icon-theme = Papirus-Dark
   
   # 浅色主题使用  
   icon-theme = Papirus-Light
   ```

### 性能问题

**问题**：启动慢或卡顿
**解决方案**：

1. 减少显示行数：
   ```ini
   lines = 6    # 从 8 减少到 6
   ```

2. 禁用图标（如果不需要）：
   ```ini
   icons = no
   ```

## 高级定制

### 创建自定义主题

1. 复制现有配置文件：
   ```bash
   cp fuzzel-macos-glass.ini fuzzel-custom.ini
   ```

2. 修改颜色值以匹配你的桌面主题

3. 在 `default.nix` 中引用新文件：
   ```nix
   xdg.configFile."fuzzel/fuzzel.ini".source = ./fuzzel-custom.ini;
   ```

### 动态主题切换

创建脚本在深色和浅色主题间切换：

```bash
#!/bin/bash
# toggle-fuzzel-theme.sh

CONFIG_DIR="$HOME/.config/fuzzel"
CURRENT_THEME=$(readlink "$CONFIG_DIR/fuzzel.ini")

if [[ "$CURRENT_THEME" == *"light"* ]]; then
    ln -sf fuzzel-macos-glass.ini "$CONFIG_DIR/fuzzel.ini"
    echo "切换到深色主题"
else
    ln -sf fuzzel-macos-glass-light.ini "$CONFIG_DIR/fuzzel.ini"  
    echo "切换到浅色主题"
fi
```

## 最佳实践

### 壁纸选择

- **深色主题**：选择有对比度的壁纸，避免纯黑色
- **浅色主题**：选择不太亮的壁纸，确保可读性

### 显示器设置

- **亮度**：适中亮度获得最佳毛玻璃效果
- **对比度**：稍高的对比度有助于文本清晰度

### 使用习惯

- **快捷启动**：养成使用 `Super+Space` 快速启动的习惯
- **模糊搜索**：充分利用模糊搜索功能，不需要输入完整名称
- **键盘操作**：熟练使用键盘快捷键提高效率

## 参考

- [Fuzzel 官方文档](https://codeberg.org/dnkl/fuzzel)
- [macOS 设计指南](https://developer.apple.com/design/human-interface-guidelines/)
- [LXGW WenKai 字体](https://github.com/lxgw/LxgwWenKai)
- [Papirus 图标主题](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)