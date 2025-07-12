# Stylix 配置模块

基于 Stylix 的主题系统，提供完全模块化的配置方式，符合项目的设计风格。

## 模块结构

```
home/profiles/stylix/
├── default.nix      # 主入口，定义基础 Stylix 配置
├── targets.nix      # 目标应用配置，按类别组织
├── fonts.nix        # 字体系统配置
├── colors.nix       # 颜色配置（可选覆盖）
├── wallpapers.nix   # 壁纸管理配置
├── wallpapers/      # Stylix 专用壁纸资源
│   ├── sea.jpg      # 海洋主题壁纸
│   ├── forest.jpg   # 森林主题壁纸
│   ├── mountain.jpg # 山脉主题壁纸
│   ├── city.jpg     # 城市主题壁纸
│   └── abstract.jpg # 抽象主题壁纸
└── README.md        # 本文档
```

## 配置理念

- **功能选择性开启**：每个子功能都可以独立启用/禁用
- **用户级配置**：不同用户有完全独立的 Stylix 配置
- **分类管理**：按功能类别组织目标应用（终端、编辑器、工具、桌面、浏览器）
- **细粒度控制**：每个应用的主题都可以单独控制

## 使用方式

### 基础配置

```nix
myHome.profiles.stylix = {
  enable = true;          # 启用 Stylix
  polarity = "dark";      # 主题极性
  
  # 壁纸配置
  wallpapers = {
    enable = true;
    preset = "sea";       # 使用预设壁纸：sea/forest/mountain/city/abstract
    # 或者使用自定义壁纸
    # custom = ./path/to/my-wallpaper.jpg;
  };
};
```

### 字体配置

```nix
myHome.profiles.stylix.fonts = {
  enable = true;
  
  # 自定义字体包（可选）
  packages = {
    monospace = pkgs.nerd-fonts.fira-code;
    sansSerif = pkgs.inter;
  };
  
  # 自定义字体名称（可选）
  names = {
    monospace = "FiraCode Nerd Font Mono";
    sansSerif = "Inter";
  };
  
  # 自定义字体大小（可选）
  sizes = {
    applications = 12;
    terminal = 13;
    desktop = 11;
    popups = 11;
  };
};
```

### 目标应用配置

```nix
myHome.profiles.stylix.targets = {
  enable = true;
  
  terminals = {
    alacritty.enable = false;  # 避免冲突
    kitty.enable = true;
  };
  
  editors = {
    vim.enable = true;
    neovim.enable = true;
  };
  
  tools = {
    tmux.enable = true;
    bat.enable = true;
    fzf.enable = true;
  };
  
  desktop = {
    gtk.enable = true;
  };
  
  browsers = {
    firefox.enable = true;
  };
};
```

## 用户配置示例

### hengvvang 用户（全功能）

```nix
myHome.profiles.stylix = {
  enable = true;
  polarity = "dark";
  wallpapers = {
    enable = true;
    preset = "sea";       # 使用海洋主题壁纸
  };
  fonts.enable = true;
  targets = {
    enable = true;
    terminals.kitty.enable = true;
    editors = {
      vim.enable = true;
      neovim.enable = true;
    };
    tools = {
      tmux.enable = true;
      bat.enable = true;
      fzf.enable = true;
    };
    desktop.gtk.enable = true;
    browsers.firefox.enable = true;
  };
};
```

### zlritsu 用户（轻量级）

```nix
myHome.profiles.stylix = {
  enable = true;
  polarity = "dark";
  wallpapers = {
    enable = true;
    preset = "forest";    # 使用森林主题壁纸
  };
  fonts = {
    enable = true;
    sizes = {
      applications = 10;  # 较小字体
      terminal = 11;
    };
  };
  targets = {
    enable = true;
    # 只启用基础功能
    editors.vim.enable = true;
    desktop.gtk.enable = true;
    browsers.firefox.enable = true;
    # 其他功能保持禁用状态
  };
};
```

## 优势

1. **严格的模块化**：每个功能组件都可以独立控制
2. **用户差异化**：不同用户可以有完全不同的配置策略
3. **分类清晰**：按应用类型组织，便于管理
4. **可扩展性**：容易添加新的目标应用或配置选项
5. **向后兼容**：可以逐步迁移现有配置

## 扩展指南

### 添加新的目标应用

在 `targets.nix` 中添加新的选项和配置：

```nix
# 在 options 中添加
myHome.profiles.stylix.targets.tools.new-app.enable = lib.mkEnableOption "New App 主题";

# 在 config 中添加
stylix.targets.new-app.enable = config.myHome.profiles.stylix.targets.tools.new-app.enable;
```

### 添加新的配置类别

可以在各个模块中添加新的配置节点，保持层次结构清晰。
