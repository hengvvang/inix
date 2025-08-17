{ config, lib, pkgs, ... }:

{
  imports = [
    ./niri
    # ./ironbar
    ./rofi
    ./waybar
    ./fuzzel
    ./swaylock
    ./swayidle
    ./wlogout
    ./scripts
    ./dunst
    ./mako
    ./appearance
  ];

  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.method == "external") {

    # ========== 环境变量配置 ==========
    # Niri 桌面环境配置
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

    home.packages = with pkgs; [

      # swaybg   # wallpaper manager
      niriswitcher           # Niri 应用切换器

      # ===== 截图和录屏工具 =====
      grim                   # Wayland 截图工具
      slurp                  # 区域选择工具
      swappy                 # 截图编辑器
      wf-recorder            # 录屏工具

      # ===== 剪贴板和工具 =====
      wl-clipboard           # Wayland 剪贴板
      cliphist               # 剪贴板历史

      # ===== 系统控制工具 =====
      brightnessctl          # 亮度控制
      pamixer                # 音量控制
      playerctl              # 媒体播放控制

      # ===== 文件管理器 =====
      nautilus
    ];
  };
}
