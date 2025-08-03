{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.method == "external") {
    
    # 脚本文件
    xdg.configFile = {
      "niri/scripts/wallpaper.sh" = {
        source = ./wallpaper.sh;
        executable = true;
      };
    };
    
  };
}