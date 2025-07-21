# MPD 客户端工具配置 (Home Manager)
# 注意: MPD 系统服务在 system/services/media/mpd.nix 中配置
{ config, lib, pkgs, ... }:

let
  cfg = config.myHome.dotfiles.mpd;
in
{
  config = lib.mkIf (config.myHome.dotfiles.enable && cfg.enable && cfg.method == "homemanager") {
    # 安装 MPD 客户端工具（不包含 MPD 服务本身）
    home.packages = with pkgs; [
      mpc-cli       # 命令行客户端
      ncmpcpp       # NCurses 图形客户端
      cantata       # Qt 图形客户端 (可选)
      
      # 音频控制工具
      playerctl     # 媒体播放器通用控制
      pavucontrol   # 音频控制面板
    ];

    # MPD 客户端管理脚本
    home.file.".local/bin/mpd-client" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        # MPD 客户端管理脚本
        
        MPD_HOST="''${MPD_HOST:-localhost}"
        MPD_PORT="''${MPD_PORT:-6600}"
        
        # 检查 MPD 连接
        check_mpd() {
            if ! nc -z "$MPD_HOST" "$MPD_PORT" 2>/dev/null; then
                echo "错误: 无法连接到 MPD ($MPD_HOST:$MPD_PORT)"
                echo "请检查 MPD 系统服务是否运行："
                echo "  sudo systemctl status mpd"
                echo "  sudo systemctl start mpd"
                return 1
            fi
            return 0
        }
        
        case "$1" in
          connect-test)
            echo "测试 MPD 连接..."
            if check_mpd; then
              echo "✓ MPD 连接正常"
              echo "服务器信息:"
              mpc version
            else
              exit 1
            fi
            ;;
            
          status)
            if check_mpd; then
              mpc status
            else
              exit 1
            fi
            ;;
            
          info)
            if check_mpd; then
              echo "MPD 服务器信息:"
              mpc version
              echo ""
              echo "当前状态:"
              mpc status
              echo ""
              echo "音乐库统计:"
              mpc stats
            else
              exit 1
            fi
            ;;
            
          playlist)
            if check_mpd; then
              echo "当前播放队列:"
              mpc playlist
            else
              exit 1
            fi
            ;;
            
          search)
            if [ -z "$2" ]; then
              echo "用法: $0 search <关键词>"
              exit 1
            fi
            if check_mpd; then
              echo "搜索结果:"
              mpc search any "$2"
            else
              exit 1
            fi
            ;;
            
          add-search)
            if [ -z "$2" ]; then
              echo "用法: $0 add-search <关键词>"
              exit 1
            fi
            if check_mpd; then
              echo "搜索并添加到队列:"
              mpc findadd any "$2"
              echo "已添加搜索结果到播放队列"
            else
              exit 1
            fi
            ;;
            
          clear-queue)
            if check_mpd; then
              mpc clear
              echo "播放队列已清空"
            else
              exit 1
            fi
            ;;
            
          save-playlist)
            if [ -z "$2" ]; then
              echo "用法: $0 save-playlist <播放列表名>"
              exit 1
            fi
            if check_mpd; then
              mpc save "$2"
              echo "当前队列已保存为播放列表: $2"
            else
              exit 1
            fi
            ;;
            
          load-playlist)
            if [ -z "$2" ]; then
              echo "用法: $0 load-playlist <播放列表名>"
              exit 1
            fi
            if check_mpd; then
              mpc load "$2"
              echo "播放列表 $2 已加载到队列"
            else
              exit 1
            fi
            ;;
            
          list-playlists)
            if check_mpd; then
              echo "可用播放列表:"
              mpc lsplaylists
            else
              exit 1
            fi
            ;;
            
          ncmpcpp)
            if check_mpd; then
              exec ${pkgs.ncmpcpp}/bin/ncmpcpp
            else
              exit 1
            fi
            ;;
            
          cantata)
            if check_mpd; then
              exec ${pkgs.cantata}/bin/cantata &
            else
              exit 1
            fi
            ;;
            
          *)
            echo "MPD 客户端管理工具"
            echo "用法: $0 {connect-test|status|info|playlist|search|add-search|clear-queue|save-playlist|load-playlist|list-playlists|ncmpcpp|cantata}"
            echo ""
            echo "连接测试:"
            echo "  connect-test        - 测试 MPD 服务器连接"
            echo "  info               - 显示服务器信息和状态"
            echo ""
            echo "播放控制:"
            echo "  status             - 显示播放状态"
            echo "  playlist           - 显示当前播放队列"
            echo ""
            echo "音乐库操作:"
            echo "  search <term>      - 搜索音乐"
            echo "  add-search <term>  - 搜索并添加到队列"
            echo "  clear-queue        - 清空播放队列"
            echo ""
            echo "播放列表管理:"
            echo "  save-playlist <name>   - 保存当前队列为播放列表"
            echo "  load-playlist <name>   - 加载播放列表到队列"
            echo "  list-playlists         - 列出所有播放列表"
            echo ""
            echo "图形客户端:"
            echo "  ncmpcpp           - 启动 ncmpcpp 终端客户端"
            echo "  cantata           - 启动 Cantata 图形客户端"
            echo ""
            echo "环境变量:"
            echo "  MPD_HOST          - MPD 服务器地址 (默认: localhost)"
            echo "  MPD_PORT          - MPD 服务器端口 (默认: 6600)"
            ;;
        esac
      '';
    };

    # 创建用户音乐目录的软链接脚本
    home.file.".local/bin/music-link" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        # 创建用户音乐目录到系统音乐目录的软链接
        
        USER_MUSIC="$HOME/Music"
        SYSTEM_MUSIC="/srv/music/$USER"
        
        case "$1" in
          setup)
            echo "设置用户音乐目录链接..."
            
            # 检查系统音乐目录是否存在
            if [ ! -d "/srv/music" ]; then
              echo "错误: 系统音乐目录 /srv/music 不存在"
              echo "请联系系统管理员或检查 MPD 系统服务配置"
              exit 1
            fi
            
            # 创建用户目录
            sudo mkdir -p "$SYSTEM_MUSIC"
            sudo chown "$USER:users" "$SYSTEM_MUSIC"
            
            # 创建软链接
            if [ -L "$USER_MUSIC" ]; then
              echo "软链接已存在"
            elif [ -d "$USER_MUSIC" ]; then
              echo "本地 Music 目录已存在，请手动处理："
              echo "  mv '$USER_MUSIC' '$USER_MUSIC.backup'"
              echo "  $0 setup"
              exit 1
            else
              ln -s "$SYSTEM_MUSIC" "$USER_MUSIC"
              echo "✓ 用户音乐目录已链接到系统目录"
            fi
            ;;
            
          remove)
            if [ -L "$USER_MUSIC" ]; then
              rm "$USER_MUSIC"
              echo "✓ 软链接已移除"
            else
              echo "软链接不存在"
            fi
            ;;
            
          status)
            echo "音乐目录状态:"
            echo "用户目录: $USER_MUSIC"
            if [ -L "$USER_MUSIC" ]; then
              echo "  -> 链接到: $(readlink '$USER_MUSIC')"
            elif [ -d "$USER_MUSIC" ]; then
              echo "  -> 本地目录 ($(du -sh '$USER_MUSIC' | cut -f1))"
            else
              echo "  -> 不存在"
            fi
            
            echo "系统目录: $SYSTEM_MUSIC"
            if [ -d "$SYSTEM_MUSIC" ]; then
              echo "  -> 存在 ($(du -sh '$SYSTEM_MUSIC' 2>/dev/null | cut -f1 || echo '无法访问'))"
            else
              echo "  -> 不存在"
            fi
            ;;
            
          *)
            echo "音乐目录链接管理工具"
            echo "用法: $0 {setup|remove|status}"
            echo ""
            echo "  setup   - 设置用户音乐目录链接"
            echo "  remove  - 移除软链接"
            echo "  status  - 显示目录状态"
            ;;
        esac
      '';
    };

    # 创建桌面启动器
    home.file.".local/share/applications/ncmpcpp.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=ncmpcpp
      Comment=NCurses MPD 客户端
      Exec=${pkgs.ncmpcpp}/bin/ncmpcpp
      Icon=multimedia-audio-player
      Categories=AudioVideo;Audio;Player;
      Terminal=true
      StartupNotify=false
      Keywords=music;audio;player;mpd;ncurses;
    '';

    home.file.".local/share/applications/cantata.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Cantata
      Comment=Qt MPD 图形客户端
      Exec=${pkgs.cantata}/bin/cantata
      Icon=cantata
      Categories=AudioVideo;Audio;Player;
      Terminal=false
      StartupNotify=true
      Keywords=music;audio;player;mpd;qt;
    '';

    # Shell 别名
    programs.bash.shellAliases = lib.mkIf config.programs.bash.enable {
      mpc = "${pkgs.mpc-cli}/bin/mpc";
      mpd-test = "mpd-client connect-test";
      mpd-info = "mpd-client info";
      mpd-ncmpcpp = "mpd-client ncmpcpp";
    };

    programs.fish.shellAliases = lib.mkIf config.programs.fish.enable {
      mpc = "${pkgs.mpc-cli}/bin/mpc";
      mpd-test = "mpd-client connect-test";
      mpd-info = "mpd-client info";
      mpd-ncmpcpp = "mpd-client ncmpcpp";
    };

    programs.zsh.shellAliases = lib.mkIf config.programs.zsh.enable {
      mpc = "${pkgs.mpc-cli}/bin/mpc";
      mpd-test = "mpd-client connect-test";
      mpd-info = "mpd-client info";
      mpd-ncmpcpp = "mpd-client ncmpcpp";
    };
  };
}
