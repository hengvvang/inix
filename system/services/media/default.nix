{ config, lib, pkgs, ... }:

{
  options.mySystem.services.media = {
    jellyfin.enable = lib.mkEnableOption "Jellyfin 媒体服务器";
    transmission.enable = lib.mkEnableOption "Transmission BitTorrent 客户端";
  };

  imports = [
    ./jellyfin
    ./transmission
  ];
}
