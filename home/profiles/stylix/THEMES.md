# Stylix 主题配置指南

## 🎨 可用主题列表

### 自定义主题系列
- `warm-white` 🤍 - 简约白色暖色调（推荐亮色主题）
- `cool-blue` 🩵 - 冷静蓝色主题  
- `forest-green` 🌿 - 森林绿色主题
- `sunset-orange` 🧡 - 日落橙色主题
- `lavender-purple` 💜 - 薰衣草紫色主题
- `dark-elegant` 🖤 - 优雅深色主题

### Rose Pine 系列 🌹
- `rose-pine` - Rose Pine 标准版（深色）
- `rose-pine-moon` - Rose Pine Moon 月夜版（中度深色）
- `rose-pine-dawn` - Rose Pine Dawn 晨曦版（浅色）

### Catppuccin 系列 😺
- `catppuccin-latte` - Catppuccin 拿铁（浅色，适合白天）
- `catppuccin-frappe` - Catppuccin 法芮（中度深色）
- `catppuccin-macchiato` - Catppuccin 玛奇朵（深色）
- `catppuccin-mocha` - Catppuccin 摩卡（最深色，护眼）

### Tokyo Night 系列 🌃
- `tokyo-night` - Tokyo Night 标准版（深色）
- `tokyo-night-light` - Tokyo Night 浅色版
- `tokyo-night-storm` - Tokyo Night 暴风版（中度深色）

### Ayu 系列 ☀️
- `ayu-light` - Ayu 浅色版
- `ayu-mirage` - Ayu 海市蜃楼（中度深色）
- `ayu-dark` - Ayu 深色版

### Material 系列 🎯
- `material-darker` - Material Darker
- `material-palenight` - Material Palenight

### GitHub 系列 🐙
- `github-light` - GitHub 浅色主题
- `github-dark` - GitHub 深色主题

### 经典主题 🔥
- `gruvbox-light` - Gruvbox 亮色
- `gruvbox-dark-hard` - Gruvbox 深色硬对比
- `gruvbox-dark-medium` - Gruvbox 中度深色
- `gruvbox-dark-soft` - Gruvbox 柔和深色
- `solarized-light` - Solarized 亮色
- `solarized-dark` - Solarized 深色  
- `nord` - Nord 北欧风
- `dracula` - Dracula 吸血鬼
- `one-light` - Atom One 亮色
- `one-dark` - Atom One 深色
- `monokai` - Monokai 经典

### 动态主题 🔄
- `auto` - 从壁纸自动生成主题

## 🛠️ 如何使用

### 启用 Stylix 和自定义颜色
```nix
myHome.profiles.stylix = {
  enable = true;
  polarity = "dark";  # 或 "light"
  
  colors = {
    enable = true;
    scheme = "rose-pine";  # 选择你喜欢的主题
  };
};
```

### 配置字体
```nix
myHome.profiles.stylix = {
  fonts = {
    enable = true;
    names = {
      monospace = "JetBrainsMono Nerd Font Mono";
      sansSerif = "Noto Sans";
    };
    sizes = {
      terminal = 12;
      applications = 11;
    };
  };
};
```

### 启用目标应用
```nix
myHome.profiles.stylix = {
  targets = {
    enable = true;
    terminals = {
      alacritty.enable = true;
    };
    editors = {
      neovim.enable = true;
    };
    tools = {
      tmux.enable = true;
      bat.enable = true;
      fzf.enable = true;
    };
  };
};
```

## 📋 主题推荐

### 护眼组合
- **白天工作**: `rose-pine-dawn` 或 `catppuccin-latte`
- **夜间编程**: `rose-pine` 或 `catppuccin-mocha`
- **长时间使用**: `ayu-mirage` 或 `tokyo-night-storm`

### 高对比度
- **深色**: `one-dark` 或 `material-darker`
- **浅色**: `github-light` 或 `ayu-light`

### 复古风格
- `gruvbox-dark-soft` 或 `solarized-dark`

### 现代简约
- `warm-white` 或 `cool-blue`

## 🔧 自定义颜色覆盖

你可以覆盖任何主题的特定颜色：

```nix
myHome.profiles.stylix = {
  colors = {
    enable = true;
    scheme = "rose-pine";
    override = {
      base00 = "000000";  # 自定义背景色
      base05 = "ffffff";  # 自定义前景色
    };
  };
};
```

## 🌟 与其他工具的集成

Stylix 会自动为以下工具生成主题：
- 终端模拟器 (Alacritty, Kitty)
- 编辑器 (Vim, Neovim)
- 命令行工具 (Tmux, Bat, Fzf)
- 桌面环境 (GTK)
- 浏览器 (Firefox)
- 输入法 (Fcitx5)

## 💡 提示

1. 修改主题后需要重新构建 Home Manager 配置
2. 某些应用可能需要重启才能看到主题变化
3. 使用 `auto` 模式时，确保设置了合适的壁纸
4. 不同的 `polarity` 设置会影响主题的整体明暗度
