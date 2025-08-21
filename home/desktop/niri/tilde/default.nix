{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ../options.nix
  ];

  config = lib.mkMerge [
    # Niri 生态系统包配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.packages.enable && config.myHome.desktop.niri.packages.method == "copyLink") {
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
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.environment.enable && config.myHome.desktop.niri.environment.method == "copyLink") {
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
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.niri.enable && config.myHome.desktop.niri.niri.method == "copyLink") {
      home.packages =
        if config.myHome.desktop.niri.niri.packageSource == "flake" then [
          # 使用 Niri 官方 flake 中的最新版本
          inputs.niri.packages.${pkgs.system}.niri
          # 其他相关包仍使用 nixpkgs
          pkgs.niriswitcher
          pkgs.swww
          pkgs.apple-cursor
          pkgs.xwayland-satellite
        ] else if config.myHome.desktop.niri.niri.packageSource == "nixpkgs" then (with pkgs; [
          # 使用 nixpkgs 中的稳定版本
          niri
          niriswitcher
          swww
          apple-cursor
          xwayland-satellite
        ]) else [
          # packageSource == "none": 不安装任何包
        ];

      xdg.configFile = {
        "niri/config.kdl".source = ./.config/niri/config.kdl;
      };
    })

    # Waybar 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.waybar.enable && config.myHome.desktop.niri.waybar.method == "copyLink") {
      home.packages = if config.myHome.desktop.niri.waybar.packageSource == "nixpkgs" then (with pkgs; [ waybar ]) else [];

      xdg.configFile = {
        "waybar/config".source = ./.config/waybar/config;
        "waybar/style.css".source = ./.config/waybar/style.css;
        "waybar/scripts/wallpaper.sh" = {
          source = ./.config/waybar/scripts/wallpaper.sh;
          executable = true;
        };
      };
    })

    # Ironbar 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.ironbar.enable && config.myHome.desktop.niri.ironbar.method == "copyLink") {
      home.packages = if config.myHome.desktop.niri.ironbar.packageSource == "nixpkgs" then (with pkgs; [ ironbar ]) else [];

      xdg.configFile = {
        "ironbar/config.toml".source = ./.config/ironbar/config.toml;
        "ironbar/style.css".source = ./.config/ironbar/style.css;
      };
    })

    # Rofi 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.rofi.enable && config.myHome.desktop.niri.rofi.method == "copyLink") {
      home.packages = if config.myHome.desktop.niri.rofi.packageSource == "nixpkgs" then (with pkgs; [
        rofi-wayland
      ]) else [];

      xdg.configFile = {
        "rofi/config.rasi".source = ./.config/rofi/config.rasi;
        "rofi/themes/dark.rasi".source = ./.config/rofi/themes/dark.rasi;
      };
    })

    # Fuzzel 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.fuzzel.enable && config.myHome.desktop.niri.fuzzel.method == "copyLink") {
      home.packages = if config.myHome.desktop.niri.fuzzel.packageSource == "nixpkgs" then (with pkgs; [ fuzzel lxgw-wenkai ]) else [];

      xdg.configFile = {
        "fuzzel/fuzzel.ini".source = ./.config/fuzzel/fuzzel.ini;
      };
    })

    # Swaylock 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.swaylock.enable && config.myHome.desktop.niri.swaylock.method == "copyLink") {
      home.packages = if config.myHome.desktop.niri.swaylock.packageSource == "nixpkgs" then (with pkgs; [
          swaylock
          lxgw-wenkai
        ]) else [];

      xdg.configFile = {
        "swaylock/config".source = ./.config/swaylock/config;
      };
    })

    # Swayidle 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.swayidle.enable && config.myHome.desktop.niri.swayidle.method == "copyLink") {
      home.packages = if config.myHome.desktop.niri.swayidle.packageSource == "nixpkgs" then (with pkgs; [
          swayidle
          brightnessctl    # 亮度控制（用于渐进式节能）
          libnotify        # 通知支持
        ]) else [];

      xdg.configFile = {
        "swayidle/config".source = ./.config/swayidle/config;
      };
    })

    # Wlogout 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.wlogout.enable && config.myHome.desktop.niri.wlogout.method == "copyLink") {
      home.packages = if config.myHome.desktop.niri.wlogout.packageSource == "nixpkgs" then (with pkgs; [
        wlogout
      ]) else [];

      xdg.configFile = {
        "wlogout/layout".source = ./.config/wlogout/layout;
        "wlogout/style.css".source = ./.config/wlogout/style.css;
        "wlogout/icons".source = ./.config/wlogout/icons;
      };
    })

    # Dunst 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.dunst.enable && config.myHome.desktop.niri.dunst.method == "copyLink") {
      home.packages = if config.myHome.desktop.niri.dunst.packageSource == "nixpkgs" then (with pkgs; [
        dunst
      ]) else [];

      xdg.configFile = {
        "dunst/dunstrc".source = ./.config/dunst/dunstrc;
      };

      services.dunst.enable = true;
    })

    # Mako 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.mako.enable && config.myHome.desktop.niri.mako.method == "copyLink") {
      home.packages = if config.myHome.desktop.niri.mako.packageSource == "nixpkgs" then (with pkgs; [
        mako
        lxgw-wenkai         # 霞鹜文楷
      ]) else [];

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
