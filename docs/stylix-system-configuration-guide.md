# 系统级 Stylix 配置指南

## 概述

系统级 Stylix 配置主要负责系统范围内的主题应用，包括登录界面、启动画面、系统字体、桌面环境等。与 Home Manager 级别的配置不同，系统级配置更注重全局一致性。

## 基础配置

### 启用系统级 Stylix

```nix
{
  mySystem.profiles.stylix = {
    enable = true;

    # 基础色彩方案
    colorScheme = {
      mode = "preset";
      preset.name = "catppuccin-mocha";
    };

    # 系统壁纸
    wallpaper = {
      enable = true;
      image = ./wallpapers/system-bg.jpg;
      scalingMode = "fill";
    };
  };
}
```

## 配色方案配置

### 预设主题

```nix
mySystem.profiles.stylix.colorScheme = {
  mode = "preset";
  preset.name = "catppuccin-mocha";  # 或其他支持的主题
};
```

支持的预设主题：
- `catppuccin-latte` - Catppuccin 亮色
- `catppuccin-frappe` - Catppuccin 柔和暗色
- `catppuccin-macchiato` - Catppuccin 中等暗色
- `catppuccin-mocha` - Catppuccin 深色
- `tokyo-night-dark` - 东京夜暗色
- `dracula` - Dracula 主题
- `nord` - Nord 主题
- `gruvbox-dark-hard` - Gruvbox 硬质暗色

### 从壁纸生成

```nix
mySystem.profiles.stylix.colorScheme = {
  mode = "image";
  # 将从壁纸自动生成配色
};
```

### 自定义配色

```nix
mySystem.profiles.stylix.colorScheme = {
  mode = "custom";
  custom.colors = {
    base00 = "1e1e2e";  # 背景
    base01 = "181825";  # 更深背景
    base02 = "313244";  # 选中背景
    base03 = "45475a";  # 注释
    base04 = "585b70";  # 暗前景
    base05 = "cdd6f4";  # 前景
    base06 = "f5e0dc";  # 亮前景
    base07 = "b4befe";  # 最亮前景
    base08 = "f38ba8";  # 红色
    base09 = "fab387";  # 橙色
    base0A = "f9e2af";  # 黄色
    base0B = "a6e3a1";  # 绿色
    base0C = "94e2d5";  # 青色
    base0D = "89b4fa";  # 蓝色
    base0E = "cba6f7";  # 紫色
    base0F = "f2cdcd";  # 棕色
  };
};
```

## 字体配置

### 系统字体设置

```nix
mySystem.profiles.stylix.fonts = {
  enable = true;
  families = {
    serif = {
      name = "Noto Serif CJK SC";
      package = pkgs.noto-fonts-cjk-serif;
    };
    sansSerif = {
      name = "Noto Sans CJK SC";
      package = pkgs.noto-fonts-cjk-sans;
    };
    monospace = {
      name = "JetBrains Mono";
      package = pkgs.jetbrains-mono;
    };
    emoji = {
      name = "Noto Color Emoji";
      package = pkgs.noto-fonts-color-emoji;
    };
  };
  sizes = {
    applications = 12;
    desktop = 10;
    popups = 10;
    terminal = 13;
  };
};
```

## 系统级目标配置

### 登录界面主题

#### LightDM 配置
```nix
mySystem.profiles.stylix.targets.lightdm = {
  enable = true;
  useWallpaper = true;
};
```

#### ReGreet 配置
```nix
mySystem.profiles.stylix.targets.regreet = {
  enable = true;
  useWallpaper = true;
};
```

### 启动画面主题

```nix
mySystem.profiles.stylix.targets.plymouth = {
  enable = true;
  logo = ./assets/my-logo.png;
  logoAnimated = true;
};
```

### 桌面环境主题

#### GNOME 主题
```nix
mySystem.profiles.stylix.targets.gnome.enable = true;
```

### 系统级应用主题

#### GTK 应用
```nix
mySystem.profiles.stylix.targets.gtk.enable = true;
```

#### Qt 应用
```nix
mySystem.profiles.stylix.targets.qt = {
  enable = true;
  platform = "qtct";  # 或 "gnome", "kde"
};
```

### 终端主题

#### 系统控制台
```nix
mySystem.profiles.stylix.targets.console.enable = true;
```

#### kmscon 虚拟控制台
```nix
mySystem.profiles.stylix.targets.kmscon.enable = true;
```

### 浏览器主题

```nix
mySystem.profiles.stylix.targets.chromium.enable = true;
```

## 高级配置

### 透明度设置

```nix
mySystem.profiles.stylix.opacity = {
  enable = true;
  terminal = 0.95;
  applications = 1.0;
  desktop = 1.0;
  popups = 0.9;
};
```

### 光标主题

```nix
mySystem.profiles.stylix.cursor = {
  enable = true;
  name = "Adwaita";
  package = pkgs.adwaita-icon-theme;
  size = 24;
};
```

### Home Manager 集成

```nix
mySystem.profiles.stylix.homeManagerIntegration = {
  autoImport = true;   # 自动为所有用户导入
  followSystem = true; # 用户配置跟随系统配置
};
```

### 自动启用和覆盖

```nix
mySystem.profiles.stylix.advanced = {
  autoEnable = true;        # 自动为已安装应用启用主题
  overlays = true;          # 启用包覆盖层支持
  releaseChecks = true;     # 版本兼容性检查
  override = {
    # 自定义颜色覆盖
    base00 = "000000";
  };
};
```

## 完整配置示例

```nix
{
  mySystem.profiles.stylix = {
    enable = true;

    # 色彩配置
    colorScheme = {
      mode = "preset";
      preset.name = "catppuccin-mocha";
    };
    polarity = "dark";

    # 壁纸配置
    wallpaper = {
      enable = true;
      image = ./wallpapers/system-wallpaper.jpg;
      scalingMode = "fill";
    };

    # 字体配置
    fonts = {
      enable = true;
      sizes = {
        applications = 12;
        desktop = 10;
        terminal = 13;
      };
    };

    # 光标配置
    cursor = {
      enable = true;
      size = 24;
    };

    # 系统级目标
    targets = {
      gtk.enable = true;
      qt.enable = true;
      console.enable = true;
      lightdm = {
        enable = true;
        useWallpaper = true;
      };
      plymouth = {
        enable = true;
        logoAnimated = true;
      };
      chromium.enable = true;
      fontPackages.enable = true;
    };

    # Home Manager 集成
    homeManagerIntegration = {
      autoImport = true;
      followSystem = true;
    };
  };
}
```

## 注意事项

1. **系统级与用户级的区别**：
   - 系统级配置影响登录界面、启动画面等系统组件
   - 用户级配置影响用户应用程序

2. **Home Manager 集成**：
   - `autoImport = true` 自动为所有 Home Manager 用户导入 Stylix
   - `followSystem = true` 让用户配置默认跟随系统配置

3. **目标自动启用**：
   - 大部分目标会在检测到相应程序时自动启用
   - 可以通过 `autoEnable = false` 禁用自动启用

4. **配色优先级**：
   - 自定义颜色 > 壁纸生成 > 预设主题

5. **字体包安装**：
   - 系统级配置会自动安装所需字体包
   - 确保系统级字体与用户级字体一致性
