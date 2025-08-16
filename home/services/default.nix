{ config, lib, pkgs, ... }:

{
  imports = [
    ./media
    ./proxy
  ];

  options.myHome.services = {
    enable = lib.mkEnableOption "Home Manager 服务模块支持";
  };
}
