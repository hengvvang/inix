{ config, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    # Spotify 音乐流媒体
    (lib.mkIf (config.mySystem.services.media.players.enable && config.mySystem.services.media.players.audio.spotify) {
      environment.systemPackages = with pkgs; [ spotify ];
    })

    # Audacious 音频播放器
    (lib.mkIf (config.mySystem.services.media.players.enable && config.mySystem.services.media.players.audio.audacious) {
      environment.systemPackages = with pkgs; [ audacious ];
    })

    # Rhythmbox 音乐管理器
    (lib.mkIf (config.mySystem.services.media.players.enable && config.mySystem.services.media.players.audio.rhythmbox) {
      environment.systemPackages = with pkgs; [ rhythmbox ];
    })
  ];
}
