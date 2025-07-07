{ config, lib, pkgs, ... }:

{
  options.mySystem.services = {
    enable = lib.mkEnableOption "系统服务支持";
  };

  imports = [
    ./docker
    ./network
    ./media
    ./drivers
  ];
}
