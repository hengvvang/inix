{ config, lib, pkgs, ... }:

{
  # AppImage 配置选项
  options.mySystem.services.containers.appimage = {
    enable = lib.mkEnableOption "AppImage 应用支持";
  };

  imports = [
    ./appimage.nix
  ];
}
