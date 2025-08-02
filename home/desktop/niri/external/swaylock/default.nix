{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.method == "external") {
    
    # Swaylock 配置
    xdg.configFile."swaylock/config".source = ./config;
    
  };
}