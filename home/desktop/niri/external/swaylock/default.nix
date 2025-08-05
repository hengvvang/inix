{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.method == "external") {

    home.packages = with pkgs; [
      swaylock
      lxgw-wenkai         # 霞鹜文楷
    ];    

    # Swaylock 配置
    xdg.configFile."swaylock/config".source = ./config;
    
  };
}