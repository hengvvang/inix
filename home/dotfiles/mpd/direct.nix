# MPD 直接配置方式
{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.mpd.enable && 
                     config.myHome.dotfiles.mpd.method == "direct") {
    
    # 直接创建 MPD 配置文件
    home.file.".config/mpd/mpd.conf".text = ''
      # MPD 配置文件 - 直接配置方式
      # Music Player Daemon Configuration
      
      # 目录配置
      music_directory    "${config.home.homeDirectory}/Music"
      playlist_directory "${config.home.homeDirectory}/.config/mpd/playlists"
      db_file            "${config.home.homeDirectory}/.config/mpd/database"
      log_file           "${config.home.homeDirectory}/.config/mpd/log"
      pid_file           "${config.home.homeDirectory}/.config/mpd/pid"
      state_file         "${config.home.homeDirectory}/.config/mpd/state"
      sticker_file       "${config.home.homeDirectory}/.config/mpd/sticker.sql"
      
      # 网络配置
      bind_to_address "localhost"
      port "6600"
      
      # 用户配置
      user "${config.home.username}"
      
      # 音频输出配置
      audio_output {
        type        "pipewire"
        name        "PipeWire Output"
      }
      
      audio_output {
        type        "pulse"
        name        "PulseAudio Output"
      }
      
      # HTTP 流输出
      audio_output {
        type        "httpd"
        name        "HTTP Stream"
        encoder     "lame"
        port        "8000"
        bitrate     "192"
        format      "44100:16:2"
        always_on   "yes"
        tags        "yes"
      }
      
      # 文件系统配置
      filesystem_charset "UTF-8"
      
      # 元数据配置
      metadata_to_use "artist,album,title,track,name,genre,date,composer,performer,disc,albumartist"
      
      # 自动更新
      auto_update "yes"
      auto_update_depth "3"
      
      # 符号链接
      follow_outside_symlinks "yes"
      follow_inside_symlinks "yes"
      
      # 混音器
      mixer_type "software"
      
      # 重播增益
      replaygain "auto"
      replaygain_preamp "0"
      replaygain_missing_preamp "0"
      replaygain_limit "yes"
      
      # 日志级别
      log_level "notice"
      
      # 输入插件
      input {
        plugin "curl"
      }
      
      # 解码器插件
      decoder {
        plugin "mad"
        enabled "yes"
      }
      
      decoder {
        plugin "vorbis"
        enabled "yes"
      }
      
      decoder {
        plugin "flac"
        enabled "yes"
      }
      
      decoder {
        plugin "ffmpeg"
        enabled "yes"
      }
    '';

    # 创建必要的目录
    home.file.".config/mpd/playlists/.keep".text = "";
    
    # 创建启动脚本
    home.file.".local/bin/mpd-direct" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        # MPD 直接启动脚本
        
        MPD_CONFIG="${config.home.homeDirectory}/.config/mpd/mpd.conf"
        MPD_DIR="${config.home.homeDirectory}/.config/mpd"
        
        # 创建必要目录
        mkdir -p "$MPD_DIR/playlists"
        mkdir -p "${config.home.homeDirectory}/Music"
        
        # 启动 MPD
        ${pkgs.mpd}/bin/mpd --no-daemon "$MPD_CONFIG"
      '';
    };

    # 安装相关包
    home.packages = with pkgs; [
      mpd
      mpc-cli
      ncmpcpp
    ];
  };
}
