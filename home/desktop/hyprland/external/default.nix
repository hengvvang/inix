{ config, lib, pkgs, ... }:

{
  imports = [
    ./hypr
    ./waybar
    ./dunst
    # ./rofi
    ./swappy
    ./wlogout
    ./fuzzel
  ];

  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.method == "external") {

    # ========== Hyprland 生态系统软件包 ==========
    # Home Manager 中配置完整的 Hyprland 桌面环境包
    home.packages = with pkgs; [
      
      # ===== 截图和录屏工具 =====
      grimblast           # 截图工具 (Hyprland 优化版)
      grim                # Wayland 截图工具
      slurp               # 区域选择工具
      swappy              # 截图编辑器
      wf-recorder          # 录屏工具
      
      fuzzel
      
      # ===== 剪贴板和工具 =====
      wl-clipboard        # Wayland 剪贴板
      cliphist            # 剪贴板历史
      
      # ===== 应用启动器和菜单 =====
      rofi-wayland        # 应用启动器
      wofi                # 备用启动器
      wlogout             # 退出菜单
      
      # ===== 系统控制工具 =====
      brightnessctl       # 亮度控制
      pamixer             # 音量控制
      playerctl           # 媒体播放控制
      
      # ===== 状态栏和通知 =====
      waybar              # 状态栏
      dunst               # 通知守护进程
      mako                # 备用通知守护进程
      libnotify           # 发送桌面通知的库
      
      # ===== 终端模拟器 =====
      kitty               # 现代 GPU 加速终端
      
      # ===== 文件管理和桌面 =====
      xdg-desktop-portal-hyprland  # Hyprland 桌面门户
      nautilus            # GNOME 文件管理器
      
      # ===== 系统设置和主题 =====
      nwg-look            # GTK 主题设置工具
      adwaita-icon-theme  # GNOME 图标主题
      
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
      
      # 其他优化
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };
    
  };
}
