{ config, lib, pkgs, ... }:
let
  cfg = config.myHome.profiles.stylix;
in
{
  # Stylix 高级配置和自定义选项
  options.myHome.profiles.stylix.advanced = {
    # 自定义配色覆盖
    customColors = {
      enable = lib.mkEnableOption "启用自定义配色覆盖";

      # 基础色彩覆盖
      base = {
        background = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "主背景色 (base00)";
          example = "1e1e2e";
        };

        foreground = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "主前景色 (base05)";
          example = "cdd6f4";
        };

        accent = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "强调色 (base0D)";
          example = "89b4fa";
        };

        selection = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "选择背景色 (base02)";
          example = "313244";
        };
      };

      # 语法高亮色彩
      syntax = {
        red = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "红色 - 错误/删除 (base08)";
        };

        orange = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "橙色 - 警告/修改 (base09)";
        };

        yellow = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "黄色 - 字符串 (base0A)";
        };

        green = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "绿色 - 成功/添加 (base0B)";
        };

        cyan = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "青色 - 操作符 (base0C)";
        };

        blue = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "蓝色 - 关键字 (base0D)";
        };

        purple = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "紫色 - 函数 (base0E)";
        };

        brown = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "棕色 - 变量 (base0F)";
        };
      };
    };

    # 应用特定配置
    applicationOverrides = {
      enable = lib.mkEnableOption "启用应用特定配置覆盖";

      # 终端特定配置
      terminals = {
        alacritty = {
          opacity = lib.mkOption {
            type = lib.types.nullOr lib.types.float;
            default = null;
            description = "Alacritty 特定透明度";
          };

          fontSize = lib.mkOption {
            type = lib.types.nullOr lib.types.ints.positive;
            default = null;
            description = "Alacritty 特定字体大小";
          };
        };

        kitty = {
          opacity = lib.mkOption {
            type = lib.types.nullOr lib.types.float;
            default = null;
            description = "Kitty 特定透明度";
          };

          fontSize = lib.mkOption {
            type = lib.types.nullOr lib.types.ints.positive;
            default = null;
            description = "Kitty 特定字体大小";
          };
        };
      };

      # 编辑器特定配置
      editors = {
        vim = {
          colorscheme = lib.mkOption {
            type = lib.types.nullOr lib.types.str;
            default = null;
            description = "Vim 特定色彩方案";
          };
        };

        vscode = {
          theme = lib.mkOption {
            type = lib.types.nullOr lib.types.str;
            default = null;
            description = "VSCode 特定主题";
          };
        };
      };

      # 浏览器特定配置
      browsers = {
        firefox = {
          userChrome = lib.mkOption {
            type = lib.types.lines;
            default = "";
            description = "Firefox userChrome.css 自定义样式";
            example = ''
              /* 隐藏标签栏 */
              #TabsToolbar { visibility: collapse; }

              /* 紧凑界面 */
              :root { --tab-min-height: 32px !important; }
            '';
          };
        };
      };
    };

    # 桌面环境特定配置
    desktopEnvironment = {
      enable = lib.mkEnableOption "桌面环境特定配置";

      # GNOME 配置
      gnome = {
        enable = lib.mkEnableOption "GNOME 特定配置";

        gtkTheme = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "GNOME GTK 主题";
        };

        shellTheme = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "GNOME Shell 主题";
        };

        extensions = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
          description = "需要主题化的 GNOME 扩展";
          example = [ "user-theme@gnome-shell-extensions.gcampax.github.com" ];
        };
      };

      # KDE 配置
      kde = {
        enable = lib.mkEnableOption "KDE Plasma 特定配置";

        colorScheme = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "KDE 色彩方案";
        };

        plasmaTheme = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "Plasma 主题";
        };
      };

      # Sway/i3 配置
      wayland = {
        enable = lib.mkEnableOption "Wayland 窗口管理器配置";

        # Waybar 配置
        waybar = {
          customCss = lib.mkOption {
            type = lib.types.lines;
            default = "";
            description = "Waybar 自定义 CSS";
            example = ''
              .modules-left {
                margin-left: 10px;
              }

              #workspaces button {
                border-radius: 8px;
              }
            '';
          };
        };

        # Rofi 配置
        rofi = {
          customTheme = lib.mkOption {
            type = lib.types.lines;
            default = "";
            description = "Rofi 自定义主题配置";
            example = ''
              window {
                border-radius: 12px;
                padding: 20px;
              }
            '';
          };
        };
      };
    };

    # 性能和兼容性选项
    performance = {
      enable = lib.mkEnableOption "性能优化配置";

      # 减少内存使用
      lowMemory = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "启用低内存优化 (禁用某些视觉效果)";
      };

      # 兼容性模式
      compatibility = {
        legacyApps = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "启用对旧版应用的兼容性支持";
        };

        x11Fallback = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "为 X11 应用提供主题回退";
        };
      };
    };

    # 动态主题配置
    dynamic = {
      enable = lib.mkEnableOption "动态主题配置";

      # 时间相关主题切换
      timeBasedSwitching = {
        enable = lib.mkEnableOption "基于时间的主题切换";

        lightTheme = lib.mkOption {
          type = lib.types.str;
          default = "github-light";
          description = "白天使用的浅色主题";
        };

        darkTheme = lib.mkOption {
          type = lib.types.str;
          default = "catppuccin-mocha";
          description = "夜间使用的深色主题";
        };

        switchTime = {
          morning = lib.mkOption {
            type = lib.types.str;
            default = "07:00";
            description = "切换到浅色主题的时间";
          };

          evening = lib.mkOption {
            type = lib.types.str;
            default = "19:00";
            description = "切换到深色主题的时间";
          };
        };
      };

      # 壁纸轮换
      wallpaperRotation = {
        enable = lib.mkEnableOption "壁纸轮换";

        directory = lib.mkOption {
          type = lib.types.nullOr lib.types.path;
          default = null;
          description = "壁纸目录路径";
          example = "./wallpapers";
        };

        interval = lib.mkOption {
          type = lib.types.str;
          default = "30min";
          description = "壁纸切换间隔";
          example = "1h";
        };

        generateScheme = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "为每张壁纸生成配色方案";
        };
      };
    };
  };

  config = lib.mkIf (cfg.enable && cfg.advanced.customColors.enable) {
    # 应用自定义配色覆盖
    stylix.override = lib.mkMerge [
      # 基础色彩覆盖
      (lib.mkIf (cfg.advanced.customColors.base.background != null) {
        base00 = cfg.advanced.customColors.base.background;
      })

      (lib.mkIf (cfg.advanced.customColors.base.foreground != null) {
        base05 = cfg.advanced.customColors.base.foreground;
      })

      (lib.mkIf (cfg.advanced.customColors.base.accent != null) {
        base0D = cfg.advanced.customColors.base.accent;
      })

      (lib.mkIf (cfg.advanced.customColors.base.selection != null) {
        base02 = cfg.advanced.customColors.base.selection;
      })

      # 语法高亮色彩覆盖
      (lib.mkIf (cfg.advanced.customColors.syntax.red != null) {
        base08 = cfg.advanced.customColors.syntax.red;
      })

      (lib.mkIf (cfg.advanced.customColors.syntax.orange != null) {
        base09 = cfg.advanced.customColors.syntax.orange;
      })

      (lib.mkIf (cfg.advanced.customColors.syntax.yellow != null) {
        base0A = cfg.advanced.customColors.syntax.yellow;
      })

      (lib.mkIf (cfg.advanced.customColors.syntax.green != null) {
        base0B = cfg.advanced.customColors.syntax.green;
      })

      (lib.mkIf (cfg.advanced.customColors.syntax.cyan != null) {
        base0C = cfg.advanced.customColors.syntax.cyan;
      })

      (lib.mkIf (cfg.advanced.customColors.syntax.blue != null) {
        base0D = cfg.advanced.customColors.syntax.blue;
      })

      (lib.mkIf (cfg.advanced.customColors.syntax.purple != null) {
        base0E = cfg.advanced.customColors.syntax.purple;
      })

      (lib.mkIf (cfg.advanced.customColors.syntax.brown != null) {
        base0F = cfg.advanced.customColors.syntax.brown;
      })
    ];

    # 应用特定配置覆盖
    programs = lib.mkIf cfg.advanced.applicationOverrides.enable {
      alacritty = lib.mkIf (cfg.advanced.applicationOverrides.terminals.alacritty.opacity != null) {
        settings.window.opacity = cfg.advanced.applicationOverrides.terminals.alacritty.opacity;
      };
    };
  };
}
