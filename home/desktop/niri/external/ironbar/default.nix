{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.method == "external") {

    home.file = {

      ".config/ironbar/config.toml" = {
        source = ./config.toml;
      };

      ".config/ironbar/style.css" = {
        source = ./style.css;
      };
    };

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
