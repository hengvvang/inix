{ config, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    # 流媒体下载工具
    (lib.mkIf (config.mySystem.services.media.players.enable && config.mySystem.services.media.players.streaming.download) {
      environment.systemPackages = with pkgs; [
        yt-dlp      # YouTube 和其他平台下载
        gallery-dl  # 图片和媒体下载
      ];
    })

    # 投屏工具
    (lib.mkIf (config.mySystem.services.media.players.enable && config.mySystem.services.media.players.streaming.cast) {
      environment.systemPackages = with pkgs; [
        gnome-network-displays  # 无线显示
        # miraclecast           # Miracast 支持
      ];
    })

    # 直播工具
    (lib.mkIf (config.mySystem.services.media.players.enable && config.mySystem.services.media.players.streaming.live) {
      environment.systemPackages = with pkgs; [
        obs-studio
        ffmpeg-full
      ];
    })
  ];
}
