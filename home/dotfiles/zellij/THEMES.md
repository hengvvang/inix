# Zellij 主题配置指南

## 可用主题

你现在有以下主题可供选择：

1. **catppuccin-mocha** - 当前使用的主题，温暖的紫色调
2. **rose-pine** - 优雅的玫瑰色调主题
3. **nord** - 清爽的北欧蓝色主题
4. **tokyo-night** - 现代的深色主题
5. **dracula** - 经典的紫色暗黑主题
6. **gruvbox-dark** - 经典的复古暗色主题
7. **onedark** - VSCode 风格的暗色主题
8. **solarized-dark** - 经典的 Solarized 暗色主题

## 如何切换主题

### 方法1：修改配置文件
编辑 `configs/config.kdl` 文件的第一行：
```kdl
theme "主题名称"
```

例如：
```kdl
theme "rose-pine"
theme "nord"
theme "tokyo-night"
theme "dracula"
```

### 方法2：使用环境变量
你也可以在启动 Zellij 时指定主题：
```bash
ZELLIJ_THEME="rose-pine" zellij
```

## 主题预览

### Catppuccin Mocha (当前)
- 背景：深紫色 `#1e1e2e`
- 前景：浅蓝紫色 `#cdd6f4`
- 特色：温暖、现代

### Rose Pine
- 背景：深紫色 `#191724`  
- 前景：淡紫色 `#e0def4`
- 特色：优雅、柔和

### Nord
- 背景：深蓝色 `#2e3440`
- 前景：浅蓝灰色 `#d8dee9`
- 特色：清爽、专业

### Tokyo Night
- 背景：深蓝色 `#1a1b26`
- 前景：浅蓝色 `#c0caf5`
- 特色：现代、活力

### Dracula
- 背景：深灰色 `#282a36`
- 前景：浅灰色 `#f8f8f2`
- 特色：经典、对比度高

### Gruvbox Dark
- 背景：深棕色 `#282828`
- 前景：浅米色 `#ebdbb2`
- 特色：复古、温暖

### OneDark
- 背景：深灰蓝色 `#282c34`
- 前景：浅灰色 `#abb2bf`
- 特色：VSCode 风格、平衡

### Solarized Dark
- 背景：深蓝绿色 `#002b36`
- 前景：浅蓝灰色 `#839496`
- 特色：经典、护眼

## 重新加载配置

修改主题后，你可以：
1. 重启 Zellij 会话
2. 或者使用快捷键重新加载配置（如果有配置的话）

## 自定义主题

如果你想创建自定义主题，可以在 `themes/` 目录下创建新的 `.kdl` 文件，参考现有主题的格式。
