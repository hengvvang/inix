{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.method == "external") {
    
    # Swappy 截图编辑器配置
    xdg.configFile."swappy/config".source = ./config;
    
  };
}
