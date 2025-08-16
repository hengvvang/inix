{ config, lib, pkgs, ... }:

{
  imports = [
    ./mihomo
    ./v2ray
  ];

  options.myHome.services.proxy = {
    enable = lib.mkEnableOption "Home Manager 服务模块支持";
    mihomo.enable = lib.mkEnableOption "mihomo 代理服务";
    v2ray.enable = lib.mkEnableOption "v2ray 代理服务";
  };
}
