# Stylix 配置模块

基于 Stylix 的主题系统，完全遵循项目的设计风格：在 `default.nix` 中定义所有 options，通过 imports 导入具体实现模块。

## 设计风格

- **Options 集中定义**：所有配置选项在 `default.nix` 中统一定义
- **实现模块分离**：具体实现逻辑分布在各个专用模块中
- **模块化管理**：每个功能组件独立可控
- **分类清晰**：按功能类型组织配置结构

## 模块结构

```
home/profiles/stylix/
├── default.nix      # 定义所有 options + 核心配置实现
├── wallpapers.nix   # 壁纸配置实现
├── fonts.nix        # 字体配置实现
├── targets.nix      # 目标应用配置实现
├── colors.nix       # 颜色配置实现
├── colors.nix       # 颜色配置实现
├── wallpapers/      # Stylix 专用壁纸资源
│   ├── sea.jpg      # 海洋主题壁纸
│   ├── forest.jpg   # 森林主题壁纸
│   ├── mountain.jpg # 山脉主题壁纸
│   ├── city.jpg     # 城市主题壁纸
│   └── abstract.jpg # 抽象主题壁纸
└── README.md        # 本文档
```

## 配置理念

1. **Options + 核心配置**：`default.nix` 定义完整的配置接口并处理核心逻辑
2. **实现分离**：各个 `.nix` 文件只处理具体的子功能实现
3. **简洁高效**：必要的配置直接在 `default.nix` 中处理，避免过度拆分
4. **易于维护**：核心逻辑集中，子功能模块化

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
