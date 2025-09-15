{ config, lib, pkgs, inputs, ... }:
let
  # 定义当前目录的绝对路径
  currentDir = toString ./.;
in
{
  config = lib.mkMerge [
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.packages.enable && config.myHome.desktop.hyprland.packages.method == "realTime") {
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

    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.environment.enable && config.myHome.desktop.hyprland.environment.method == "realTime") {
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
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.hypr.enable && config.myHome.desktop.hyprland.hypr.method == "realTime") {
      home.packages =
        if config.myHome.desktop.hyprland.hypr.packageSource == "flake" then [
          # 使用 Hyprland 官方 flake 中的最新版本
          inputs.hyprland.packages.${pkgs.system}.hyprland
          inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
          # 其他相关包仍使用 nixpkgs
          pkgs.hyprpaper
          pkgs.hypridle
          pkgs.hyprlock
          pkgs.hyprcursor
        ] else if config.myHome.desktop.hyprland.hypr.packageSource == "nixpkgs" then (with pkgs; [
          # 使用 nixpkgs 中的稳定版本
          hyprland
          xdg-desktop-portal-hyprland
          hyprpaper
          hypridle
          hyprlock
          hyprcursor
        ]) else [
          # packageSource == "none": 不安装任何包
        ];
      xdg.configFile = {
        "hypr/hyprland.conf".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/hypr/hyprland.conf";
        "hypr/hypridle.conf".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/hypr/hypridle.conf";
        "hypr/hyprlock.conf".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/hypr/hyprlock.conf";
        "hypr/hyprpaper.conf".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/hypr/hyprpaper.conf";

        # 主题配置
        "hypr/themes/catppuccin.conf".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/hypr/themes/catppuccin.conf";
        "hypr/themes/macos-tahoe-glass.conf".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/hypr/themes/macos-tahoe-glass.conf";

        # 脚本配置
        "hypr/scripts/wallpaper.sh" = {
          source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/hypr/scripts/wallpaper.sh";
          executable = true;
        };
      };
    })

    # Waybar 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.waybar.enable && config.myHome.desktop.hyprland.waybar.method == "realTime") {
      home.packages =
        if config.myHome.desktop.hyprland.waybar.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.desktop.hyprland.waybar.packageSource == "nixpkgs" then (with pkgs; [ waybar ]) else [];
      xdg.configFile = {
        "waybar/config".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/waybar/config";
        "waybar/style.css".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/waybar/style.css";
      };
    })

    # Dunst 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.dunst.enable && config.myHome.desktop.hyprland.dunst.method == "realTime") {
      home.packages =
        if config.myHome.desktop.hyprland.dunst.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.desktop.hyprland.dunst.packageSource == "nixpkgs" then (with pkgs; [ dunst ]) else [];
      xdg.configFile = {
        "dunst/dunstrc".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/dunst/dunstrc";
      };
    })

    # Rofi 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.rofi.enable && config.myHome.desktop.hyprland.rofi.method == "realTime") {
      home.packages =
        if config.myHome.desktop.hyprland.rofi.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.desktop.hyprland.rofi.packageSource == "nixpkgs" then (with pkgs; [
          rofi
          whitesur-icon-theme
        ]) else [];
      home.file = {
        ".config/rofi/config.rasi".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/rofi/config.rasi";
        ".config/rofi/themes".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/rofi/themes";
      };

      # Rofi 环境变量
      home.sessionVariables = {
        ROFI_CONFIG_DIR = "${config.home.homeDirectory}/.config/rofi";
        ROFI_ICON_THEME = "WhiteSur";
      };
    })

    # Swappy 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.swappy.enable && config.myHome.desktop.hyprland.swappy.method == "realTime") {
      home.packages =
        if config.myHome.desktop.hyprland.swappy.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.desktop.hyprland.swappy.packageSource == "nixpkgs" then (with pkgs; [ swappy ]) else [];

      xdg.configFile = {
        "swappy/config".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/swappy/config";
      };
    })

    # Wlogout 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.wlogout.enable && config.myHome.desktop.hyprland.wlogout.method == "realTime") {
      home.packages =
        if config.myHome.desktop.hyprland.wlogout.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.desktop.hyprland.wlogout.packageSource == "nixpkgs" then (with pkgs; [ wlogout ]) else [];

      xdg.configFile = {
        "wlogout/layout".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/wlogout/layout";
        "wlogout/style.css".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/wlogout/style.css";
      };
    })

    # Fuzzel 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.fuzzel.enable && config.myHome.desktop.hyprland.fuzzel.method == "realTime") {
      home.packages =
        if config.myHome.desktop.hyprland.fuzzel.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.desktop.hyprland.fuzzel.packageSource == "nixpkgs" then (with pkgs; [ fuzzel ]) else [];

      xdg.configFile = {
        "fuzzel/fuzzel.ini".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/fuzzel/fuzzel.ini";
      };
    })

    # IronBar 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.ironbar.enable && config.myHome.desktop.hyprland.ironbar.method == "realTime") {
      home.packages =
        if config.myHome.desktop.hyprland.ironbar.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.desktop.hyprland.ironbar.packageSource == "nixpkgs" then (with pkgs; [ ironbar ]) else [];

      xdg.configFile = {
        "ironbar/config.toml".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/ironbar/config.toml";
        "ironbar/style.css".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/ironbar/style.css";
      };
    })
  ];
}
