{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.niri.enable && config.myHome.desktop.niri.method == "external") {

    # ========== Niri 生态系统软件包 ==========
    home.packages = with pkgs; [
      # 核心 Wayland 工具
      niri                    # Niri 窗口管理器
      niriswitcher           # Niri 应用切换器
      
      # 截图工具  
      grim                   # Wayland 截图工具
      slurp                  # 区域选择工具
      swappy                 # 截图编辑器
      
      # 剪贴板和工具
      wl-clipboard           # Wayland 剪贴板
      cliphist               # 剪贴板历史
      
      # 应用启动器和菜单
      fuzzel                 # 应用启动器 (niri 推荐)
      wlogout                # 退出菜单
      
      # 系统控制工具
      brightnessctl          # 亮度控制
      pamixer                # 音量控制
      playerctl              # 媒体播放控制
      
      # 状态栏和通知
      waybar                 # 状态栏
      dunst                  # 通知守护进程
      
      # 文件管理和桌面
      xdg-desktop-portal-gnome  # GNOME 桌面门户 (niri 推荐)
      kdePackages.polkit-kde-agent-1  # 权限认证代理
      
      # 网络和蓝牙
      networkmanagerapplet   # 网络管理器托盘
      blueman                # 蓝牙管理器
      
      # 屏幕锁定和会话管理
      swaylock               # 屏幕锁定
      swayidle               # 空闲管理
      
      # 壁纸和主题
      swaybg                 # 壁纸设置
      
      # X11 兼容层
      xwayland-satellite     # X11 应用支持 (推荐用于 niri)
    ];

    # ========== XDG 配置目录文件 ==========
    xdg.configFile = {
      # Niri 核心配置
      "niri/config.kdl".source = ./niri/config.kdl;
      
      # Waybar 配置
      "waybar/config".source = ./waybar/config;
      "waybar/style.css".source = ./waybar/style.css;
      
      # Dunst 通知配置
      "dunst/dunstrc".source = ./dunst/dunstrc;
      
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
  };
}
