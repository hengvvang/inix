{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.hyprland.method == "external") {
    
    # 应用启动器
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      theme = ./config.rasi;
    };
    
  };
}
