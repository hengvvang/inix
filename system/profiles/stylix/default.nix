{ config, pkgs, lib, inputs, ... }:
let
  cfg = config.mySystem.profiles.stylix;
in
{
  imports = [
    inputs.stylix.nixosModules.stylix
    ./stylix.nix
  ];

  options.mySystem.profiles.stylix = {
    enable = lib.mkEnableOption "Stylix 系统级主题配置";

    # 色彩方案配置
    colorScheme = {
      # 配色方案类型
      mode = lib.mkOption {
        type = lib.types.enum [ "preset" "image" "custom" ];
        default = "preset";
        description = "配色方案模式:preset=预设主题,image=从壁纸生成,custom=自定义配色";
      };

      # 预设配色方案
      preset = {
        name = lib.mkOption {
          type = lib.types.enum [
            "catppuccin-latte" "catppuccin-frappe" "catppuccin-macchiato" "catppuccin-mocha"
            "tokyo-night-dark" "tokyo-night-light" "tokyo-night-storm"
            "dracula" "nord" "gruvbox-dark-hard" "gruvbox-light-hard"
          ];
          default = "catppuccin-mocha";
          description = "预设色彩方案名称";
        };
      };

      # 从图片生成配色（简化版）
      image = {
        source = lib.mkOption {
          type = lib.types.nullOr lib.types.path;
          default = null;
          description = "生成配色的图片路径,null则使用壁纸";
        };
      };

      # 自定义配色方案
      custom = {
        file = lib.mkOption {
          type = lib.types.nullOr lib.types.path;
          default = null;
          description = "自定义配色文件路径 (Base16 YAML)";
        };

        colors = lib.mkOption {
          type = lib.types.nullOr (lib.types.attrsOf lib.types.str);
          default = null;
          description = "直接定义 Base16 颜色值";
          example = {
            base00 = "1e1e1e"; # 背景
            base05 = "c5c8c6"; # 前景
            base08 = "cc6666"; # 红色
            base0D = "81a2be"; # 蓝色
          };
        };
      };
    };

    polarity = lib.mkOption {
      type = lib.types.enum [ "either" "light" "dark" ];
      default = "either";
      description = "强制使用亮色或暗色主题";
    };

    # 壁纸配置
    wallpaper = {
      enable = lib.mkEnableOption "壁纸主题配置" // { default = true; };

      image = lib.mkOption {
        type = lib.types.nullOr lib.types.path;
        default = null;
        description = "系统壁纸图片路径";
        example = "./wallpapers/landscape.jpg";
      };

      scalingMode = lib.mkOption {
        type = lib.types.enum [ "stretch" "fill" "fit" "center" "tile" ];
        default = "fill";
        description = "壁纸缩放模式";
      };
    };

    # 字体配置
    fonts = {
      enable = lib.mkEnableOption "字体主题配置" // { default = true; };

      # 字体族配置
      families = {
        serif = {
          name = lib.mkOption {
            type = lib.types.str;
            default = "Noto Serif CJK SC";
            description = "系统衬线字体名称";
          };
          package = lib.mkOption {
            type = lib.types.package;
            default = pkgs.noto-fonts-cjk-serif;
            description = "系统衬线字体包";
          };
        };

        sansSerif = {
          name = lib.mkOption {
            type = lib.types.str;
            default = "Noto Sans CJK SC";
            description = "系统无衬线字体名称";
          };
          package = lib.mkOption {
            type = lib.types.package;
            default = pkgs.noto-fonts-cjk-sans;
            description = "系统无衬线字体包";
          };
        };

        monospace = {
          name = lib.mkOption {
            type = lib.types.str;
            default = "JetBrains Mono";
            description = "系统等宽字体名称";
          };
          package = lib.mkOption {
            type = lib.types.package;
            default = pkgs.jetbrains-mono;
            description = "系统等宽字体包";
          };
        };

        emoji = {
          name = lib.mkOption {
            type = lib.types.str;
            default = "Noto Color Emoji";
            description = "系统表情符号字体名称";
          };
          package = lib.mkOption {
            type = lib.types.package;
            default = pkgs.noto-fonts-color-emoji;
            description = "系统表情符号字体包";
          };
        };
      };

      # 字体大小配置
      sizes = {
        applications = lib.mkOption {
          type = lib.types.ints.positive;
          default = 12;
          description = "应用程序字体大小 (点)";
        };

        desktop = lib.mkOption {
          type = lib.types.ints.positive;
          default = 10;
          description = "桌面元素字体大小 (点)";
        };

        popups = lib.mkOption {
          type = lib.types.ints.positive;
          default = 10;
          description = "弹窗通知字体大小 (点)";
        };

        terminal = lib.mkOption {
          type = lib.types.ints.positive;
          default = 13;
          description = "终端字体大小 (点)";
        };
      };
    };

    # 光标主题配置
    cursor = {
      enable = lib.mkEnableOption "系统光标主题配置";

      name = lib.mkOption {
        type = lib.types.str;
        default = "Adwaita";
        description = "光标主题名称";
      };

      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.adwaita-icon-theme;
        description = "光标主题包";
      };

      size = lib.mkOption {
        type = lib.types.ints.positive;
        default = 24;
        description = "光标大小 (像素)";
      };
    };

    # 透明度配置
    opacity = {
      enable = lib.mkEnableOption "透明度配置";

      terminal = lib.mkOption {
        type = lib.types.float;
        default = 1.0;
        description = "系统终端窗口透明度 (0.0-1.0)";
      };

      applications = lib.mkOption {
        type = lib.types.float;
        default = 1.0;
        description = "系统应用程序窗口透明度 (0.0-1.0)";
      };

      desktop = lib.mkOption {
        type = lib.types.float;
        default = 1.0;
        description = "桌面组件透明度 (0.0-1.0)";
      };

      popups = lib.mkOption {
        type = lib.types.float;
        default = 1.0;
        description = "弹窗通知透明度 (0.0-1.0)";
      };
    };

    # 系统级目标配置
    targets = {
      # 系统级应用
      gtk = {
        enable = lib.mkEnableOption "系统 GTK 应用主题配置" // { default = cfg.enable; };
      };

      qt = {
        enable = lib.mkEnableOption "系统 Qt 应用主题配置" // { default = cfg.enable; };
        platform = lib.mkOption {
          type = lib.types.enum [ "gtk2" "gnome" "kde" "qtct" ];
          default = "qtct";
          description = "Qt 平台主题";
        };
      };

      # 系统级桌面环境
      gnome.enable = lib.mkEnableOption "GNOME 桌面环境主题" // { default = false; };

      # 系统级显示管理器
      lightdm = {
        enable = lib.mkEnableOption "LightDM 登录管理器主题" // { default = false; };
        useWallpaper = lib.mkEnableOption "LightDM 使用壁纸" // { default = true; };
      };

      regreet = {
        enable = lib.mkEnableOption "ReGreet 登录界面主题" // { default = false; };
        useWallpaper = lib.mkEnableOption "ReGreet 使用壁纸" // { default = true; };
      };

      # 系统级启动主题
      plymouth = {
        enable = lib.mkEnableOption "Plymouth 启动画面主题" // { default = false; };
        logo = lib.mkOption {
          type = lib.types.nullOr lib.types.path;
          default = null;
          description = "Plymouth 启动画面 Logo 路径";
        };
        logoAnimated = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "是否启用 Logo 旋转动画";
        };
      };

      # 系统级终端
      console.enable = lib.mkEnableOption "Linux 内核控制台主题" // { default = cfg.enable; };
      kmscon.enable = lib.mkEnableOption "kmscon 虚拟控制台主题" // { default = false; };

      # 系统级浏览器
      chromium.enable = lib.mkEnableOption "Chromium 系列浏览器主题" // { default = false; };

      # 系统级字体包
      fontPackages.enable = lib.mkEnableOption "系统字体包安装" // { default = cfg.fonts.enable; };

      # 系统级桌背景
      feh.enable = lib.mkEnableOption "Feh 桌面背景设置" // { default = false; };

      # 系统级程序
      fish.enable = lib.mkEnableOption "系统级 Fish Shell 主题" // { default = false; };
      glance.enable = lib.mkEnableOption "Glance 仪表板主题" // { default = false; };
    };

    # Home Manager 集成配置
    homeManagerIntegration = {
      autoImport = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "自动为每个 Home Manager 用户导入 Stylix";
      };

      followSystem = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Home Manager 配置默认跟随系统配置";
      };
    };

    # 高级配置
    advanced = {
      # 自动启用目标
      autoEnable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "自动为已安装的应用启用主题";
      };

      # 覆盖层支持
      overlays = lib.mkEnableOption "包覆盖层主题支持" // { default = true; };

      # 发布版本检查
      releaseChecks = lib.mkEnableOption "Stylix 版本兼容性检查" // { default = true; };

      # 自定义覆盖
      override = lib.mkOption {
        type = lib.types.attrs;
        default = { };
        description = "自定义主题属性覆盖";
        example = {
          base00 = "000000";  # 背景色
          base05 = "ffffff";  # 前景色
        };
      };
    };
  };
}
