{ config, lib, pkgs, ... }:

{
  options.myHome.services = {
    enable = lib.mkEnableOption "Home Manager 服务模块支持";
  };

  imports = [
    ./media
  ];
}
