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

  };
}
