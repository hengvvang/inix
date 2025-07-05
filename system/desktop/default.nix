{ config, lib, pkgs, ... }:

{
  options.mySystem.desktop.enable = lib.mkEnableOption "Desktop Environment";

  config = lib.mkIf config.mySystem.desktop.enable {
    mySystem.desktop = {
      cosmic.enable = lib.mkDefault false;
      plasma.enable = lib.mkDefault false;
      gnome.enable = lib.mkDefault false;
    };
  };

  imports = [
    ./cosmic.nix
    ./gnome.nix
    ./plasma.nix
  ];
}