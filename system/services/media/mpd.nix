# ==============================================================================
# MPD (Music Player Daemon) 系统服务配置模块
# ==============================================================================
# 
# 此模块提供完整的 MPD 服务配置，包括：
# 
# 🎵 核心功能:
#   • 多格式音频播放支持 (MP3, FLAC, Vorbis, AAC 等)
#   • 网络音频流输出 (HTTP 流媒体)
#   • 音频可视化支持 (FIFO 输出)
#   • 自动音乐库管理和更新
# 
# 🔧 系统集成:
#   • PulseAudio/PipeWire 音频系统集成
#   • systemd 服务管理
#   • 防火墙自动配置
#   • 用户权限隔离
# 
# 🛠️ 管理工具:
#   • mpd-admin - 便捷的服务管理脚本
#   • mpc-cli - 命令行客户端
#   • 完整的配置验证和诊断
# 
# 配置示例:
#   mySystem.services.media.mpd = {
#     enable = true;
#     musicDirectory = "/srv/music";
#     httpPort = 8000;
#     enableFileOutput = true;
#   };
# 
# ==============================================================================
{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.media.mpd;
in
{
  config = lib.mkIf cfg.enable {
    # ==================================================
    # MPD 软件包和管理工具安装
    # ==================================================
    environment.systemPackages = with pkgs; [
      mpd           # Music Player Daemon 核心服务
      mpc-cli       # MPD 命令行客户端工具
      
      # MPD 系统管理脚本 - 提供便捷的服务管理接口
      (writeShellScriptBin "mpd-admin" ''
        #!/usr/bin/env bash
        # MPD 系统服务管理工具
        # 提供服务控制、数据库管理和诊断功能
        
        case "$1" in
          # ================== 服务控制命令 ==================
          start)
            echo "🔄 启动 MPD 系统服务..."
            sudo systemctl start mpd
            ;;
          stop)
            echo "⏹️ 停止 MPD 系统服务..."
            sudo systemctl stop mpd
            ;;
          restart)
            echo "🔄 重启 MPD 系统服务..."
            sudo systemctl restart mpd
            ;;
          status)
            echo "📊 MPD 系统服务状态:"
            sudo systemctl status mpd
            ;;
          enable)
            echo "✅ 启用 MPD 系统服务自启动..."
            sudo systemctl enable mpd
            ;;
          disable)
            echo "❌ 禁用 MPD 系统服务自启动..."
            sudo systemctl disable mpd
            ;;
            
          # ================== 数据库管理命令 ==================
          update)
            echo "🔄 增量更新 MPD 音乐数据库..."
            mpc update
            ;;
          rescan)
            echo "🔄 完全重新扫描 MPD 数据库..."
            mpc rescan
            ;;
          stats)
            echo "📈 MPD 音乐库统计信息:"
            mpc stats
            ;;
            
          # ================== 信息和诊断命令 ==================
          config)
            echo "⚙️  MPD 系统服务配置信息:"
            echo "服务端口: ${toString cfg.port}"
            echo "音乐目录: ${cfg.musicDirectory}"
            echo "数据目录: ${cfg.dataDir}"
            echo "运行用户: ${cfg.user}:${cfg.group}"
            ${lib.optionalString (cfg.httpPort != null) ''
            echo "HTTP 流端口: ${toString cfg.httpPort}"
            echo "HTTP 流地址: http://localhost:${toString cfg.httpPort}"
            ''}
            echo "配置文件: /run/mpd/mpd.conf"
            ;;
          logs)
            echo "📋 查看 MPD 系统服务实时日志..."
            sudo journalctl -u mpd -f
            ;;
          test-connection)
            echo "🔍 测试 MPD 服务连接..."
            if mpc status >/dev/null 2>&1; then
              echo "✅ MPD 连接正常"
              mpc version
            else
              echo "❌ 无法连接到 MPD"
              echo "请检查服务状态: systemctl status mpd"
            fi
            ;;
            
          # ================== 帮助信息 ==================
          *)
            echo "🎵 MPD 系统服务管理工具"
            echo "用法: mpd-admin {command}"
            echo ""
            echo "📋 服务管理命令:"
            echo "  start         - 启动 MPD 服务"
            echo "  stop          - 停止 MPD 服务"
            echo "  restart       - 重启 MPD 服务"
            echo "  status        - 查看服务运行状态"
            echo "  enable        - 启用开机自启动"
            echo "  disable       - 禁用开机自启动"
            echo ""
            echo "🗂️  数据库管理命令:"
            echo "  update        - 增量更新音乐数据库"
            echo "  rescan        - 完全重新扫描数据库"
            echo "  stats         - 显示音乐库统计信息"
            echo ""
            echo "🔧 诊断和信息命令:"
            echo "  config        - 显示当前配置信息"
            echo "  logs          - 查看服务实时日志"
            echo "  test-connection - 测试服务连接状态"
            echo ""
            echo "💡 提示: 大多数命令需要 sudo 权限"
            exit 1
            ;;
        esac
      '')
    ];

    # ==================================================
    # 系统目录和权限管理
    # ==================================================
    # 使用 systemd-tmpfiles 确保必要目录存在且权限正确
    systemd.tmpfiles.rules = [
      # 音乐目录 - 755 权限允许 MPD 读取，用户可写
      "d ${cfg.musicDirectory} 0755 ${cfg.user} ${cfg.group} - -"
      # MPD 数据目录 - 存储数据库、日志等文件
      "d ${cfg.dataDir} 0755 ${cfg.user} ${cfg.group} - -"
      # 播放列表目录 - 存储用户创建的播放列表文件
      "d ${cfg.dataDir}/playlists 0755 ${cfg.user} ${cfg.group} - -"
    ] ++ lib.optionals cfg.enableFileOutput [
      # FIFO 管道文件 - 用于音频可视化，644 权限允许读取
      "f ${cfg.fifoPath} 0644 ${cfg.user} ${cfg.group} - -"
    ];

    # ==================================================
    # MPD 核心服务配置
    # ==================================================
    services.mpd = {
      enable = true;
      # 运行用户和组 - 安全隔离
      user = cfg.user;
      group = cfg.group;
      # 目录配置
      dataDir = cfg.dataDir;           # 数据存储目录
      musicDirectory = cfg.musicDirectory; # 音乐文件目录
      
      # 网络配置 - 仅本地访问以提高安全性
      network = {
        listenAddress = "127.0.0.1";   # 仅监听本地地址
        port = cfg.port;               # 控制端口（通常是 6600）
      };
      
      extraConfig = ''
        # ==================================================
        # MPD 数据文件配置
        # ==================================================
        # 数据库文件 - 存储音乐库索引信息
        db_file         "${cfg.dataDir}/database"
        # 日志文件 - 记录 MPD 运行日志
        log_file        "${cfg.dataDir}/log"
        # 状态文件 - 保存播放状态（当前歌曲、播放位置等）
        state_file      "${cfg.dataDir}/state"
        # 贴纸文件 - 存储评分、播放次数等元数据
        sticker_file    "${cfg.dataDir}/sticker.sql"
        # 播放列表目录 - 存储用户创建的播放列表
        playlist_directory "${cfg.dataDir}/playlists"
        
        # ==================================================
        # 音频输出配置
        # ==================================================
        ${lib.optionalString cfg.enablePulseaudio ''
        # PulseAudio/PipeWire 输出 - 现代 Linux 音频系统
        audio_output {
            type        "pulse"
            name        "PulseAudio/PipeWire 音频输出"
            server      "unix:/run/user/1000/pulse/native"
        }
        ''}
        
        ${lib.optionalString cfg.enableAlsa ''
        # ALSA 直接输出 - 低延迟硬件访问
        audio_output {
            type        "alsa"
            name        "ALSA 硬件输出"
            device      "hw:0,0"          # 默认音频设备
            mixer_type  "hardware"        # 硬件混音器
            mixer_device "default"        # 默认混音器设备
            mixer_control "Master"        # 主音量控制
        }
        ''}
        
        ${lib.optionalString (cfg.httpPort != null) ''
        # HTTP 音频流 - 用于网络播放和远程访问
        audio_output {
            type        "httpd"
            name        "HTTP 网络音频流"
            encoder     "lame"            # MP3 编码器（高质量）
            port        "${toString cfg.httpPort}"
            bitrate     "192"             # 192kbps 码率（平衡质量和带宽）
            format      "44100:16:2"      # 44.1kHz 16-bit 立体声
            always_on   "yes"             # 始终保持活跃
            tags        "yes"             # 包含标签信息
        }
        ''}
        
        ${lib.optionalString cfg.enableFileOutput ''
        # FIFO 文件输出 - 用于音频可视化器和录制
        audio_output {
            type        "fifo"
            name        "FIFO 可视化输出"
            path        "${cfg.fifoPath}"
            format      "44100:16:2"      # CD 质量音频格式
        }
        ''}
        
        # ==================================================
        # 输入插件配置
        # ==================================================
        # cURL 插件 - 支持网络音频流（HTTP/HTTPS）
        input {
            plugin "curl"
        }
        
        # ==================================================
        # 音频解码器配置
        # ==================================================
        # MP3 解码器 - 支持 MPEG 音频文件
        decoder {
            plugin      "mad"
            enabled     "yes"
        }
        
        # Ogg Vorbis 解码器 - 开源无损压缩格式
        decoder {
            plugin      "vorbis" 
            enabled     "yes"
        }
        
        # FLAC 解码器 - 无损音频压缩格式
        decoder {
            plugin      "flac"
            enabled     "yes"
        }
        
        # FFmpeg 解码器 - 支持大多数音频/视频格式
        decoder {
            plugin      "ffmpeg"
            enabled     "yes"
        }
        
        # ==================================================
        # 文件系统和扫描配置
        # ==================================================
        # 文件系统字符编码
        filesystem_charset      "UTF-8"
        # 要读取的音频元数据字段
        metadata_to_use         "artist,album,title,track,name,genre,date,composer,performer,disc,albumartist"
        # 自动监控音乐目录变化
        auto_update             "yes"
        # 自动扫描深度限制（避免过深的目录结构影响性能）
        auto_update_depth       "4"
        # 跟踪目录外的符号链接
        follow_outside_symlinks "yes"
        # 跟踪目录内的符号链接
        follow_inside_symlinks  "yes"
        
        # ==================================================
        # 音频处理配置
        # ==================================================
        # 软件混音器 - 更好的兼容性和控制
        mixer_type              "software"
        
        # 重播增益配置 - 自动音量平衡
        replaygain              "auto"         # 自动选择专辑或单曲增益
        replaygain_preamp       "0"           # 重播增益预增益（dB）
        replaygain_missing_preamp "0"         # 无重播增益文件时的预增益
        replaygain_limit        "yes"         # 限制输出防止削波
        
        # ==================================================
        # 网络和性能配置
        # ==================================================
        # 客户端连接超时时间（秒）
        connection_timeout      "60"
        # 最大同时连接数
        max_connections         "10"
        # 最大播放列表长度（歌曲数）
        max_playlist_length     "16384"
        # 最大命令列表大小（批量命令）
        max_command_list_size   "2048"
        # 最大输出缓冲区大小（KB）
        max_output_buffer_size  "8192"
        
        # ==================================================
        # 日志配置
        # ==================================================
        # 日志级别: default, secure, verbose, notice
        log_level               "notice"      # 记录重要信息但不过于详细
      '';
    };

    # ==================================================
    # 网络防火墙配置
    # ==================================================
    # 开放必要的 TCP 端口供 MPD 使用
    networking.firewall = {
      allowedTCPPorts = [ 
        cfg.port  # MPD 控制端口
      ] ++ lib.optional (cfg.httpPort != null) cfg.httpPort; # HTTP 流端口（如果启用）
    };

    # ==================================================
    # 音频系统集成配置
    # ==================================================
    # 启用实时音频工具包 - 减少音频延迟和提高性能
    security.rtkit.enable = lib.mkIf cfg.enablePulseaudio true;
    
    # 音频服务管理 - 使用 PipeWire 代替传统 PulseAudio
    systemd.user.services = lib.mkIf cfg.enablePulseaudio {
      # 禁用传统 PulseAudio 服务，让 PipeWire 接管
      pulseaudio.wantedBy = lib.mkForce [];
    };
  };
}
