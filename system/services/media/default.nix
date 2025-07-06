{ config, lib, pkgs, ... }:

{
  options.mySystem.services.media = {
    enable = lib.mkEnableOption "媒体服务";
    players.enable = lib.mkEnableOption "媒体播放器";
    editing.enable = lib.mkEnableOption "媒体编辑工具";
    streaming.enable = lib.mkEnableOption "流媒体工具";
    download.enable = lib.mkEnableOption "下载工具";
  };

  imports = [
    ./players.nix
    ./editing.nix
    ./streaming.nix
    ./download.nix
  ];
}
