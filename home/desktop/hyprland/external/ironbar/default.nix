{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.method == "external") {
    
    # Ironbar 配置文件
    xdg.configFile = {
      "ironbar/config.toml".source = ./config.toml;
      "ironbar/style.css".source = ./style.css;
    };
    
  };
}
