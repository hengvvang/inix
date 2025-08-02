{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.method == "external") {
    
    # Fuzzel 启动器配置
    xdg.configFile."fuzzel/fuzzel.ini".source = ./fuzzel.ini;
    
  };
}