{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.method == "external") {
    
    # Niri 核心配置
    xdg.configFile."niri/config.kdl".source = ./config.kdl;
    
  };
}