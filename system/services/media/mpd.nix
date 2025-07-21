# MPD (Music Player Daemon) 系统服务配置模块
# 简化配置，保持完备性

{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.media.mpd;
in
{
  config = lib.mkIf cfg.enable {
    # MPD 核心软件包
    environment.systemPackages = with pkgs; [
      mpd           # Music Player Daemon 核心服务
      mpc-cli       # MPD 命令行客户端工具
    ];

    # 系统目录和权限管理
    systemd.tmpfiles.rules = [
      "d ${cfg.musicDirectory} 0755 ${cfg.user} ${cfg.group} - -"
      "d ${cfg.dataDir} 0755 ${cfg.user} ${cfg.group} - -"
      "d ${cfg.dataDir}/playlists 0755 ${cfg.user} ${cfg.group} - -"
    ] ++ lib.optionals cfg.enableFileOutput [
      "f ${cfg.fifoPath} 0644 ${cfg.user} ${cfg.group} - -"
    ];

    # MPD 核心服务配置
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
        state_file      "${cfg.dataDir}/state"
        sticker_file    "${cfg.dataDir}/sticker.sql"
        playlist_directory "${cfg.dataDir}/playlists"
        
        # 音频输出配置
        ${lib.optionalString cfg.enablePulseaudio ''
        audio_output {
            type        "pulse"
            name        "PulseAudio Output"
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
            name        "HTTP Stream"
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
            name        "FIFO Output"
            path        "${cfg.fifoPath}"
            format      "44100:16:2"
        }
        ''}
        
        # 输入和解码器配置
        input {
            plugin "curl"
        }
        
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
        
        # 基础配置
        filesystem_charset      "UTF-8"
        metadata_to_use         "artist,album,title,track,name,genre,date,composer,performer,disc,albumartist"
        auto_update             "yes"
        auto_update_depth       "4"
        follow_outside_symlinks "yes"
        follow_inside_symlinks  "yes"
        mixer_type              "software"
        
        # 重播增益配置
        replaygain              "auto"
        replaygain_preamp       "0"
        replaygain_missing_preamp "0"
        replaygain_limit        "yes"
        
        # 网络和性能配置
        connection_timeout      "60"
        max_connections         "10"
        max_playlist_length     "16384"
        max_command_list_size   "2048"
        max_output_buffer_size  "8192"
        log_level               "notice"
      '';
    };

    # 网络防火墙配置
    networking.firewall = {
      allowedTCPPorts = [ 
        cfg.port
      ] ++ lib.optional (cfg.httpPort != null) cfg.httpPort;
    };

    # 音频系统集成
    security.rtkit.enable = lib.mkIf cfg.enablePulseaudio true;
    
    systemd.user.services = lib.mkIf cfg.enablePulseaudio {
      pulseaudio.wantedBy = lib.mkForce [];
    };
  };
}