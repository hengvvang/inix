{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.services.media.enable && config.mySystem.services.media.players.enable) {
    environment.systemPackages = with pkgs; [
      # 基础播放器
      mpv
      vlc
      
      # 音乐播放器
      spotify
      audacious
      
      # 专业播放器
      mplayer
      ffmpeg-full
      
      # 流媒体工具
      youtube-dl
      yt-dlp
    ];
    
    # MPV 配置
    environment.etc = lib.mkIf config.mySystem.services.media.players.enable {
      "mpv/mpv.conf".text = ''
        hwdec=auto
        vo=gpu
        profile=gpu-hq
        scale=ewa_lanczossharp
        cscale=ewa_lanczossharp
      '';
    };
  };
}