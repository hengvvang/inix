{ config, lib, pkgs, ... }:

{
  imports = [
    ./hypr
    # ./ironbar
    ./waybar
    ./dunst
    ./rofi
    ./swappy
    ./wlogout
    # ./fuzzel
  ];

  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.method == "external") {

    home.packages = with pkgs; [
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
      nautilus
    ];
    # ========== 环境变量 ==========
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
  };
}
