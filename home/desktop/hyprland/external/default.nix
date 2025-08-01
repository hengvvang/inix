{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.hyprland.enable && config.myHome.desktop.hyprland.method == "external") {

    # 安装 Hyprland 生态系统相关软件包
    home.packages = with pkgs; [
      # 核心工具
      hyprpicker          # 颜色选择器
      grimblast           # 截图工具
      swappy              # 截图编辑器
      wl-clipboard        # Wayland 剪贴板
      wlogout             # 退出菜单
      # 应用启动器和菜单
      rofi-wayland        # 应用启动器
      # 系统控制工具
      brightnessctl       # 亮度控制
      playerctl           # 媒体控制
      # Python 插件管理器
      pyprland            # Hyprland Python 插件
            # 状态栏和通知
      waybar              # 状态栏
      dunst               # 通知守护进程
    ];

    # ========== XDG 配置目录文件 ==========
    # Hyprland 主配置
    xdg.configFile."hypr/hyprland.conf".source = ./hypr/hyprland.conf;
    xdg.configFile."hypr/hypridle.conf".source = ./hypr/hypridle.conf;
    xdg.configFile."hypr/hyprlock.conf".source = ./hypr/hyprlock.conf;
    xdg.configFile."hypr/hyprpaper.conf".source = ./hypr/hyprpaper.conf;
    xdg.configFile."hypr/macchiato.conf".source = ./hypr/macchiato.conf;
    xdg.configFile."hypr/pyprland.toml".source = ./hypr/pyprland.toml;

    # Waybar 状态栏配置
    xdg.configFile."waybar/config".source = ./waybar/config;
    xdg.configFile."waybar/style.css".source = ./waybar/style.css;
    xdg.configFile."waybar/macchiato.css".source = ./waybar/macchiato.css;

    # Dunst 通知配置
    xdg.configFile."dunst/dunstrc".source = ./dunst/dunstrc;

    # Swappy 截图编辑配置
    xdg.configFile."swappy/config".source = ./swappy/config;

    # Wlogout 退出菜单配置
    xdg.configFile."wlogout/layout".source = ./wlogout/layout;
    xdg.configFile."wlogout/style.css".source = ./wlogout/style.css;
    xdg.configFile."wlogout/icons".source = ./wlogout/icons;

    # ========== 服务启用 ==========
    # 启用必要的服务
    services = {
      # Hyprland 空闲管理
      hypridle.enable = true;
      
      # 通知服务
      dunst.enable = true;
      
      # 壁纸服务
      hyprpaper.enable = true;
    };

    # ========== 程序配置 ==========
    programs = {
      # 屏幕锁定
      hyprlock.enable = true;
      
      # 状态栏
      waybar.enable = true;
    };
    
  };
}
