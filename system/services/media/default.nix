{ config, lib, pkgs, ... }:

{
  options.mySystem.services.media = {
    # 音视频播放
    players = {
      enable = lib.mkEnableOption "多媒体播放器";
      mpv = lib.mkEnableOption "MPV 视频播放器增强配置";
      vlc = lib.mkEnableOption "VLC 媒体播放器";
      music = lib.mkEnableOption "音乐播放器 (Spotify, 网易云等)";
    };
    
    # 媒体编辑
    editing = {
      enable = lib.mkEnableOption "媒体编辑工具";
      video = lib.mkEnableOption "视频编辑工具";
      audio = lib.mkEnableOption "音频编辑工具";
      image = lib.mkEnableOption "图像编辑工具";
    };
    
    # 流媒体服务 (轻量级个人使用)
    streaming = {
      jellyfin = {
        enable = lib.mkEnableOption "Jellyfin 个人媒体服务器";
        hardware = lib.mkEnableOption "硬件加速支持";
        plugins = lib.mkEnableOption "常用插件";
      };
      dlna = lib.mkEnableOption "DLNA 媒体共享";
    };
    
    # 下载工具
    download = {
      enable = lib.mkEnableOption "媒体下载工具";
      youtube = lib.mkEnableOption "YouTube 下载工具";
      torrent = lib.mkEnableOption "BitTorrent 客户端";
      aria2 = lib.mkEnableOption "Aria2 下载管理器";
    };
  };

  imports = [
    ./players.nix
    ./editing.nix
    ./streaming.nix
    ./download.nix
  ];
}
