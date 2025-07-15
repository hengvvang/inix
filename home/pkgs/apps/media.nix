{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.pkgs.apps.media.enable {
    home.packages = with pkgs; [
      #spotify         # Spotify 音乐
      #obs-studio      # OBS Studio 录屏
    ];
  };
}
