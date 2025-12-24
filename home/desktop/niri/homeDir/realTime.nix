{ config, lib, pkgs, inputs, ... }:
let
  # 定义当前目录的绝对路径
  currentDir = "${config.home.homeDirectory}/config.d/home/dotfiles/homeDir";
in
{
  config = lib.mkMerge [
    # Niri 生态系统包配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.packages.realTime.enable) {
      home.packages = with pkgs; [
        grim                   # Wayland 截图工具
        slurp                  # 区域选择工具
        swappy                 # 截图编辑器
        wf-recorder            # 录屏工具
        wl-clipboard           # Wayland 剪贴板
        cliphist               # 剪贴板历史
        brightnessctl          # 亮度控制
        pamixer                # 音量控制
        playerctl              # 媒体播放控制
        libnotify              # 发送桌面通知的库
        nautilus               # 文件管理器
      ];
    })

    # Niri 环境变量配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.environment.realTime.enable) {
      home.sessionVariables = {
        # Niri 相关环境变量
        XDG_CURRENT_DESKTOP = "niri";
        XDG_SESSION_DESKTOP = "niri";
        XDG_SESSION_TYPE = "wayland";
        # Wayland 相关环境变量
        WAYLAND_DISPLAY = "wayland-1";
        QT_QPA_PLATFORM = "wayland;xcb";
        GDK_BACKEND = "wayland,x11";
        SDL_VIDEODRIVER = "wayland";
        CLUTTER_BACKEND = "wayland";
        MOZ_ENABLE_WAYLAND = "1";
        # 输入法支持
        QT_IM_MODULE = "fcitx";
        GTK_IM_MODULE = "fcitx";
        XMODIFIERS = "@im=fcitx";
        WLR_NO_HARDWARE_CURSORS = "1";
        NIXOS_OZONE_WL = "1";
      };
    })

    # Niri 核心配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.niri.realTime.enable) {
      home.packages =
        if config.myHome.desktop.niri.niri.realTime.packageSource == "flake" then [
          # 使用 Niri 官方 flake 中的最新版本
          inputs.niri.packages.${pkgs.system}.niri
          # 其他相关包仍使用 nixpkgs
          pkgs.swww
          pkgs.sunsetr
          pkgs.apple-cursor
          # xwayland-satellite: 提供更好的 Xwayland 体验，按需启动 X11 应用
          pkgs.xwayland-satellite
        ] else if config.myHome.desktop.niri.niri.realTime.packageSource == "nixpkgs" then (with pkgs; [
          # 使用 nixpkgs 中的稳定版本
          niri
          swww
          apple-cursor
          # xwayland-satellite: 提供更好的 Xwayland 体验，按需启动 X11 应用
          xwayland-satellite
        ]) else [
          # packageSource == "none": 不安装任何包
        ];

      xdg.configFile = {
        "niri/config.kdl".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/niri/config.kdl";
      };
    })

    # Waybar 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.waybar.realTime.enable) {
      home.packages =
        if config.myHome.desktop.niri.waybar.realTime.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.desktop.niri.waybar.realTime.packageSource == "nixpkgs" then (with pkgs; [ waybar ]) else [];

      xdg.configFile = {
        "waybar/config".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/waybar/config";
        "waybar/style.css".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/waybar/style.css";
        "waybar/scripts/wallpaper.sh" = {
          source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/waybar/scripts/wallpaper.sh";
          executable = true;
        };
      };
    })

    # Ironbar 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.ironbar.realTime.enable) {
      home.packages =
        if config.myHome.desktop.niri.ironbar.realTime.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.desktop.niri.ironbar.realTime.packageSource == "nixpkgs" then (with pkgs; [ ironbar ]) else [];

      xdg.configFile = {
        "ironbar/config.toml".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/ironbar/config.toml";
        "ironbar/style.css".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/ironbar/style.css";
      };
    })

    # Rofi 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.rofi.realTime.enable) {
      home.packages =
        if config.myHome.desktop.niri.rofi.realTime.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.desktop.niri.rofi.realTime.packageSource == "nixpkgs" then (with pkgs; [
          rofi
        ]) else [];

      xdg.configFile = {
        "rofi/config.rasi".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/rofi/config.rasi";
        "rofi/themes/dark.rasi".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/rofi/themes/dark.rasi";
      };
    })

    # Vicinae 配置 (现代化应用启动器)
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.vicinae.realTime.enable) {
      home.packages =
        if config.myHome.desktop.niri.vicinae.realTime.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.desktop.niri.vicinae.realTime.packageSource == "nixpkgs" then (with pkgs; [
          # vicinae: 高性能的原生启动器，类似 Raycast
          # 功能: 应用启动、文件搜索、剪贴板历史、计算器、emoji 选择器等
          vicinae
        ]) else [];

      # Vicinae 配置文件
      xdg.configFile = {
        "vicinae/settings.json".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/vicinae/settings.json";
      };
    })

    # Fuzzel 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.fuzzel.realTime.enable) {
      home.packages =
        if config.myHome.desktop.niri.fuzzel.realTime.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.desktop.niri.fuzzel.realTime.packageSource == "nixpkgs" then (with pkgs; [ fuzzel lxgw-wenkai ]) else [];

      xdg.configFile = {
        "fuzzel/fuzzel.ini".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/fuzzel/fuzzel.ini";
      };
    })

    # Swaylock 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.swaylock.realTime.enable) {
      home.packages =
        if config.myHome.desktop.niri.swaylock.realTime.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.desktop.niri.swaylock.realTime.packageSource == "nixpkgs" then (with pkgs; [
          swaylock
          lxgw-wenkai
        ]) else [];

      xdg.configFile = {
        "swaylock/config".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/swaylock/config";
      };
    })

    # Swayidle 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.swayidle.realTime.enable) {
      home.packages =
        if config.myHome.desktop.niri.swayidle.realTime.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.desktop.niri.swayidle.realTime.packageSource == "nixpkgs" then (with pkgs; [
          swayidle
          brightnessctl    # 亮度控制（用于渐进式节能）
          libnotify        # 通知支持
        ]) else [];

      xdg.configFile = {
        "swayidle/config".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/swayidle/config";
      };
    })

    # Wlogout 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.wlogout.realTime.enable) {
      home.packages =
        if config.myHome.desktop.niri.wlogout.realTime.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.desktop.niri.wlogout.realTime.packageSource == "nixpkgs" then (with pkgs; [
          wlogout
        ]) else [];

      xdg.configFile = {
        "wlogout/layout".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/wlogout/layout";
        "wlogout/style.css".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/wlogout/style.css";
        "wlogout/icons".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/wlogout/icons";
      };
    })

    # Dunst 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.dunst.realTime.enable) {
      home.packages =
        if config.myHome.desktop.niri.dunst.realTime.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.desktop.niri.dunst.realTime.packageSource == "nixpkgs" then (with pkgs; [
          dunst
        ]) else [];

      xdg.configFile = {
        "dunst/dunstrc".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/dunst/dunstrc";
      };

      services.dunst.enable = true;
    })

    # Mako 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.mako.realTime.enable) {
      home.packages =
        if config.myHome.desktop.niri.mako.realTime.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.desktop.niri.mako.realTime.packageSource == "nixpkgs" then (with pkgs; [
          mako
          lxgw-wenkai         # 霞鹜文楷
        ]) else [];

      xdg.configFile = {
        "mako/config".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/mako/config";
      };

      # Mako 通知守护进程配置
      services.mako = {
        enable = true;
        package = pkgs.mako;
      };
    })
  ];
}
