# Stylix 主题配置

本模块提供了模块化的 Stylix 主题配置支持，完全符合您的配置风格——功能可选择性开启，同一用户统一主题，不同用户可配置不同主题。

## 配置结构

```
home/profiles/theme/
├── default.nix      # 主配置入口，定义基础选项
├── stylix.nix       # 目标应用程序配置
├── fonts.nix        # 字体配置
├── colors.nix       # 颜色配置（可选）
├── wallpapers/      # 壁纸目录
│   └── sea.jpg      # 默认壁纸
└── README.md        # 本文档
```

## 使用方式

### 基础启用

在用户配置中启用主题：

```nix
myHome.profiles.theme = {
  enable = true;
  wallpaper = "sea";     # 壁纸选择
  polarity = "dark";     # 主题极性：light/dark
  fonts.enable = true;   # 启用字体主题
  targets = {
    # 选择性启用各个应用的主题
    gtk.enable = true;
    tmux.enable = true;
    vim.enable = true;
    neovim.enable = true;
    firefox.enable = true;
    bat.enable = true;
    fzf.enable = true;
    alacritty.enable = false;  # 可以禁用特定应用
  };
};
```

### 配置选项

#### 主题选项
- `enable`: 启用主题配置
- `wallpaper`: 壁纸选择（默认: "sea"）
- `polarity`: 主题极性 "light" 或 "dark"（默认: "dark"）

#### 字体选项
- `fonts.enable`: 启用字体主题配置
- `fonts.monospace`: 等宽字体选择（默认: "jetbrains-mono"）
- `fonts.sansSerif`: 无衬线字体选择（默认: "noto-sans"）

#### 目标应用选项
- `targets.gtk.enable`: GTK 应用主题
- `targets.tmux.enable`: Tmux 主题
- `targets.vim.enable`: Vim 主题
- `targets.neovim.enable`: Neovim 主题
- `targets.firefox.enable`: Firefox 主题
- `targets.bat.enable`: Bat 代码高亮主题
- `targets.fzf.enable`: Fzf 主题
- `targets.kitty.enable`: Kitty 终端主题
- `targets.alacritty.enable`: Alacritty 终端主题

## 用户配置示例

### hengvvang 用户（全功能配置）

```nix
myHome.profiles.theme = {
  enable = true;
  wallpaper = "sea";
  polarity = "dark";
  fonts.enable = true;
  targets = {
    gtk.enable = true;
    tmux.enable = true;
    vim.enable = true;
    neovim.enable = true;
    firefox.enable = true;
    bat.enable = true;
    fzf.enable = true;
  };
};
```

### zlritsu 用户（轻量级配置）

```nix
myHome.profiles.theme = {
  enable = true;
  wallpaper = "sea";
  polarity = "dark";
  fonts.enable = true;
  targets = {
    gtk.enable = true;
    tmux.enable = false;      # 不使用 tmux
    vim.enable = true;
    neovim.enable = false;    # 只用基础 vim
    firefox.enable = true;
    bat.enable = false;       # 轻量级配置
    fzf.enable = false;       # 轻量级配置
  };
};
```

## 特性

1. **模块化设计**: 每个功能都可以独立开启/关闭
2. **用户级配置**: 每个用户可以有自己的主题配置
3. **选择性目标**: 可以为不同应用选择性应用主题
4. **壁纸自动配色**: 基于壁纸自动生成配色方案
5. **字体配置**: 统一的字体主题配置
6. **透明度支持**: 支持终端、弹窗等透明度配置

## 添加新壁纸

在 `wallpapers/` 目录下添加新的 JPG 文件，然后在用户配置中指定：

```nix
myHome.profiles.theme.wallpaper = "new-wallpaper";  # 对应 wallpapers/new-wallpaper.jpg
```

## 扩展目标应用

要添加对新应用的主题支持，在 `stylix.nix` 中添加相应的选项和配置。
