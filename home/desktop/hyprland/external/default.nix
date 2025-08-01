{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.hyprland.enable && config.myHome.desktop.hyprland.method == "external") {

    # ========== Hyprland 生态系统软件包 ==========
    home.packages = with pkgs; [
      # 核心 Wayland 工具
      hyprpicker          # 颜色选择器
      hyprpaper           # 壁纸管理
      hypridle            # 空闲管理
      hyprlock            # 屏幕锁定
      
      # 截图工具
      grimblast           # 截图工具 (Hyprland 优化版)
      grim                # Wayland 截图工具
      slurp               # 区域选择工具
      swappy              # 截图编辑器
      
      # 剪贴板和工具
      wl-clipboard        # Wayland 剪贴板
      cliphist            # 剪贴板历史
      
      # 应用启动器和菜单
      rofi-wayland        # 应用启动器
      wofi                # 备用启动器
      wlogout             # 退出菜单
      
      # 系统控制工具
      brightnessctl       # 亮度控制
      pamixer             # 音量控制
      playerctl           # 媒体播放控制
      
      # 状态栏和通知
      waybar              # 状态栏
      dunst               # 通知守护进程
      
      # 文件管理和桌面
      xdg-desktop-portal-hyprland  # Hyprland 桌面门户
      kdePackages.polkit-kde-agent-1  # 权限认证代理
      
      # 网络和蓝牙
      networkmanagerapplet # 网络管理器托盘
      blueman             # 蓝牙管理器
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
      
      # Rofi 配置
      "rofi/config.rasi".source = ./rofi/config.rasi;
      
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
