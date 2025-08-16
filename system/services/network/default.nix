{ config, lib, pkgs, ... }:

{
  imports = [
    ./manager
    ./ssh
    ./proxy
    ./virtualInterface
  ];

  options.mySystem.services.network = {
    enable = lib.mkEnableOption "网络服务基础支持";
  };
}
