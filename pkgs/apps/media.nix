{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myPkgs.apps.media.enable {
    environment.systemPackages = with pkgs; [
      spotify         # Spotify 音乐
      obs-studio      # OBS Studio 录屏
    ];
  };
}
