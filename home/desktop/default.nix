{ config, lib, pkgs, ... }:

{
    options.myHome.desktop = {
        enable = lib.mkEnableOption "桌面环境配置";
    };

    imports = [
        # ./cosmic
        ./gnome
        # ./kde
        ./hyprland
        # ./niri
    ];
}
