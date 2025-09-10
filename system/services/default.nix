{ config, lib, pkgs, ... }:

{
  imports = [
    ./containers
    ./network
    ./media
    ./drivers
  ];

  options.mySystem.services = {
    enable = lib.mkEnableOption "系统服务支持";
  };
}
