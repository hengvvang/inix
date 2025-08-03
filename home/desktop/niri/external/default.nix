{ config, lib, pkgs, ... }:

{
  imports = [
    ./niri
    ./waybar
    ./fuzzel
    ./swaylock
    ./scripts
    ./dunst
    ./mako
  ];

  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.method == "external") {

    home.packages = with pkgs; [

      dunst      # alternative notification daemon with macOS Tahoe style
      mako       # recommended notification daemon
      swww       # wallpaper manager
      waybar     # status bar
      # swaybg   # wallpaper manager
      swayidle   # idle management
      swaylock   # screen locker

      niriswitcher           # Niri 应用切换器
      xwayland-satellite     # X11 应用支持 (推荐用于 niri)

      # ===== 截图和录屏工具 =====
      grim                   # Wayland 截图工具
      slurp                  # 区域选择工具
      swappy                 # 截图编辑器
      wf-recorder            # 录屏工具

      # ===== 剪贴板和工具 =====
      wl-clipboard           # Wayland 剪贴板
      cliphist               # 剪贴板历史

      # ===== 应用启动器和菜单 =====
      wlogout                # 退出菜单

      # ===== 系统控制工具 =====
      brightnessctl          # 亮度控制
      pamixer                # 音量控制
      playerctl              # 媒体播放控制

      # ===== 文件管理器 =====
      nautilus               # GNOME 文件管理器
    ];

  };
}
