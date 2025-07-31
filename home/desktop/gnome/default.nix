{ config, lib, pkgs, ... }:

{
    options.myHome.desktop.gnome = {
        enable = lib.mkEnableOption "Gnome 桌面环境配置";
    };

    config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.gnome.enable ) {
        home.packages = with pkgs; [ alacritty ];
        
        home.file.".themes" = {
        source = ./assets/themes;
        executable = false;
        };
        home.file.".icons" = {
        source = ./assets/icons;
        executable = false;
        };
    };
}
