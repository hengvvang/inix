{ config, lib, pkgs, ... }:

{
  options.mySystem.desktop = {
    cosmic = lib.mkEnableOption "COSMIC 桌面环境";
    plasma = lib.mkEnableOption "KDE Plasma 桌面环境";
    gnome = lib.mkEnableOption "GNOME 桌面环境";
  };

  imports = [
    ./cosmic.nix
    ./gnome.nix
    ./plasma.nix
  ];
}