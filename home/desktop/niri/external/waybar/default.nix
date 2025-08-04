{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.method == "external") {
    
    # Waybar 配置
    xdg.configFile = {
      "waybar/config".source = ./config;
      "waybar/style.css".source = ./style.css;
    };
    
    home.packages = with pkgs; [
      waybar 
    ];
  };
}