# MPD (Music Player Daemon) 系统服务配置
{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.media.mpd;
in
{
  config = lib.mkIf cfg.enable {
    # 安装 MPD 和管理工具
    environment.systemPackages = with pkgs; [
      mpd           # Music Player Daemon
      mpc-cli       # MPD 命令行客户端
      
      # MPD 系统管理脚本
      (writeShellScriptBin "mpd-admin" ''
        #!/usr/bin/env bash
        
        case "$1" in
          start)
            echo "启动 MPD 系统服务..."
            sudo systemctl start mpd
            ;;
          stop)
            echo "停止 MPD 系统服务..."
            sudo systemctl stop mpd
            ;;
          restart)
            echo "重启 MPD 系统服务..."
            sudo systemctl restart mpd
            ;;
          status)
            echo "MPD 系统服务状态:"
            sudo systemctl status mpd
            ;;
          enable)
            echo "启用 MPD 系统服务自启动..."
            sudo systemctl enable mpd
            ;;
          disable)
            echo "禁用 MPD 系统服务自启动..."
            sudo systemctl disable mpd
            ;;
          update)
            echo "更新 MPD 音乐数据库..."
            mpc update
            ;;
          rescan)
            echo "完全重新扫描 MPD 数据库..."
            mpc rescan
            ;;
          config)
            echo "MPD 系统服务配置信息:"
            echo "服务端口: ${toString cfg.port}"
            echo "音乐目录: ${cfg.musicDirectory}"
            echo "数据目录: ${cfg.dataDir}"
            echo "运行用户: ${cfg.user}:${cfg.group}"
            ${lib.optionalString (cfg.httpPort != null) ''
            echo "HTTP 流端口: ${toString cfg.httpPort}"
            echo "HTTP 流地址: http://localhost:${toString cfg.httpPort}"
            ''}
            echo "配置文件: /etc/mpd.conf"
            ;;
          logs)
            echo "查看 MPD 系统服务日志..."
            sudo journalctl -u mpd -f
            ;;
          test-connection)
            echo "测试 MPD 连接..."
            if mpc status >/dev/null 2>&1; then
              echo "✓ MPD 连接正常"
              mpc version
            else
              echo "✗ 无法连接到 MPD"
              echo "请检查服务是否运行: systemctl status mpd"
            fi
            ;;
          stats)
            echo "MPD 音乐库统计:"
            mpc stats
            ;;
          *)
            echo "MPD 系统服务管理工具"
            echo "用法: mpd-admin {start|stop|restart|status|enable|disable|update|rescan|config|logs|test-connection|stats}"
            echo ""
            echo "服务管理:"
            echo "  start         - 启动服务"
            echo "  stop          - 停止服务"
            echo "  restart       - 重启服务"
            echo "  status        - 查看服务状态"
            echo "  enable        - 启用开机自启"
            echo "  disable       - 禁用开机自启"
            echo ""
            echo "数据库管理:"
            echo "  update        - 更新音乐数据库"
            echo "  rescan        - 完全重扫数据库"
            echo "  stats         - 显示音乐库统计"
            echo ""
            echo "诊断工具:"
            echo "  config        - 显示配置信息"
            echo "  logs          - 查看实时日志"
            echo "  test-connection - 测试连接"
            exit 1
            ;;
        esac
      '')
    ];

    # 创建 MPD 系统用户和组
    users.users.mpd = lib.mkIf (cfg.user == "mpd") {
      isSystemUser = true;
      group = cfg.group;
      description = "Music Player Daemon 系统用户";
      home = cfg.dataDir;
      createHome = true;
      extraGroups = [ "audio" ] ++ lib.optional cfg.enablePulseaudio "pulse-access";
    };

    users.groups.mpd = lib.mkIf (cfg.group == "mpd") {};

    # 确保目录存在且权限正确
    systemd.tmpfiles.rules = [
      "d ${cfg.musicDirectory} 0755 ${cfg.user} ${cfg.group} - -"
      "d ${cfg.dataDir} 0755 ${cfg.user} ${cfg.group} - -"
      "d ${cfg.dataDir}/playlists 0755 ${cfg.user} ${cfg.group} - -"
    ] ++ lib.optional cfg.enableFileOutput [
      "f ${cfg.fifoPath} 0644 ${cfg.user} ${cfg.group} - -"
    ];

    # MPD 系统服务配置
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
        # 数据文件配置
        db_file         "${cfg.dataDir}/database"
        log_file        "${cfg.dataDir}/log"
        pid_file        "${cfg.dataDir}/pid"
        state_file      "${cfg.dataDir}/state"
        sticker_file    "${cfg.dataDir}/sticker.sql"
        playlist_directory "${cfg.dataDir}/playlists"
        
        # 音频输出配置
        ${lib.optionalString cfg.enablePulseaudio ''
        audio_output {
            type        "pulse"
            name        "PulseAudio/PipeWire Output"
            server      "unix:/run/user/1000/pulse/native"
        }
        ''}
        
        ${lib.optionalString cfg.enableAlsa ''
        audio_output {
            type        "alsa"
            name        "ALSA Output"
            device      "hw:0,0"
            mixer_type  "hardware"
            mixer_device "default"
            mixer_control "Master"
        }
        ''}
        
        ${lib.optionalString (cfg.httpPort != null) ''
        audio_output {
            type        "httpd"
            name        "HTTP 音频流"
            encoder     "lame"
            port        "${toString cfg.httpPort}"
            bitrate     "192"
            format      "44100:16:2"
            always_on   "yes"
            tags        "yes"
        }
        ''}
        
        ${lib.optionalString cfg.enableFileOutput ''
        audio_output {
            type        "fifo"
            name        "FIFO Output (用于可视化)"
            path        "${cfg.fifoPath}"
            format      "44100:16:2"
        }
        ''}
        
        # 输入插件
        input {
            plugin "curl"
        }
        
        # 解码器配置
        decoder {
            plugin      "mad"
            enabled     "yes"
        }
        
        decoder {
            plugin      "vorbis" 
            enabled     "yes"
        }
        
        decoder {
            plugin      "flac"
            enabled     "yes"
        }
        
        decoder {
            plugin      "ffmpeg"
            enabled     "yes"
        }
        
        # 音频设置
        filesystem_charset      "UTF-8"
        metadata_to_use         "artist,album,title,track,name,genre,date,composer,performer,disc,albumartist"
        auto_update             "yes"
        auto_update_depth       "4"
        follow_outside_symlinks "yes"
        follow_inside_symlinks  "yes"
        
        # 混音器和音量控制
        mixer_type              "software"
        
        # 重播增益
        replaygain              "auto"
        replaygain_preamp       "0"
        replaygain_missing_preamp "0"
        replaygain_limit        "yes"
        
        # 连接设置
        connection_timeout      "60"
        max_connections         "10"
        max_playlist_length     "16384"
        max_command_list_size   "2048"
        max_output_buffer_size  "8192"
        
        # 日志级别
        log_level               "notice"
      '';
    };

    # 防火墙配置
    networking.firewall = {
      allowedTCPPorts = [ cfg.port ] ++ lib.optional (cfg.httpPort != null) cfg.httpPort;
    };

    # 音频系统权限
    security.rtkit.enable = lib.mkIf cfg.enablePulseaudio true;
    
    # 确保必要的音频服务运行
    systemd.user.services = lib.mkIf cfg.enablePulseaudio {
      pulseaudio.wantedBy = lib.mkForce [];  # 使用 PipeWire 代替
    };
  };
}
