# Stylix 使用示例

这里提供了几种不同的 Stylix 配置示例，您可以根据需要选择合适的配置方式。

## 示例 1: 快速开始 - 使用预设

```nix
# 在用户配置文件中 (如 users/user1/host1.nix)
{
  myHome = {
    profiles = {
      enable = true;

      # 启用 Stylix 预设主题
      stylix = {
        enable = true;
        presets = {
          enable = true;
          profile = "catppuccin-minimal";  # 现代优雅的暗色主题
        };
      };
    };
  };
}
```

## 示例 2: 开发者配置

```nix
{
  myHome = {
    profiles = {
      enable = true;

      stylix = {
        enable = true;

        # 使用 Tokyo Night 开发者主题
        presets = {
          enable = true;
          profile = "tokyo-night-pro";
        };

        # 自定义终端透明度
        opacity = {
          enable = true;
          terminal = 0.88;
        };

        # 调整字体大小
        fonts = {
          sizes = {
            terminal = 14;      # 适合编程的字体大小
            applications = 12;
          };
        };

        # 精确控制需要主题化的应用
        targets = {
          alacritty.enable = true;
          kitty.enable = true;
          vim.enable = true;
          vscode.enable = true;
          firefox.enable = true;
          git.enable = true;
          lazygit.enable = true;
          btop.enable = true;
          yazi.enable = true;
        };
      };
    };
  };
}
```

## 示例 3: 完全自定义配置

```nix
{
  myHome = {
    profiles = {
      enable = true;

      stylix = {
        enable = true;

        # 自定义色彩方案
        theme = {
          colorScheme = {
            preset = "catppuccin-mocha";
            polarity = "dark";
          };

          wallpaper = {
            enable = true;
            image = ./wallpapers/mountain-sunset.jpg;
            scaling = "fill";
            generateFromImage = false;  # 不从壁纸生成配色
          };
        };

        # 自定义字体配置
        fonts = {
          enable = true;
          families = {
            serif = {
              name = "Noto Serif CJK SC";
              package = pkgs.noto-fonts-cjk-serif;
            };
            sansSerif = {
              name = "Inter";
              package = pkgs.inter;
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
            applications = 11;
            desktop = 9;
            popups = 10;
            terminal = 13;
          };
        };

        # 光标主题
        cursor = {
          enable = true;
          theme = {
            name = "Adwaita";
            package = pkgs.adwaita-icon-theme;
            size = 24;
          };
        };

        # 透明度配置
        opacity = {
          enable = true;
          terminal = 0.9;
          applications = 1.0;
          desktop = 1.0;
          popups = 0.95;
        };

        # 图标主题
        icons = {
          enable = true;
          package = pkgs.papirus-icon-theme;
          light = "Papirus-Light";
          dark = "Papirus-Dark";
        };

        # 高级自定义
        advanced = {
          customColors = {
            enable = true;
            base = {
              accent = "89b4fa";  # 自定义蓝色强调色
            };
            syntax = {
              green = "a6e3a1";   # 自定义绿色
              purple = "cba6f7";  # 自定义紫色
            };
          };
        };
      };
    };
  };
}
```

## 示例 4: 最小化配置

```nix
{
  myHome = {
    profiles = {
      enable = true;

      # 最简配置 - 仅启用基础功能
      stylix = {
        enable = true;

        theme = {
          colorScheme = {
            preset = "nord";
            polarity = "dark";
          };
        };

        # 禁用不需要的功能
        opacity.enable = false;
        icons.enable = false;
        cursor.enable = false;

        # 只为核心应用启用主题
        targets = {
          gtk.enable = true;
          alacritty.enable = true;
          vim.enable = true;
          firefox.enable = true;

          # 显式禁用其他目标
          kitty.enable = false;
          vscode.enable = false;
          spotify.enable = false;
        };
      };
    };
  };
}
```

## 示例 5: 多主题配置（不同主机）

```nix
# 在 users/user1/host1.nix - 工作主机
{
  myHome.profiles.stylix = {
    enable = true;
    presets = {
      enable = true;
      profile = "tokyo-night-pro";  # 专业开发主题
    };
  };
}

# 在 users/user1/host2.nix - 个人主机
{
  myHome.profiles.stylix = {
    enable = true;
    presets = {
      enable = true;
      profile = "catppuccin-minimal";  # 日常使用主题
    };

    opacity = {
      enable = true;
      terminal = 0.85;  # 更透明的效果
    };
  };
}

# 在 users/user1/host3.nix - 娱乐主机
{
  myHome.profiles.stylix = {
    enable = true;
    presets = {
      enable = true;
      profile = "dracula-vampire";  # 炫酷主题
    };

    opacity = {
      enable = true;
      terminal = 0.8;
      applications = 0.95;
    };
  };
}
```

## 示例 6: 浅色主题配置

```nix
{
  myHome = {
    profiles = {
      enable = true;

      stylix = {
        enable = true;

        theme = {
          colorScheme = {
            preset = "github-light";
            polarity = "light";
          };

          wallpaper = {
            enable = true;
            image = ./wallpapers/spring-morning.jpg;
            scaling = "fit";
          };
        };

        # 浅色主题通常不需要透明度
        opacity = {
          enable = false;
        };

        fonts = {
          sizes = {
            applications = 11;
            terminal = 12;
          };
        };

        cursor = {
          enable = true;
          theme = {
            name = "Adwaita";
            package = pkgs.adwaita-icon-theme;
            size = 20;  # 稍小的光标
          };
        };
      };
    };
  };
}
```

## 实际使用建议

### 1. 新用户推荐
- 从预设主题开始：`catppuccin-minimal` 或 `tokyo-night-pro`
- 逐步学习各个配置选项
- 根据需要调整字体大小和透明度

### 2. 开发者推荐
- 使用 `tokyo-night-pro` 预设
- 调整终端字体大小到 13-14pt
- 启用所有开发工具的主题化

### 3. 设计师推荐
- 使用 `solarized-academic` 或自定义配色
- 关注色彩准确性，禁用透明度
- 使用高质量字体

### 4. 性能考虑
- 在低配置机器上禁用透明度
- 选择性启用目标应用
- 使用轻量级预设

选择适合您需求的配置示例，然后根据个人喜好进行调整！
