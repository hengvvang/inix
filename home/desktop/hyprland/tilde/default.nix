{ config, lib, pkgs, ... }:

{
  imports = [
    ../options.nix  # 引用上级目录的选项定义
  ];

  config = lib.mkMerge [
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.packages.enable && config.myHome.desktop.hyprland.packages.method == "copy") {
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

    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.environment.enable && config.myHome.desktop.hyprland.environment.method == "copy") {
      home.sessionVariables =   {
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
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.hypr.enable && config.myHome.desktop.hyprland.hypr.method == "copy") {
      home.packages = lib.optionals config.myHome.desktop.hyprland.hypr.useNixPackage (with pkgs; [
        hyprland
        xdg-desktop-portal-hyprland
        hyprpaper
        hypridle
        hyprlock
        hyprcursor
      ]);
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
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.waybar.enable && config.myHome.desktop.hyprland.waybar.method == "copy") {
      home.packages = lib.optionals config.myHome.desktop.hyprland.waybar.useNixPackage (with pkgs; [ waybar ]);
      xdg.configFile = {
        "waybar/config".source = ./.config/waybar/config;
        "waybar/style.css".source = ./.config/waybar/style.css;
      };
    })

    # Dunst 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.dunst.enable && config.myHome.desktop.hyprland.dunst.method == "copy") {
      home.packages = lib.optionals config.myHome.desktop.hyprland.dunst.useNixPackage (with pkgs; [ dunst ]);
      xdg.configFile = {
        "dunst/dunstrc".source = ./.config/dunst/dunstrc;
      };
    })

    # Rofi 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.rofi.enable && config.myHome.desktop.hyprland.rofi.method == "copy") {
      home.packages = lib.optionals config.myHome.desktop.hyprland.rofi.useNixPackage (with pkgs; [
        rofi-wayland
        whitesur-icon-theme
      ]);
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
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.swappy.enable && config.myHome.desktop.hyprland.swappy.method == "copy") {
      home.packages = lib.optionals config.myHome.desktop.hyprland.swappy.useNixPackage (with pkgs; [ swappy ]);

      xdg.configFile = {
        "swappy/config".source = ./.config/swappy/config;
      };
    })

    # Wlogout 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.wlogout.enable && config.myHome.desktop.hyprland.wlogout.method == "copy") {
      home.packages = lib.optionals config.myHome.desktop.hyprland.wlogout.useNixPackage (with pkgs; [ wlogout ]);

      xdg.configFile = {
        "wlogout/layout".source = ./.config/wlogout/layout;
        "wlogout/style.css".source = ./wlogout/style.css;
      };
    })

    # Fuzzel 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.fuzzel.enable && config.myHome.desktop.hyprland.fuzzel.method == "copy") {
      home.packages = lib.optionals config.myHome.desktop.hyprland.fuzzel.useNixPackage (with pkgs; [ fuzzel ]);

      # Fuzzel 启动器配置
      # 可选主题：
      # - ./fuzzel/fuzzel.ini (默认深色主题)
      # - ./fuzzel/fuzzel-macos-glass.ini (macOS 毛玻璃效果 - 深色，推荐)
      # - ./fuzzel/fuzzel-macos-glass-light.ini (macOS 毛玻璃效果 - 浅色)
      # 当前使用：macOS 毛玻璃效果深色主题
      xdg.configFile = {
        "fuzzel/fuzzel.ini".source = ./.config/fuzzel/fuzzel-macos-glass.ini;
      };
    })

    # IronBar 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.ironbar.enable && config.myHome.desktop.hyprland.ironbar.method == "copy") {
      home.packages = lib.optionals config.myHome.desktop.hyprland.ironbar.useNixPackage (with pkgs; [ ironbar ]);

      xdg.configFile = {
        "ironbar/config.toml".source = ./.config/ironbar/config.toml;
        "ironbar/style.css".source = ./.config/ironbar/style.css;
      };
    })
  ];
}
