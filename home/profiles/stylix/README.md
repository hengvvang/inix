# Stylix 主题系统配置指南

## 概览

这个 Stylix 配置模块为 Home Manager 提供了完整的主题系统支持，包含色彩方案、字体、光标、透明度、图标等所有主题元素的配置。

## 基础使用

### 1. 启用 Stylix

```nix
{
  myHome.profiles.stylix = {
    enable = true;
  };
}
```

### 2. 使用预设主题

```nix
{
  myHome.profiles.stylix = {
    enable = true;

    # 使用预设配置
    presets = {
      enable = true;
      profile = "catppuccin-minimal";  # 或其他预设
    };
  };
}
```

### 3. 自定义配置

```nix
{
  myHome.profiles.stylix = {
    enable = true;

    # 色彩主题
    theme = {
      colorScheme = {
        preset = "tokyo-night-dark";
        polarity = "dark";
      };

      wallpaper = {
        enable = true;
        image = ./wallpapers/mountain.jpg;
        scaling = "fill";
      };
    };

    # 字体配置
    fonts = {
      enable = true;
      families = {
        monospace = {
          name = "JetBrains Mono";
          package = pkgs.jetbrains-mono;
        };
        sansSerif = {
          name = "Inter";
          package = pkgs.inter;
        };
      };
      sizes = {
        terminal = 14;
        applications = 12;
      };
    };

    # 透明度
    opacity = {
      enable = true;
      terminal = 0.9;
    };
  };
}
```

## 预设主题

### 可用预设

1. **catppuccin-minimal** - Catppuccin 简约风格
   - 现代优雅的暗色主题
   - 适合日常使用

2. **tokyo-night-pro** - Tokyo Night 专业风格
   - 开发者友好的暗色主题
   - 适合编程工作

3. **gruvbox-classic** - Gruvbox 经典风格
   - 复古温暖的色调
   - 护眼舒适

4. **nord-arctic** - Nord 北极风格
   - 清冷简约的设计
   - 极简主义

5. **solarized-academic** - Solarized 学术风格
   - 经典护眼配色
   - 支持明暗切换

6. **github-clean** - GitHub 简洁风格
   - 清新明亮的浅色主题
   - 适合白天使用

### 预设使用示例

```nix
{
  myHome.profiles.stylix = {
    enable = true;
    presets = {
      enable = true;
      profile = "tokyo-night-pro";
    };
  };
}
```

## 高级配置

### 自定义配色

```nix
{
  myHome.profiles.stylix = {
    enable = true;

    advanced = {
      customColors = {
        enable = true;

        base = {
          background = "1e1e2e";  # 自定义背景色
          foreground = "cdd6f4";  # 自定义前景色
          accent = "89b4fa";      # 自定义强调色
        };

        syntax = {
          red = "f38ba8";
          green = "a6e3a1";
          blue = "89b4fa";
          purple = "cba6f7";
        };
      };
    };
  };
}
```

### 应用特定配置

```nix
{
  myHome.profiles.stylix = {
    enable = true;

    advanced = {
      applicationOverrides = {
        enable = true;

        terminals = {
          alacritty = {
            opacity = 0.85;
            fontSize = 14;
          };
          kitty = {
            opacity = 0.9;
            fontSize = 13;
          };
        };

        browsers = {
          firefox = {
            userChrome = ''
              /* 隐藏标签栏 */
              #TabsToolbar { visibility: collapse; }
            '';
          };
        };
      };
    };
  };
}
```

## 支持的应用程序

### 终端
- Alacritty
- Kitty
- Ghostty
- Foot
- WezTerm

### 编辑器
- Vim/Neovim
- Emacs
- VSCode
- Zed

### 浏览器
- Firefox
- Chromium
- Qutebrowser

### 系统工具
- Rofi (启动器)
- Waybar (状态栏)
- Dunst (通知)
- Btop (系统监控)

### 开发工具
- Git
- LazyGit

### 文件管理器
- Yazi
- NNN

### 终端多路复用器
- Tmux
- Zellij

## 配置选项详解

### 色彩方案选项

- **preset**: 预设色彩方案名称
- **custom**: 自定义 Base16 YAML 文件路径
- **polarity**: 强制使用亮色或暗色主题

### 壁纸选项

- **image**: 壁纸图片路径
- **scaling**: 缩放模式 (stretch/fill/fit/center/tile)
- **generateFromImage**: 是否从壁纸生成色彩方案

### 字体选项

- **families**: 字体族配置 (serif/sansSerif/monospace/emoji)
- **sizes**: 字体大小配置 (applications/desktop/popups/terminal)

### 光标选项

- **name**: 光标主题名称
- **package**: 光标主题包
- **size**: 光标大小

### 透明度选项

- **terminal**: 终端窗口透明度
- **applications**: 应用程序窗口透明度
- **desktop**: 桌面组件透明度
- **popups**: 弹窗通知透明度

## 目标控制

可以为每个支持的应用程序单独启用或禁用主题：

```nix
{
  myHome.profiles.stylix = {
    enable = true;

    targets = {
      # 启用特定应用的主题
      alacritty.enable = true;
      firefox.enable = true;
      vim.enable = true;

      # 禁用特定应用的主题
      vscode.enable = false;

      # GTK 应用特殊配置
      gtk = {
        enable = true;
        flatpak = true;  # 支持 Flatpak 应用
        extraCss = ''
          window.background {
            border-radius: 12px;
          }
        '';
      };
    };
  };
}
```

## 故障排除

### 常见问题

1. **主题未生效**
   - 确保 `enable = true`
   - 检查应用程序是否在 `targets` 中启用
   - 重启相关应用程序

2. **字体显示问题**
   - 确保字体包正确安装
   - 检查字体名称是否正确
   - 清除字体缓存：`fc-cache -f`

3. **壁纸未显示**
   - 检查壁纸路径是否正确
   - 确保桌面环境支持壁纸设置
   - 尝试不同的缩放模式

4. **颜色不准确**
   - 检查终端是否支持真彩色
   - 确认色彩方案文件有效
   - 尝试重置配置

### 调试技巧

1. **查看生成的配色**
   - 配色预览文件位于 `~/.config/stylix/palette.html`

2. **检查目标状态**
   ```bash
   home-manager generations | head -1 | cut -d' ' -f7 | xargs -I{} sh -c 'ls -la {}/home-files/.config'
   ```

3. **重建配置**
   ```bash
   home-manager switch --flake .
   ```

## 示例完整配置

```nix
{
  myHome.profiles.stylix = {
    enable = true;

    # 使用预设 + 自定义调整
    presets = {
      enable = true;
      profile = "catppuccin-minimal";
    };

    # 覆盖预设的某些设置
    fonts = {
      sizes = {
        terminal = 14;  # 更大的终端字体
      };
    };

    opacity = {
      terminal = 0.85;  # 更透明的终端
    };

    # 自定义配色
    advanced = {
      customColors = {
        enable = true;
        base = {
          accent = "89b4fa";  # 蓝色强调色
        };
      };
    };

    # 精确控制目标
    targets = {
      alacritty.enable = true;
      firefox.enable = true;
      vim.enable = true;
      git.enable = true;
      rofi.enable = true;
      waybar.enable = true;
    };
  };
}
```

这个配置系统提供了从简单到复杂的所有层次的主题自定义能力，既可以快速使用预设，也可以进行细致的个性化调整。
