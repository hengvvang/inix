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
  ];

  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.method == "external") {

    # ========== 环境变量配置 ==========
    # macOS 风格光标主题配置
    home.sessionVariables = {
      XDG_CURRENT_DESKTOP = "niri";

      QT_QPA_PLATFORM = "wayland;xcb";

      MOZ_ENABLE_WAYLAND = "1";
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
      nautilus               # GNOME 文件管理器
    ];
  };
}
