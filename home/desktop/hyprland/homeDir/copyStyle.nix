{ config, lib, pkgs, inputs, ... }:

{
  config = lib.mkMerge [
    # Hyprland 生态系统包配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.packages.enable && config.myHome.desktop.hyprland.packages.configStyle == "copyFiles") {
      home.packages = with pkgs; [
        # Hyprland 生态系统工具
        grimblast           # 截图工具 (Hyprland 优化版)
        grim                # Wayland 截图工具
        slurp               # 区域选择工具
        wf-recorder          # 录屏工具
        wl-clipboard        # Wayland 剪贴板
        cliphist            # 剪贴板历史
        brightnessctl       # 亮度控制
        pamixer             # 音量控制
        playerctl           # 媒体播放控制
        libnotify           # 发送桌面通知的库
        nautilus            # 文件管理器
      ];
    })

    # Hyprland 环境变量配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.environment.enable && config.myHome.desktop.hyprland.environment.configStyle == "copyFiles") {
      home.sessionVariables = {
        # Hyprland 相关环境变量
        XDG_CURRENT_DESKTOP = "Hyprland";
        XDG_SESSION_DESKTOP = "Hyprland";
        XDG_SESSION_TYPE = "wayland";
        # Wayland 相关环境变量
        WAYLAND_DISPLAY = "wayland-1";
        QT_QPA_PLATFORM = "wayland;xcb";
        GDK_BACKEND = "wayland,x11";
        SDL_VIDEODRIVER = "wayland";
        CLUTTER_BACKEND = "wayland";
        # 输入法支持
        QT_IM_MODULE = "fcitx";
        GTK_IM_MODULE = "fcitx";
        XMODIFIERS = "@im=fcitx";
        WLR_NO_HARDWARE_CURSORS = "1";
        NIXOS_OZONE_WL = "1";
      };
    })

    # Hyprland 核心配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.hypr.enable && config.myHome.desktop.hyprland.hypr.configStyle == "copyFiles") {
      home.packages = with pkgs; [
        hyprland
        xdg-desktop-portal-hyprland
        hyprpaper
        hypridle
        hyprlock
        hyprcursor
      ];

      xdg.configFile = {
        "hypr/hyprland.conf".source = ./.config/hypr/hyprland.conf;
        "hypr/hypridle.conf".source = ./.config/hypr/hypridle.conf;
        "hypr/hyprlock.conf".source = ./.config/hypr/hyprlock.conf;
        "hypr/hyprpaper.conf".source = ./.config/hypr/hyprpaper.conf;

        # 主题配置
        "hypr/themes/catppuccin.conf".source = ./.config/hypr/themes/catppuccin.conf;
        "hypr/themes/macos-tahoe-glass.conf".source = ./.config/hypr/themes/macos-tahoe-glass.conf;

        # 脚本配置
        "hypr/scripts/wallpaper.sh" = {
          source = ./.config/hypr/scripts/wallpaper.sh;
          executable = true;
        };
      };
    })

    # Waybar 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.waybar.enable && config.myHome.desktop.hyprland.waybar.configStyle == "copyFiles") {
      home.packages = [ pkgs.waybar ];

      xdg.configFile = {
        "waybar/config".source = ./.config/waybar/config;
        "waybar/style.css".source = ./.config/waybar/style.css;
      };
    })

    # Dunst 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.dunst.enable && config.myHome.desktop.hyprland.dunst.configStyle == "copyFiles") {
      home.packages = [ pkgs.dunst ];

      xdg.configFile = {
        "dunst/dunstrc".source = ./.config/dunst/dunstrc;
      };

      services.dunst.enable = true;
    })

    # Rofi 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.rofi.enable && config.myHome.desktop.hyprland.rofi.configStyle == "copyFiles") {
      home.packages = with pkgs; [
        rofi
        whitesur-icon-theme
      ];

      home.file = {
        ".config/rofi/config.rasi".source = ./.config/rofi/config.rasi;
        ".config/rofi/themes".source = ./.config/rofi/themes;
      };

      # Rofi 环境变量
      home.sessionVariables = {
        ROFI_CONFIG_DIR = "${config.home.homeDirectory}/.config/rofi";
        ROFI_ICON_THEME = "WhiteSur";
      };
    })

    # Swappy 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.swappy.enable && config.myHome.desktop.hyprland.swappy.configStyle == "copyFiles") {
      home.packages = [ pkgs.swappy ];

      xdg.configFile = {
        "swappy/config".source = ./.config/swappy/config;
      };
    })

    # Wlogout 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.wlogout.enable && config.myHome.desktop.hyprland.wlogout.configStyle == "copyFiles") {
      home.packages = [ pkgs.wlogout ];

      xdg.configFile = {
        "wlogout/layout".source = ./.config/wlogout/layout;
        "wlogout/style.css".source = ./.config/wlogout/style.css;
      };
    })

    # Fuzzel 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.fuzzel.enable && config.myHome.desktop.hyprland.fuzzel.configStyle == "copyFiles") {
      home.packages = [ pkgs.fuzzel ];

      xdg.configFile = {
        "fuzzel/fuzzel.ini".source = ./.config/fuzzel/fuzzel.ini;
      };
    })

    # Ironbar 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.ironbar.enable && config.myHome.desktop.hyprland.ironbar.configStyle == "copyFiles") {
      home.packages = [ pkgs.ironbar ];

      xdg.configFile = {
        "ironbar/config.toml".source = ./.config/ironbar/config.toml;
        "ironbar/style.css".source = ./.config/ironbar/style.css;
      };
    })

    # Swaylock 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.swaylock.enable && config.myHome.desktop.hyprland.swaylock.configStyle == "copyFiles") {
      home.packages = with pkgs; [ swaylock lxgw-wenkai ];

      xdg.configFile = {
        "swaylock/config".source = ./.config/swaylock/config;
      };
    })

    # Swayidle 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.swayidle.enable && config.myHome.desktop.hyprland.swayidle.configStyle == "copyFiles") {
      home.packages = with pkgs; [
        swayidle
        brightnessctl    # 亮度控制（用于渐进式节能）
        libnotify        # 通知支持
      ];

      xdg.configFile = {
        "swayidle/config".source = ./.config/swayidle/config;
      };
    })

    # Mako 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.mako.enable && config.myHome.desktop.hyprland.mako.configStyle == "copyFiles") {
      home.packages = with pkgs; [
        mako
        lxgw-wenkai         # 霞鹜文楷
      ];

      xdg.configFile = {
        "mako/config".source = ./.config/mako/config;
      };

      # Mako 通知守护进程配置
      services.mako = {
        enable = true;
        package = pkgs.mako;
      };
    })
  ];
}
