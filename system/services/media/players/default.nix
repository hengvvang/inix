{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.media.players.enable {
    # 媒体播放器 - 原子化配置
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
      
      # 流媒体工具 (使用安全的替代品)
      yt-dlp  # 替代 youtube-dl
    ];
    
    # MPV 配置
    environment.etc = {
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
