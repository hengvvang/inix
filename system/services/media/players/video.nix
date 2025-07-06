{ config, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    # MPV 视频播放器
    (lib.mkIf (config.mySystem.services.media.players.enable && config.mySystem.services.media.players.video.mpv) {
      environment.systemPackages = with pkgs; [ mpv ];
      
      # MPV 配置
      environment.etc."mpv/mpv.conf".text = ''
        # 硬件解码
        hwdec=${if config.mySystem.services.media.players.advanced.hwAccel then "auto" else "no"}
        vo=gpu
        profile=gpu-hq
        
        # 视频质量
        scale=ewa_lanczossharp
        cscale=ewa_lanczossharp
        dscale=mitchell
        
        # HDR 支持
        ${lib.optionalString config.mySystem.services.media.players.advanced.hdr ''
          target-colorspace-hint=yes
          hdr-compute-peak=yes
        ''}
        
        # 字幕增强
        ${lib.optionalString config.mySystem.services.media.players.advanced.subtitles ''
          sub-auto=fuzzy
          sub-file-paths=ass:srt:sub:subs:subtitles
        ''}
      '';
    })

    # VLC 多媒体播放器
    (lib.mkIf (config.mySystem.services.media.players.enable && config.mySystem.services.media.players.video.vlc) {
      environment.systemPackages = with pkgs; [ vlc ];
    })

    # MPlayer 经典播放器
    (lib.mkIf (config.mySystem.services.media.players.enable && config.mySystem.services.media.players.video.mplayer) {
      environment.systemPackages = with pkgs; [ mplayer ];
    })
  ];
}
