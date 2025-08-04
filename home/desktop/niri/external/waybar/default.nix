{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.method == "external") {
    
    # Waybar 配置 - 玻璃主题
    xdg.configFile = {
      "waybar/config".source = ./glass-theme/config;
      "waybar/style.css".source = ./glass-theme/style.css;
    };
    
    home.packages = with pkgs; [
      waybar 
    ];
  };
}