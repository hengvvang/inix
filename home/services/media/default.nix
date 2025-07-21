
{ config, lib, pkgs, ... }:

{
  options.myHome.services.media = {

    enable = lib.mkEnableOption "家庭媒体服务模块";
    
    mpd = {
      enable = lib.mkEnableOption "MPD 音乐播放器服务";
    };

  };

  imports = [
    ./mpd.nix
  ];
}
