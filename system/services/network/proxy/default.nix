{ config, lib, pkgs, ... }:

{
  imports = [
    ./clash
    ./clash-gui
    ./v2ray
    ./xray
    ./shadowsocks
    ./sing-box
  ];

  # 代理服务模块的选项定义
  options.mySystem.services.network.proxy = {
    enable = lib.mkEnableOption "代理服务支持";
  };
}
