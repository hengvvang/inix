{ config, lib, pkgs, ... }:

{
  imports = [
    ./mihomo
    ./v2raya
    ./v2ray
    ./xray
    ./shadowsocks
  ];

  options.mySystem.services.network.proxy = {
    enable = lib.mkEnableOption "代理服务支持";
  };

}
