{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.method == "external") {
    
    # 通知服务
    services.dunst.enable = true;
    
    # Dunst 配置文件
    xdg.configFile."dunst/dunstrc".source = ./dunstrc;
    
  };
}
