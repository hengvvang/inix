{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.method == "external") {

    home.packages = with pkgs; [

      mako       # recommended notification daemon
      waybar     # status bar
      swaybg     # wallpaper manager
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

    # ========== XDG 配置目录文件 ==========
    xdg.configFile = {
      # Niri 核心配置
      "niri/config.kdl".source = ./niri/config.kdl;
      
      # Waybar 配置
      "waybar/config.jsonc".source = ./waybar/config.jsonc;
      "waybar/style.css".source = ./waybar/style.css;
      
      
      # Fuzzel 启动器配置
      "fuzzel/fuzzel.ini".source = ./fuzzel/fuzzel.ini;
      
      # Swaylock 配置
      "swaylock/config".source = ./swaylock/config;
      
      # 脚本文件
      "niri/scripts/screenshot.sh" = {
        source = ./scripts/screenshot.sh;
        executable = true;
      };
      "niri/scripts/toggle-display.sh" = {
        source = ./scripts/toggle-display.sh;
        executable = true;
      };
      "niri/scripts/brightness.sh" = {
        source = ./scripts/brightness.sh;
        executable = true;
      };
      "niri/scripts/volume.sh" = {
        source = ./scripts/volume.sh;
        executable = true;
      };
      "niri/scripts/check-components.sh" = {
        source = ./scripts/check-components.sh;
        executable = true;
      };
      "niri/scripts/media.sh" = {
        source = ./scripts/media.sh;
        executable = true;
      };
    };
  };
}
