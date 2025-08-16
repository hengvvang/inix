{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.myHome.services.media.mpd;
in {
  config = mkIf cfg.enable {
    # 安装 MPD 及可选客户端
    home.packages = with pkgs; [
      mpd           # Music Player Daemon - 核心服务
    ] ++ optionals cfg.clients.mpc [ mpc-cli ]      # MPD 命令行客户端
      ++ optionals cfg.clients.rmpc [ rmpc ]; # 终端 MPD 客户端

    # MPD 用户级服务配置
    services.mpd = {
      enable = true;

      # 音乐目录 - 用户可配置
      musicDirectory = cfg.musicDirectory;

      # 网络配置 - 用户可配置端口
      network = {
        listenAddress = "127.0.0.1";
        port = cfg.port;
      };

      # 基础音频输出配置
      extraConfig = ''
        # PipeWire 音频输出
        audio_output {
            type        "pipewire"
            name        "PipeWire Output"
        }

        # 基础配置
        auto_update             "yes"
        mixer_type              "software"
      '';
    };

    # 创建音乐目录
    home.activation.createMusicDirectory = lib.hm.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD mkdir -p "${cfg.musicDirectory}"
    '';

    # 根据用户配置设置自动启动
    systemd.user.services.mpd = mkIf cfg.autoStart {
      Install.WantedBy = [ "default.target" ];
    };
  };
}
