# MPD (Music Player Daemon) 服务配置
{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.media.mpd;
in
{
  options.mySystem.services.media.mpd = {
    enable = lib.mkEnableOption "MPD 音乐播放器守护进程";
    
    musicDirectory = lib.mkOption {
      type = lib.types.str;
      default = "/home/music";
      description = "音乐文件目录路径";
    };
    
    dataDir = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/mpd";
      description = "MPD 数据目录";
    };
    
    port = lib.mkOption {
      type = lib.types.int;
      default = 6600;
      description = "MPD 服务端口";
    };
    
    httpPort = lib.mkOption {
      type = lib.types.nullOr lib.types.int;
      default = 8000;
      description = "HTTP 音频流端口，设为 null 禁用";
    };
    
    user = lib.mkOption {
      type = lib.types.str;
      default = "mpd";
      description = "MPD 运行用户";
    };
    
    group = lib.mkOption {
      type = lib.types.str;
      default = "mpd";
      description = "MPD 运行用户组";
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
  };

  config = lib.mkIf cfg.enable {
    # 安装 MPD 和相关工具
    environment.systemPackages = with pkgs; [
      mpd           # Music Player Daemon
      mpc-cli       # MPD 命令行客户端
      ncmpcpp       # NCurses MPD 客户端（可选的图形化客户端）
    ];

    # 创建 MPD 用户和组
    users.users.mpd = lib.mkIf (cfg.user == "mpd") {
      isSystemUser = true;
      group = cfg.group;
      description = "Music Player Daemon user";
      home = cfg.dataDir;
      createHome = true;
      extraGroups = [ "audio" ] ++ lib.optional cfg.enablePulseaudio "pulse-access";
    };

    users.groups.mpd = lib.mkIf (cfg.group == "mpd") {};

    # 确保音乐目录存在且有正确权限
    systemd.tmpfiles.rules = [
      "d ${cfg.musicDirectory} 0755 ${cfg.user} ${cfg.group} -"
      "d ${cfg.dataDir} 0755 ${cfg.user} ${cfg.group} -"
      "d ${cfg.dataDir}/playlists 0755 ${cfg.user} ${cfg.group} -"
    ];

    # MPD 服务配置
    services.mpd = {
      enable = true;
      user = cfg.user;
      group = cfg.group;
      dataDir = cfg.dataDir;
      musicDirectory = cfg.musicDirectory;
      
      network = {
        listenAddress = "127.0.0.1";
        port = cfg.port;
      };
      
      extraConfig = ''
        # 数据库配置
        db_file         "${cfg.dataDir}/database"
        log_file        "${cfg.dataDir}/log"
        pid_file        "${cfg.dataDir}/pid"
        state_file      "${cfg.dataDir}/state"
        sticker_file    "${cfg.dataDir}/sticker.sql"
        
        # 播放列表目录
        playlist_directory "${cfg.dataDir}/playlists"
        
        # 音频输出配置
        ${lib.optionalString cfg.enablePulseaudio ''
        audio_output {
            type        "pulse"
            name        "PulseAudio Output"
            server      "unix:/run/user/%i/pulse/native"
        }
        ''}
        
        ${lib.optionalString cfg.enableAlsa ''
        audio_output {
            type        "alsa"
            name        "ALSA Output"
            device      "hw:0,0"
        }
        ''}
        
        ${lib.optionalString (cfg.httpPort != null) ''
        audio_output {
            type        "httpd"
            name        "HTTP Audio Stream"
            encoder     "lame"
            port        "${toString cfg.httpPort}"
            bitrate     "128"
            format      "44100:16:2"
            always_on   "yes"
            tags        "yes"
        }
        ''}
        
        # 输入插件
        input {
            plugin "curl"
        }
        
        # 解码器插件
        decoder {
            plugin                  "mad"
            enabled                 "yes"
        }
        
        decoder {
            plugin                  "vorbis"
            enabled                 "yes"
        }
        
        decoder {
            plugin                  "flac"
            enabled                 "yes"
        }
        
        # 重采样配置
        resampler {
            plugin                  "libsamplerate"
            type                    "Best Sinc Interpolator"
        }
        
        # 其他配置
        filesystem_charset      "UTF-8"
        metadata_to_use         "artist,album,title,track,name,genre,date,composer,performer,disc"
        auto_update             "yes"
        auto_update_depth       "3"
        follow_outside_symlinks "yes"
        follow_inside_symlinks  "yes"
      '';
    };

    # 防火墙配置
    networking.firewall = {
      allowedTCPPorts = [ cfg.port ] ++ lib.optional (cfg.httpPort != null) cfg.httpPort;
    };

    # PulseAudio/PipeWire 访问权限
    security.rtkit.enable = lib.mkIf cfg.enablePulseaudio true;

    # 创建便于管理的脚本
    environment.systemPackages = with pkgs; [
      (writeShellScriptBin "mpd-ctl" ''
        #!/usr/bin/env bash
        
        case "$1" in
          start)
            echo "启动 MPD 服务..."
            sudo systemctl start mpd
            ;;
          stop)
            echo "停止 MPD 服务..."
            sudo systemctl stop mpd
            ;;
          restart)
            echo "重启 MPD 服务..."
            sudo systemctl restart mpd
            ;;
          status)
            systemctl status mpd
            ;;
          logs)
            journalctl -u mpd -f
            ;;
          update)
            echo "更新音乐数据库..."
            ${mpc-cli}/bin/mpc update
            ;;
          stats)
            echo "MPD 统计信息:"
            ${mpc-cli}/bin/mpc stats
            ;;
          current)
            echo "当前播放:"
            ${mpc-cli}/bin/mpc current
            ;;
          config)
            echo "MPD 配置信息:"
            echo "服务端口: ${toString cfg.port}"
            echo "音乐目录: ${cfg.musicDirectory}"
            echo "数据目录: ${cfg.dataDir}"
            ${lib.optionalString (cfg.httpPort != null) ''
            echo "HTTP 流端口: ${toString cfg.httpPort}"
            echo "HTTP 流地址: http://localhost:${toString cfg.httpPort}"
            ''}
            ;;
          clients)
            echo "推荐的 MPD 客户端:"
            echo "  rmpc       - 现代化 Rust MPD 客户端 (已安装)"
            echo "  ncmpcpp    - NCurses 客户端 (已安装)"
            echo "  mpc        - 命令行客户端 (已安装)"
            ;;
          *)
            echo "用法: mpd-ctl {start|stop|restart|status|logs|update|stats|current|config|clients}"
            echo ""
            echo "命令说明:"
            echo "  start    - 启动 MPD 服务"
            echo "  stop     - 停止 MPD 服务"
            echo "  restart  - 重启 MPD 服务"
            echo "  status   - 查看服务状态"
            echo "  logs     - 查看实时日志"
            echo "  update   - 更新音乐数据库"
            echo "  stats    - 显示 MPD 统计信息"
            echo "  current  - 显示当前播放歌曲"
            echo "  config   - 显示配置信息"
            echo "  clients  - 显示推荐客户端"
            ;;
        esac
      '')
    ];
  };
}
