{ config, lib, pkgs, ... }:

{
  options.mySystem.services.containers = {
    enable = lib.mkEnableOption "容器服务支持";
  };

  imports = [
    ./docker
    ./flatpak
    ./appimage
  ];
}

