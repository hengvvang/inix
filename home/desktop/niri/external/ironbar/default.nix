{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.method == "external") {

    # 创建 ironbar 配置目录和文件
    home.file = {
      # ironbar 主配置文件 - macOS Tahoe 风格
      ".config/ironbar/config.json" = {
        source = ./config.json;
      };

      # ironbar CSS 样式文件 - macOS Tahoe 液态玻璃主题
      ".config/ironbar/style.css" = {
        source = ./style.css;
      };
    };

    # 确保 ironbar 在用户包中可用
    home.packages = with pkgs; [
      ironbar
    ];

    # 可选：创建 ironbar 服务 (如果需要 systemd 服务管理)
    systemd.user.services.ironbar = {
      Unit = {
        Description = "Ironbar - GTK status bar for Wayland";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
        Requisite = [ "graphical-session.target" ];
      };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.ironbar}/bin/ironbar";
        Restart = "on-failure";
        RestartSec = 3;
        Environment = [
          "PATH=${lib.makeBinPath (with pkgs; [
            glib
            gtk3
            pango
            cairo
            gdk-pixbuf
            pulseaudio
            networkmanager
            upower
          ])}"
        ];
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };

  };
}
