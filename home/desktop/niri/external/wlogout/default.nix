{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.method == "external") {

    home.packages = with pkgs; [
      wlogout
    ];
    
    # Wlogout 退出菜单配置 - 简约风格
    xdg.configFile = {
      "wlogout/layout".source = ./layout;
      "wlogout/style.css".source = ./style.css;
    };
    
  };
}
