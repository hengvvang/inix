{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.method == "external") {

    # ========== Hyprland 生态系统软件包 ==========
    # Home Manager 中配置完整的 Hyprland 桌面环境包
    home.packages = with pkgs; [
      # ===== Hyprland 扩展工具 =====
      pyprland            # Python 插件系统，扩展 Hyprland 功能
      hyprpicker          # 颜色选择器工具
      hyprcursor          # 光标主题管理器
      hyprlock            # 屏幕锁定程序
      hypridle            # 空闲管理守护进程
      hyprpaper           # 壁纸管理器
      
      # ===== 截图和录屏工具 =====
      grimblast           # 截图工具 (Hyprland 优化版)
      grim                # Wayland 截图工具
      slurp               # 区域选择工具
      swappy              # 截图编辑器
      wf-recorder          # 录屏工具
      
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
      
      # 注意：以下包由系统级配置提供，避免重复安装：
      # - networkmanagerapplet (已在 system/services/network/manager/networkmanager.nix 中配置)
      # - blueman (已在 system/services/drivers/bluetooth/bluetooth.nix 中配置)
      # - polkit-kde-agent-1 (系统级 polkit 已启用，权限认证由系统处理)
    ];

    # ========== XDG 配置目录文件 ==========
    xdg.configFile = {
      # Hyprland 核心配置
      "hypr/hyprland.conf".source = ./hypr/hyprland.conf;
      "hypr/hypridle.conf".source = ./hypr/hypridle.conf;
      "hypr/hyprlock.conf".source = ./hypr/hyprlock.conf;
      "hypr/hyprpaper.conf".source = ./hypr/hyprpaper.conf;
      
      # 主题配置
      "hypr/themes/catppuccin.conf".source = ./hypr/themes/catppuccin.conf;
      
      # Waybar 配置
      "waybar/config".source = ./waybar/config;
      "waybar/style.css".source = ./waybar/style.css;
      
      # Dunst 配置
      "dunst/dunstrc".source = ./dunst/dunstrc;
      
      # 其他工具配置
      "swappy/config".source = ./swappy/config;
      "wlogout/layout".source = ./wlogout/layout;
      "wlogout/style.css".source = ./wlogout/style.css;
    };

    # ========== 系统服务 ==========
    services = {
      # 通知服务
      dunst.enable = true;
    };

    # ========== 程序配置 ==========
    programs = {
      # 状态栏
      waybar.enable = true;
      
      # 应用启动器
      rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
        theme = ./rofi/config.rasi;
      };
    };

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
