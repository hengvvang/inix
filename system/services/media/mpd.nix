# MPD (Music Player Daemon) 服务配置
{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.media.mpd;
in
{
  config = lib.mkIf cfg.enable {
    # 安装 MPD 和相关工具
    environment.systemPackages = with pkgs; [
      mpd           # Music Player Daemon
      mpc-cli       # MPD 命令行客户端
      ncmpcpp       # NCurses MPD 客户端（可选的图形化客户端）
      
      # MPD 管理脚本
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
            echo "MPD 服务状态:"
            sudo systemctl status mpd
            ;;
          update)
            echo "更新 MPD 数据库..."
            mpc update
            ;;
          rescan)
            echo "重新扫描 MPD 数据库..."
            mpc rescan
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
            echo "配置文件: /etc/mpd.conf"
            ;;
          edit-config)
            echo "编辑 MPD 配置文件..."
            sudo nano /etc/mpd.conf
            ;;
          logs)
            echo "查看 MPD 日志..."
            sudo journalctl -u mpd -f
            ;;
          test-audio)
            echo "测试音频输出..."
            if command -v speaker-test >/dev/null 2>&1; then
              speaker-test -t sine -f 1000 -l 1
            else
              echo "请安装 alsa-utils 包来测试音频"
            fi
            ;;
          *)
            echo "用法: mpd-ctl {start|stop|restart|status|update|rescan|config|edit-config|logs|test-audio}"
            echo ""
            echo "命令说明:"
            echo "  start       - 启动 MPD 服务"
            echo "  stop        - 停止 MPD 服务"
            echo "  restart     - 重启 MPD 服务"
            echo "  status      - 显示 MPD 服务状态"
            echo "  update      - 更新音乐数据库（增量）"
            echo "  rescan      - 重新扫描音乐数据库（完整）"
            echo "  config      - 显示配置信息"
            echo "  edit-config - 编辑配置文件"
            echo "  logs        - 查看实时日志"
            echo "  test-audio  - 测试音频输出"
            exit 1
            ;;
        esac
      '')
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
  };
}
