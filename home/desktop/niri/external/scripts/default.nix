{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.method == "external") {
    
    # 脚本文件
    xdg.configFile = {
      "niri/scripts/screenshot.sh" = {
        source = ./screenshot.sh;
        executable = true;
      };
      "niri/scripts/toggle-display.sh" = {
        source = ./toggle-display.sh;
        executable = true;
      };
      "niri/scripts/brightness.sh" = {
        source = ./brightness.sh;
        executable = true;
      };
      "niri/scripts/volume.sh" = {
        source = ./volume.sh;
        executable = true;
      };
      "niri/scripts/check-components.sh" = {
        source = ./check-components.sh;
        executable = true;
      };
      "niri/scripts/media.sh" = {
        source = ./media.sh;
        executable = true;
      };
    };
    
  };
}