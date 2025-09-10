{ config, lib, pkgs, ... }:

{
  imports = [
    ./docker
    ./flatpak
    ./appimage
  ];
  options.mySystem.services.containers = {
    enable = lib.mkEnableOption "容器服务支持";
  };
}
