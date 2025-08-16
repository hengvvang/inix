{ config, lib, pkgs, ... }:

{
  imports = [
    ./appimage.nix
  ];

  options.mySystem.services.containers.appimage = {
    enable = lib.mkEnableOption "AppImage 应用支持";
  };
}
