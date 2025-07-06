{ config, lib, pkgs, ... }:

{
  # 媒体播放器模块的选项定义
  options.mySystem.services.media.players = {
    enable = lib.mkEnableOption "媒体播放器基础支持";
    
    # === 视频播放器选项 ===
    video = {
      mpv = lib.mkEnableOption "MPV 视频播放器" // { default = true; };
      vlc = lib.mkEnableOption "VLC 多媒体播放器";
      mplayer = lib.mkEnableOption "MPlayer 经典播放器";
    };
    
    # === 音频播放器选项 ===
    audio = {
      spotify = lib.mkEnableOption "Spotify 音乐流媒体";
      audacious = lib.mkEnableOption "Audacious 音频播放器";
      rhythmbox = lib.mkEnableOption "Rhythmbox 音乐管理器";
    };
    
    # === 编解码器选项 ===
    codecs = {
      ffmpeg = lib.mkEnableOption "FFmpeg 多媒体框架" // { default = true; };
      gstreamer = lib.mkEnableOption "GStreamer 多媒体框架";
      proprietary = lib.mkEnableOption "专有编解码器支持";
    };
    
    # === 流媒体工具选项 ===
    streaming = {
      download = lib.mkEnableOption "流媒体下载工具 (yt-dlp)";
      cast = lib.mkEnableOption "投屏工具";
      live = lib.mkEnableOption "直播工具";
    };
    
    # === 高级配置选项 ===
    advanced = {
      hwAccel = lib.mkEnableOption "硬件加速支持" // { default = true; };
      hdr = lib.mkEnableOption "HDR 视频支持";
      subtitles = lib.mkEnableOption "字幕支持增强";
    };
  };

  imports = [
    # === 模块化导入：每个功能独立文件 ===
    ./video.nix       # 视频播放器
    ./audio.nix       # 音频播放器
    ./codecs.nix      # 编解码器
    ./streaming.nix   # 流媒体工具
    ./advanced.nix    # 高级配置
  ];
}
