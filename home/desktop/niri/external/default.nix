{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.niri.enable && config.myHome.desktop.niri.method == "external") {

    # ========== Niri 生态系统软件包 ==========
    # Home Manager 中配置完整的 Niri 桌面环境包
    home.packages = with pkgs; [
      # ===== Niri 扩展工具 =====
      niriswitcher           # Niri 应用切换器
      
      # ===== 截图和录屏工具 =====  
      grim                   # Wayland 截图工具
      slurp                  # 区域选择工具
      swappy                 # 截图编辑器
      wf-recorder            # 录屏工具
      
      # ===== 剪贴板和工具 =====
      wl-clipboard           # Wayland 剪贴板
      cliphist               # 剪贴板历史
      
      # ===== 应用启动器和菜单 =====
      fuzzel                 # 应用启动器 (niri 推荐)
      wlogout                # 退出菜单
      
      # ===== 系统控制工具 =====
      brightnessctl          # 亮度控制
      pamixer                # 音量控制
      playerctl              # 媒体播放控制
      
      # ===== 状态栏和通知 =====
      waybar                 # 状态栏
      dunst                  # 通知守护进程
      
      # ===== 屏幕锁定和会话管理 =====
      swaylock               # 屏幕锁定
      swayidle               # 空闲管理
      
      # ===== 壁纸和主题 =====
      swaybg                 # 壁纸设置
      
      # ===== X11 兼容层 =====
      xwayland-satellite     # X11 应用支持 (推荐用于 niri)
      
      # ===== 文件管理器 =====
      nautilus               # GNOME 文件管理器
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
      "niri/scripts/media.sh" = {
        source = ./scripts/media.sh;
        executable = true;
      };
    };

    # ========== 系统服务配置 ==========
    # 仅配置 Niri 特定的用户级服务，避免与系统级服务重复
    systemd.user.services = {
      # Waybar 状态栏 - Niri 特定组件
      waybar = {
        Unit = {
          Description = "Waybar status bar";
          PartOf = [ "graphical-session.target" ];
          After = [ "graphical-session-pre.target" ];
        };
        Service = {
          Type = "simple";
          ExecStart = "${pkgs.waybar}/bin/waybar";
          Restart = "on-failure";
          RestartSec = "3";
        };
        Install.WantedBy = [ "graphical-session.target" ];
      };

      # Dunst 通知守护进程 - Niri 特定组件
      dunst = {
        Unit = {
          Description = "Dunst notification daemon";
          PartOf = [ "graphical-session.target" ];
          After = [ "graphical-session-pre.target" ];
        };
        Service = {
          Type = "simple";
          ExecStart = "${pkgs.dunst}/bin/dunst";
          Restart = "on-failure";
          RestartSec = "3";
        };
        Install.WantedBy = [ "graphical-session.target" ];
      };

      # XWayland-satellite - Niri 特定的 X11 支持
      xwayland-satellite = {
        Unit = {
          Description = "Xwayland Satellite";
          PartOf = [ "graphical-session.target" ];
          After = [ "graphical-session-pre.target" ];
          Wants = [ "graphical-session-pre.target" ];
        };
        Service = {
          Type = "notify";
          NotifyAccess = "all";
          ExecStart = "${pkgs.xwayland-satellite}/bin/xwayland-satellite";
          StandardOutput = "journal";
          Restart = "on-failure";
          RestartSec = "3";
        };
        Install.WantedBy = [ "graphical-session.target" ];
      };

      # 壁纸服务 - Niri 特定组件
      swaybg = {
        Unit = {
          Description = "Sway background";
          PartOf = [ "graphical-session.target" ];
          After = [ "graphical-session-pre.target" ];
        };
        Service = {
          Type = "simple";
          ExecStart = "${pkgs.swaybg}/bin/swaybg -m fill -c '#1e1e2e'";
          Restart = "on-failure";
          RestartSec = "3";
        };
        Install.WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
