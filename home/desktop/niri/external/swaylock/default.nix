{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.method == "external") {

    home.packages = with pkgs; [
      swaylock
    ];    

    # Swaylock 配置
    xdg.configFile."swaylock/config".source = ./config;
    
  };
}