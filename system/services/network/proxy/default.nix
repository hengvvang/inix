{ config, lib, pkgs, ... }:

{
  options.mySystem.services.network.proxy = {
    enable = lib.mkEnableOption "代理服务支持";
  };

  imports = [
    ./mihomo
  ];

}
