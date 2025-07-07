{ config, lib, pkgs, ... }:

{
  options.mySystem.desktop = {
    enable = lib.mkEnableOption "桌面环境支持";
    cosmic.enable = lib.mkEnableOption "COSMIC 桌面环境";
    plasma.enable = lib.mkEnableOption "KDE Plasma 桌面环境";
    gnome.enable = lib.mkEnableOption "GNOME 桌面环境";
  };

  imports = [
    ./cosmic.nix
    ./gnome.nix
    ./plasma.nix
  ];
}