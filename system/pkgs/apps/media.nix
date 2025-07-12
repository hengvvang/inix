{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.pkgs.apps.media.enable {
    environment.systemPackages = with pkgs; [
      # spotify         # Spotify 音乐
      # obs-studio      # OBS Studio 录屏
    ];
  };
}
