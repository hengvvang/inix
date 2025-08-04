{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.method == "external") {

    home.packages = with pkgs; [
      wlogout
    ];
    
    # Wlogout 退出菜单配置
    xdg.configFile = {
      "wlogout/layout".source = ./layout;
      "wlogout/style.css".source = ./style.css;
    };
    
  };
}
