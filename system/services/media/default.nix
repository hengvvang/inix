{ config, lib, pkgs, ... }:

{
  imports = [
    ./media.nix
    ./mpd.nix
  ];
  # 媒体服务模块 - 简化版
  options.mySystem.services.media = {
    enable = lib.mkEnableOption "媒体服务支持";

    # 视频播放器
    video = {
      enable = lib.mkEnableOption "视频播放器" // { default = true; };
      mpv = lib.mkEnableOption "MPV 播放器" // { default = true; };
      vlc = lib.mkEnableOption "VLC 播放器";
    };

    # 音频播放器
    audio = {
      enable = lib.mkEnableOption "音频播放器" // { default = true; };
      spotify = lib.mkEnableOption "Spotify";
    };

    # 编解码器
    codecs = {
      enable = lib.mkEnableOption "编解码器支持" // { default = true; };
      ffmpeg = lib.mkEnableOption "FFmpeg" // { default = true; };
      gstreamer = lib.mkEnableOption "GStreamer";
    };

    # 流媒体工具
    streaming = {
      enable = lib.mkEnableOption "流媒体工具";
      download = lib.mkEnableOption "yt-dlp 下载工具" // { default = true; };
    };

    # MPD 音乐播放器守护进程
    mpd = {
      enable = lib.mkEnableOption "MPD 音乐播放器守护进程";

      musicDirectory = lib.mkOption {
        type = lib.types.str;
        default = "/srv/music";
        description = "音乐文件目录路径";
      };

      dataDir = lib.mkOption {
        type = lib.types.str;
        default = "/var/lib/mpd";
        description = "MPD 数据目录";
      };

      user = lib.mkOption {
        type = lib.types.str;
        default = "mpd";
        description = "运行 MPD 的用户";
      };

      group = lib.mkOption {
        type = lib.types.str;
        default = "mpd";
        description = "运行 MPD 的用户组";
      };

      port = lib.mkOption {
        type = lib.types.port;
        default = 6600;
        description = "MPD 服务端口";
      };

      httpPort = lib.mkOption {
        type = lib.types.nullOr lib.types.port;
        default = 8000;
        description = "HTTP 音频流端口，设为 null 禁用";
      };

      enablePulseaudio = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "启用 PulseAudio/PipeWire 音频输出";
      };

      enableAlsa = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "启用 ALSA 音频输出";
      };

      enableFileOutput = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "启用文件输出 (FIFO) 用于可视化";
      };

      fifoPath = lib.mkOption {
        type = lib.types.str;
        default = "/tmp/mpd.fifo";
        description = "FIFO 输出文件路径";
      };
    };
  };
}
