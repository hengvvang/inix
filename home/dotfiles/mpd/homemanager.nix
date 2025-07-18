# 用户级 MPD 配置 (Home Manager)
{ config, lib, pkgs, ... }:

let
  cfg = config.myHome.dotfiles.mpd;
in
{
  config = lib.mkIf (config.myHome.dotfiles.enable && cfg.enable && cfg.method == "homemanager") {
    services.mpd = {
      enable = true;
      musicDirectory = config.home.homeDirectory + "/Music";
      
      extraConfig = ''
        # 音频输出配置
        audio_output {
          type        "pipewire"
          name        "PipeWire Output"
        }
        
        audio_output {
          type        "pulse"
          name        "PulseAudio Output"
        }
        
        # HTTP 音频流 (可选)
        audio_output {
          type        "httpd"
          name        "HTTP Audio Stream"
          encoder     "lame"
          port        "8000"
          bitrate     "192"
          format      "44100:16:2"
          always_on   "yes"
          tags        "yes"
        }
        
        # 文件输出 (用于录音等)
        audio_output {
          type        "fifo"
          name        "FIFO Output"
          path        "/tmp/mpd.fifo"
          format      "44100:16:2"
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
        
        # 输入配置
        input {
          plugin      "curl"
        }
        
        # 其他设置
        filesystem_charset      "UTF-8"
        metadata_to_use         "artist,album,title,track,name,genre,date,composer,performer,disc,albumartist"
        auto_update             "yes"
        auto_update_depth       "4"
        follow_outside_symlinks "yes"
        follow_inside_symlinks  "yes"
        
        # 混音器配置
        mixer_type              "software"
        
        # 重播增益
        replaygain              "auto"
        replaygain_preamp       "0"
        replaygain_missing_preamp "0"
        replaygain_limit        "yes"
        
        # 网络配置
        bind_to_address         "localhost"
        port                    "6600"
        
        # 日志级别
        log_level               "notice"
      '';
    };

    # 安装相关的音乐客户端工具
    home.packages = with pkgs; [
      # MPD 客户端
      mpc-cli       # 命令行客户端
      ncmpcpp       # NCurses 客户端
      cantata       # Qt 图形客户端 (可选)
      
      # 音频工具
      playerctl     # 媒体播放器控制
      pavucontrol   # 音频控制面板
    ];

    # 创建音乐目录 (暂时注释掉以避免权限问题)
    # home.file."Music/.keep".text = "";
    
    # 创建桌面启动器
    home.file.".local/share/applications/rmpc.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=rmpc
      Comment=MPD 音乐播放器客户端
      Exec=${config.home.homeDirectory}/.local/bin/rmpc-wrapper
      Icon=multimedia-audio-player
      Categories=AudioVideo;Audio;Player;
      Terminal=true
      StartupNotify=false
    '';
    
    # 创建便捷脚本
    home.file.".local/bin/rmpc-wrapper" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        # rmpc 包装脚本，确保 MPD 服务运行
        
        # 检查 MPD 是否运行
        if ! systemctl --user is-active --quiet mpd; then
          echo "启动 MPD 服务..."
          systemctl --user start mpd
          sleep 2
        fi
        
        # 检查音乐目录是否存在
        if [ ! -d "${config.home.homeDirectory}/Music" ]; then
          mkdir -p "${config.home.homeDirectory}/Music"
          echo "已创建音乐目录: ${config.home.homeDirectory}/Music"
        fi
        
        # 启动 rmpc
        exec ${pkgs.rmpc}/bin/rmpc "$@"
      '';
    };
    
    # 创建音乐管理脚本
    home.file.".local/bin/music-manager" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        # 音乐管理脚本
        
        MUSIC_DIR="${config.home.homeDirectory}/Music"
        
        case "$1" in
          scan)
            echo "扫描音乐库..."
            ${pkgs.mpc-cli}/bin/mpc update
            echo "扫描完成"
            ;;
          stats)
            echo "音乐库统计:"
            ${pkgs.mpc-cli}/bin/mpc stats
            ;;
          add)
            if [ -z "$2" ]; then
              echo "用法: $0 add <文件或目录>"
              exit 1
            fi
            
            if [ -f "$2" ] || [ -d "$2" ]; then
              echo "复制 $2 到音乐库..."
              cp -r "$2" "$MUSIC_DIR/"
              echo "更新数据库..."
              ${pkgs.mpc-cli}/bin/mpc update
              echo "完成"
            else
              echo "错误: $2 不存在"
              exit 1
            fi
            ;;
          list)
            echo "音乐库内容:"
            ${pkgs.mpc-cli}/bin/mpc listall
            ;;
          search)
            if [ -z "$2" ]; then
              echo "用法: $0 search <关键词>"
              exit 1
            fi
            echo "搜索结果:"
            ${pkgs.mpc-cli}/bin/mpc search any "$2"
            ;;
          *)
            echo "音乐管理脚本"
            echo "用法: $0 {scan|stats|add|list|search}"
            echo ""
            echo "命令说明:"
            echo "  scan           - 扫描音乐库"
            echo "  stats          - 显示统计信息"
            echo "  add <path>     - 添加音乐文件/目录"
            echo "  list           - 列出所有音乐"
            echo "  search <term>  - 搜索音乐"
            ;;
        esac
      '';
    };
  };
}
