# MPD 外部配置方式
{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.mpd.enable && 
                     config.myHome.dotfiles.mpd.method == "external") {
    
    # 安装客户端工具（假设 MPD 服务由外部管理）
    home.packages = with pkgs; [
      # MPD 客户端工具
      mpc-cli       # 命令行客户端
      ncmpcpp       # NCurses 客户端
      cantata       # Qt 图形客户端
      gmpc          # GNOME MPD 客户端
      
      # 媒体控制工具
      playerctl     # 通用媒体播放器控制
      pavucontrol   # 音频控制面板
    ];

    # 创建外部 MPD 连接配置
    home.file.".config/mpd/client.conf".text = ''
      # MPD 客户端配置 - 外部服务器连接
      
      # 默认连接设置
      host = localhost
      port = 6600
      
      # 可选：密码（如果 MPD 服务器设置了密码）
      # password = your_password
      
      # 可选：超时设置
      timeout = 5
    '';

    # ncmpcpp 配置（连接外部 MPD）
    home.file.".config/ncmpcpp/config".text = ''
      # ncmpcpp 配置文件
      
      # MPD 连接设置
      mpd_host = localhost
      mpd_port = 6600
      mpd_connection_timeout = 5
      
      # 音乐目录（与 MPD 服务器同步）
      mpd_music_dir = ~/Music
      
      # 界面设置
      user_interface = alternative
      default_place_to_search_in = database
      
      # 显示设置
      playlist_display_mode = columns
      browser_display_mode = columns
      search_engine_display_mode = columns
      
      # 颜色主题
      colors_enabled = yes
      main_window_color = default
      header_window_color = default
      volume_color = default
      state_line_color = default
      state_flags_color = default
      
      # 其他设置
      cyclic_scrolling = yes
      lines_scrolled = 2
      follow_now_playing_lyrics = yes
      fetch_lyrics_for_current_song_in_background = yes
    '';

    # 创建连接脚本
    home.file.".local/bin/mpd-connect" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        # MPD 外部连接脚本
        
        MPD_HOST=''${1:-localhost}
        MPD_PORT=''${2:-6600}
        
        echo "连接到 MPD 服务器: $MPD_HOST:$MPD_PORT"
        
        # 测试连接
        if ${pkgs.mpc-cli}/bin/mpc -h "$MPD_HOST" -p "$MPD_PORT" status >/dev/null 2>&1; then
          echo "✓ 连接成功"
          echo "MPD 状态:"
          ${pkgs.mpc-cli}/bin/mpc -h "$MPD_HOST" -p "$MPD_PORT" status
        else
          echo "✗ 连接失败"
          echo "请检查 MPD 服务器是否运行在 $MPD_HOST:$MPD_PORT"
          exit 1
        fi
      '';
    };

    # 创建客户端启动器
    home.file.".local/bin/mpd-clients" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        # MPD 客户端启动器
        
        case "$1" in
          ncmpcpp)
            echo "启动 ncmpcpp..."
            exec ${pkgs.ncmpcpp}/bin/ncmpcpp
            ;;
          cantata)
            echo "启动 Cantata..."
            exec ${pkgs.cantata}/bin/cantata
            ;;
          rmpc)
            echo "启动 rmpc..."
            exec ${pkgs.rmpc}/bin/rmpc
            ;;
          mpc)
            shift
            exec ${pkgs.mpc-cli}/bin/mpc "$@"
            ;;
          *)
            echo "MPD 客户端启动器"
            echo "用法: $0 {ncmpcpp|cantata|rmpc|mpc} [args...]"
            echo ""
            echo "可用客户端:"
            echo "  ncmpcpp  - NCurses 客户端"
            echo "  cantata  - Qt 图形客户端"
            echo "  rmpc     - Rust TUI 客户端"
            echo "  mpc      - 命令行客户端"
            ;;
        esac
      '';
    };

    # 环境变量设置
    home.sessionVariables = {
      MPD_HOST = "localhost";
      MPD_PORT = "6600";
    };
  };
}
