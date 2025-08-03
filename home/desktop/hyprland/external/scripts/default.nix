{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.method == "external") {
    
    # 脚本文件
    xdg.configFile = {
      "hypr/scripts/wallpaper.sh" = {
        source = ./wallpaper.sh;
        executable = true;
      };
    };
    
  };
}
