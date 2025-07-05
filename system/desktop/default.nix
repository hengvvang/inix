{ config, lib, pkgs, ... }:

{
  options.mySystem.desktop = {
    cosmic = {
      enable = lib.mkEnableOption "COSMIC 桌面环境";
    };
    plasma = {
      enable = lib.mkEnableOption "KDE Plasma 桌面环境";
    };
    gnome = {
      enable = lib.mkEnableOption "GNOME 桌面环境";
    };
  };

  imports = [
    ./cosmic.nix
    ./gnome.nix
    ./plasma.nix
  ];
}