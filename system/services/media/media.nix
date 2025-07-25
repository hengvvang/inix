{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.media;
in
{
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; (
      # 视频播放器
      (lib.optionals (cfg.video.enable && cfg.video.mpv) [ mpv ]) ++
      (lib.optionals (cfg.video.enable && cfg.video.vlc) [ vlc ]) ++
      
      # 音频播放器
      (lib.optionals (cfg.audio.enable && cfg.audio.spotify) [ spotify ]) ++
      (lib.optionals (cfg.audio.enable && cfg.audio.audacious) [ audacious ]) ++
      
      # 编解码器
      (lib.optionals (cfg.codecs.enable && cfg.codecs.ffmpeg) [ ffmpeg-full ]) ++
      (lib.optionals (cfg.codecs.enable && cfg.codecs.gstreamer) [ 
        gstreamer
        gst_all_1.gstreamer
        gst_all_1.gst-plugins-base
        gst_all_1.gst-plugins-good
        gst_all_1.gst-plugins-bad
        gst_all_1.gst-plugins-ugly
      ]) ++
      
      # 流媒体工具
      (lib.optionals (cfg.streaming.enable && cfg.streaming.download) [ yt-dlp ])
    );

    # MPV 基础配置
    environment.etc."mpv/mpv.conf" = lib.mkIf (cfg.video.enable && cfg.video.mpv) {
      text = ''
        # 基础配置
        hwdec=auto
        vo=gpu
        profile=gpu-hq
        
        # 视频质量
        scale=ewa_lanczossharp
        cscale=ewa_lanczossharp
        
        # 字幕支持
        sub-auto=fuzzy
        sub-file-paths=ass:srt:sub:subs:subtitles
      '';
    };
  };
}
