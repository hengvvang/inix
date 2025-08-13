{ config, pkgs, lib, inputs, ... }:
let
  cfg = config.myHome.profiles.stylix;
in
{
  imports = [
    inputs.stylix.homeModules.stylix
  ];

  options.myHome.profiles.stylix = {
    enable = lib.mkEnableOption "Stylix 主题系统配置";

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
        description = "壁纸图片路径";
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
            description = "衬线字体名称";
          };
          package = lib.mkOption {
            type = lib.types.package;
            default = pkgs.noto-fonts-cjk-serif;
            description = "衬线字体包";
          };
        };

        sansSerif = {
          name = lib.mkOption {
            type = lib.types.str;
            default = "Noto Sans CJK SC";
            description = "无衬线字体名称";
          };
          package = lib.mkOption {
            type = lib.types.package;
            default = pkgs.noto-fonts-cjk-sans;
            description = "无衬线字体包";
          };
        };

        monospace = {
          name = lib.mkOption {
            type = lib.types.str;
            default = "JetBrains Mono";
            description = "等宽字体名称";
          };
          package = lib.mkOption {
            type = lib.types.package;
            default = pkgs.jetbrains-mono;
            description = "等宽字体包";
          };
        };

        emoji = {
          name = lib.mkOption {
            type = lib.types.str;
            default = "Noto Color Emoji";
            description = "表情符号字体名称";
          };
          package = lib.mkOption {
            type = lib.types.package;
            default = pkgs.noto-fonts-color-emoji;
            description = "表情符号字体包";
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
      enable = lib.mkEnableOption "光标主题配置" // { default = true; };

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
        default = 0.9;
        description = "终端窗口透明度 (0.0-1.0)";
      };

      applications = lib.mkOption {
        type = lib.types.float;
        default = 1.0;
        description = "应用程序窗口透明度 (0.0-1.0)";
      };

      desktop = lib.mkOption {
        type = lib.types.float;
        default = 1.0;
        description = "桌面组件透明度 (0.0-1.0)";
      };

      popups = lib.mkOption {
        type = lib.types.float;
        default = 0.95;
        description = "弹窗通知透明度 (0.0-1.0)";
      };
    };

    # 图标主题配置
    icons = {
      enable = lib.mkEnableOption "图标主题配置";

      package = lib.mkOption {
        type = lib.types.nullOr lib.types.package;
        default = pkgs.papirus-icon-theme;
        description = "图标主题包";
      };

      light = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = "Papirus-Light";
        description = "亮色图标主题名称";
      };

      dark = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = "Papirus-Dark";
        description = "暗色图标主题名称";
      };
    };

    # 应用目标配置
    targets = {
      # 桌面环境
      gtk = {
        enable = lib.mkEnableOption "GTK 应用主题配置" // { default = cfg.enable; };
        flatpak = lib.mkEnableOption "Flatpak 应用主题支持" // { default = cfg.enable; };
        extraCss = lib.mkOption {
          type = lib.types.lines;
          default = "";
          description = "额外的 GTK CSS 样式";
          example = ''
            window.background {
              border-radius: 8px;
            }
          '';
        };
      };

      qt = {
        enable = lib.mkEnableOption "Qt 应用主题配置" // { default = cfg.enable; };
        platformTheme = lib.mkOption {
          type = lib.types.enum [ "gtk2" "gnome" "kde" ];
          default = "gtk2";
          description = "Qt 平台主题";
        };
      };

      # 终端应用
      alacritty.enable = lib.mkEnableOption "Alacritty 终端主题" // { default = false; };
      kitty.enable = lib.mkEnableOption "Kitty 终端主题" // { default = false; };
      ghostty.enable = lib.mkEnableOption "Ghostty 终端主题" // { default = false; };
      foot.enable = lib.mkEnableOption "Foot 终端主题" // { default = false; };
      wezterm.enable = lib.mkEnableOption "WezTerm 终端主题" // { default = false; };

      # 编辑器
      vim.enable = lib.mkEnableOption "Vim/Neovim 主题" // { default = false; };
      emacs.enable = lib.mkEnableOption "Emacs 主题" // { default = false; };
      vscode.enable = lib.mkEnableOption "VSCode 主题" // { default = false; };
      zed.enable = lib.mkEnableOption "Zed 编辑器主题" // { default = false; };

      # 浏览器
      firefox.enable = lib.mkEnableOption "Firefox 浏览器主题" // { default = false; };
      chromium.enable = lib.mkEnableOption "Chromium 浏览器主题" // { default = false; };
      qutebrowser.enable = lib.mkEnableOption "Qutebrowser 主题" // { default = false; };

      # 媒体应用
      mpv.enable = lib.mkEnableOption "MPV 播放器主题" // { default = false; };
      spotify.enable = lib.mkEnableOption "Spotify 主题" // { default = false; };

      # 开发工具
      git.enable = lib.mkEnableOption "Git 主题配置" // { default = false; };
      lazygit.enable = lib.mkEnableOption "LazyGit 主题" // { default = false; };

      # 系统工具
      btop.enable = lib.mkEnableOption "Btop 系统监控主题" // { default = false; };
      rofi.enable = lib.mkEnableOption "Rofi 启动器主题" // { default = false; };
      dunst.enable = lib.mkEnableOption "Dunst 通知主题" // { default = false; };
      waybar.enable = lib.mkEnableOption "Waybar 状态栏主题" // { default = false; };
      swaynotificationcenter.enable = lib.mkEnableOption "Sway 通知中心主题" // { default = false; };

      # 文件管理器
      yazi.enable = lib.mkEnableOption "Yazi 文件管理器主题" // { default = false; };
      nnn.enable = lib.mkEnableOption "NNN 文件管理器主题" // { default = false; };

      # 终端多路复用器
      tmux.enable = lib.mkEnableOption "Tmux 主题" // { default = false; };
      zellij.enable = lib.mkEnableOption "Zellij 主题" // { default = false; };
    };

    # 高级配置
    advanced = {
      # 自动启用目标
      autoEnable = lib.mkOption {
        type = lib.types.bool;
        default = false;
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

  config = lib.mkIf cfg.enable {
    # 启用 Stylix
    stylix.enable = true;

    # 自动启用配置
    stylix.autoEnable = cfg.advanced.autoEnable;

    # 覆盖层支持
    stylix.overlays.enable = cfg.advanced.overlays;

    # 版本检查
    stylix.enableReleaseChecks = cfg.advanced.releaseChecks;

    # 自定义覆盖
    stylix.override = cfg.advanced.override;

    # 色彩方案配置
    stylix.base16Scheme =
      if cfg.colorScheme.mode == "preset" then
        # 使用预设配色方案
        "${pkgs.base16-schemes}/share/themes/${cfg.colorScheme.preset.name}.yaml"

      else if cfg.colorScheme.mode == "image" then
        # 从图片生成配色方案
        null

      else if cfg.colorScheme.mode == "custom" then
        # 使用自定义配色方案
        if cfg.colorScheme.custom.colors != null then
          cfg.colorScheme.custom.colors
        else if cfg.colorScheme.custom.file != null then
          cfg.colorScheme.custom.file
        else
          "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml"
      else
        # 默认配色
        "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    # 极性配置
    stylix.polarity = cfg.polarity;

    # 壁纸配置
    stylix.image = lib.mkIf (cfg.wallpaper.enable && cfg.wallpaper.image != null) cfg.wallpaper.image;
    stylix.imageScalingMode = cfg.wallpaper.scalingMode;

    # 字体配置
    stylix.fonts = lib.mkIf cfg.fonts.enable {
      serif = {
        name = cfg.fonts.families.serif.name;
        package = cfg.fonts.families.serif.package;
      };
      sansSerif = {
        name = cfg.fonts.families.sansSerif.name;
        package = cfg.fonts.families.sansSerif.package;
      };
      monospace = {
        name = cfg.fonts.families.monospace.name;
        package = cfg.fonts.families.monospace.package;
      };
      emoji = {
        name = cfg.fonts.families.emoji.name;
        package = cfg.fonts.families.emoji.package;
      };
      sizes = {
        applications = cfg.fonts.sizes.applications;
        desktop = cfg.fonts.sizes.desktop;
        popups = cfg.fonts.sizes.popups;
        terminal = cfg.fonts.sizes.terminal;
      };
    };

    # 光标配置
    stylix.cursor = lib.mkIf cfg.cursor.enable {
      name = cfg.cursor.name;
      package = cfg.cursor.package;
      size = cfg.cursor.size;
    };

    # 透明度配置
    stylix.opacity = lib.mkIf cfg.opacity.enable {
      terminal = cfg.opacity.terminal;
      applications = cfg.opacity.applications;
      desktop = cfg.opacity.desktop;
      popups = cfg.opacity.popups;
    };

    # 图标主题配置
    stylix.icons = lib.mkIf cfg.icons.enable {
      enable = true;
      package = cfg.icons.package;
      light = cfg.icons.light;
      dark = cfg.icons.dark;
    };

    # 应用目标配置
    stylix.targets = {
      # 桌面环境
      gtk.enable = cfg.targets.gtk.enable;
      gtk.flatpakSupport.enable = cfg.targets.gtk.flatpak;
      gtk.extraCss = cfg.targets.gtk.extraCss;

      # 终端
      alacritty.enable = cfg.targets.alacritty.enable;
      kitty.enable = cfg.targets.kitty.enable;
      ghostty.enable = cfg.targets.ghostty.enable;
      foot.enable = cfg.targets.foot.enable;
      wezterm.enable = cfg.targets.wezterm.enable;

      # 编辑器
      vim.enable = cfg.targets.vim.enable;
      emacs.enable = cfg.targets.emacs.enable;
      vscode.enable = cfg.targets.vscode.enable;
      zed.enable = cfg.targets.zed.enable;

      # 浏览器
      firefox.enable = cfg.targets.firefox.enable;
      chromium.enable = cfg.targets.chromium.enable;
      qutebrowser.enable = cfg.targets.qutebrowser.enable;

      # 媒体
      mpv.enable = cfg.targets.mpv.enable;

      # 开发工具
      git.enable = cfg.targets.git.enable;
      lazygit.enable = cfg.targets.lazygit.enable;

      # 系统工具
      btop.enable = cfg.targets.btop.enable;
      rofi.enable = cfg.targets.rofi.enable;
      dunst.enable = cfg.targets.dunst.enable;
      waybar.enable = cfg.targets.waybar.enable;
      swaynotificationcenter.enable = cfg.targets.swaynotificationcenter.enable;

      # 文件管理器
      yazi.enable = cfg.targets.yazi.enable;
      nnn.enable = cfg.targets.nnn.enable;

      # 终端多路复用器
      tmux.enable = cfg.targets.tmux.enable;
      zellij.enable = cfg.targets.zellij.enable;
    };
  };
}
