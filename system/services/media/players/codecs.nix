{ config, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    # FFmpeg 多媒体框架
    (lib.mkIf (config.mySystem.services.media.players.enable && config.mySystem.services.media.players.codecs.ffmpeg) {
      environment.systemPackages = with pkgs; [ ffmpeg-full ];
    })

    # GStreamer 多媒体框架
    (lib.mkIf (config.mySystem.services.media.players.enable && config.mySystem.services.media.players.codecs.gstreamer) {
      environment.systemPackages = with pkgs; [
        gstreamer
        gst_all_1.gstreamer
        gst_all_1.gst-plugins-base
        gst_all_1.gst-plugins-good
        gst_all_1.gst-plugins-bad
        gst_all_1.gst-plugins-ugly
      ];
    })

    # 专有编解码器支持
    (lib.mkIf (config.mySystem.services.media.players.enable && config.mySystem.services.media.players.codecs.proprietary) {
      environment.systemPackages = with pkgs; [
        libdvdcss
        libdvdread
        libdvdnav
      ];
      
      # 启用专有编解码器
      nixpkgs.config.allowUnfree = true;
    })
  ];
}
