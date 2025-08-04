{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.method == "external") {

    home.packages = with pkgs; [
      waybar
    ];
    
    # 状态栏程序配置
    programs.waybar.enable = true;
    
    # Waybar 配置文件
    xdg.configFile = {
      "waybar/config".source = ./config;
      "waybar/style.css".source = ./style.css;
    };
    
  };
}
