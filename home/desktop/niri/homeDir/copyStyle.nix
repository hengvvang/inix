{ config, lib, pkgs, inputs, ... }:

{
  config = lib.mkMerge [
    # Niri 生态系统包配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.packages.enable && config.myHome.desktop.niri.packages.configStyle == "copyFiles") {
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
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.environment.enable && config.myHome.desktop.niri.environment.configStyle == "copyFiles") {
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
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.niri.enable && config.myHome.desktop.niri.niri.configStyle == "copyFiles") {
      home.packages = with pkgs; [
        niri
        swww
        apple-cursor
        # xwayland-satellite: 提供更好的 Xwayland 体验，按需启动 X11 应用
        xwayland-satellite
      ];

      xdg.configFile = {
        "niri/config.kdl".source = ./.config/niri/config.kdl;
        "niri/startup.kdl".source = ./.config/niri/startup.kdl;
        "niri/environment.kdl".source = ./.config/niri/environment.kdl;
        "niri/input.kdl".source = ./.config/niri/input.kdl;
        "niri/output.kdl".source = ./.config/niri/output.kdl;
        "niri/layout.kdl".source = ./.config/niri/layout.kdl;
        "niri/animations.kdl".source = ./.config/niri/animations.kdl;
        "niri/gestures.kdl".source = ./.config/niri/gestures.kdl;
        "niri/window-rules.kdl".source = ./.config/niri/window-rules.kdl;
        "niri/recent-windows.kdl".source = ./.config/niri/recent-windows.kdl;
        "niri/binds.kdl".source = ./.config/niri/binds.kdl;
      };
    })

    # Waybar 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.waybar.enable && config.myHome.desktop.niri.waybar.configStyle == "copyFiles") {
      home.packages = [ pkgs.waybar ];

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
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.ironbar.enable && config.myHome.desktop.niri.ironbar.configStyle == "copyFiles") {
      home.packages = [ pkgs.ironbar ];

      xdg.configFile = {
        "ironbar/config.toml".source = ./.config/ironbar/config.toml;
        "ironbar/style.css".source = ./.config/ironbar/style.css;
      };
    })

    # Rofi 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.rofi.enable && config.myHome.desktop.niri.rofi.configStyle == "copyFiles") {
      home.packages = [ pkgs.rofi ];

      xdg.configFile = {
        "rofi/config.rasi".source = ./.config/rofi/config.rasi;
        "rofi/themes/dark.rasi".source = ./.config/rofi/themes/dark.rasi;
      };
    })

    # Vicinae 配置 (现代化应用启动器)
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.vicinae.enable && config.myHome.desktop.niri.vicinae.configStyle == "copyFiles") {
      home.packages = [ pkgs.vicinae ];

      # Vicinae 配置文件
      xdg.configFile = {
        "vicinae/settings.json".source = ./.config/vicinae/settings.json;
      };
    })

    # Fuzzel 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.fuzzel.enable && config.myHome.desktop.niri.fuzzel.configStyle == "copyFiles") {
      home.packages = with pkgs; [ fuzzel lxgw-wenkai ];

      xdg.configFile = {
        "fuzzel/fuzzel.ini".source = ./.config/fuzzel/fuzzel.ini;
      };
    })

    # Swaylock 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.swaylock.enable && config.myHome.desktop.niri.swaylock.configStyle == "copyFiles") {
      home.packages = with pkgs; [ swaylock lxgw-wenkai ];

      xdg.configFile = {
        "swaylock/config".source = ./.config/swaylock/config;
      };
    })

    # Swayidle 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.swayidle.enable && config.myHome.desktop.niri.swayidle.configStyle == "copyFiles") {
      home.packages = with pkgs; [
        swayidle
        brightnessctl    # 亮度控制（用于渐进式节能）
        libnotify        # 通知支持
      ];

      xdg.configFile = {
        "swayidle/config".source = ./.config/swayidle/config;
      };
    })

    # Wlogout 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.wlogout.enable && config.myHome.desktop.niri.wlogout.configStyle == "copyFiles") {
      home.packages = [ pkgs.wlogout ];

      xdg.configFile = {
        "wlogout/layout".source = ./.config/wlogout/layout;
        "wlogout/style.css".source = ./.config/wlogout/style.css;
        "wlogout/icons".source = ./.config/wlogout/icons;
      };
    })

    # Dunst 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.dunst.enable && config.myHome.desktop.niri.dunst.configStyle == "copyFiles") {
      home.packages = [ pkgs.dunst ];

      xdg.configFile = {
        "dunst/dunstrc".source = ./.config/dunst/dunstrc;
      };

      services.dunst.enable = true;
    })

    # Mako 配置
    (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.mako.enable && config.myHome.desktop.niri.mako.configStyle == "copyFiles") {
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
