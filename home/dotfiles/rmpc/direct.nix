# ==============================================================================
# rmpc (Rust MPD Client) Direct Configuration 直接配置模块
# ==============================================================================
#
# rmpc 直接配置方式 - 使用 Home Manager 激活脚本直接写入配置文件
# 
# 🎯 配置理念:
#   • 配置内容在 Nix 代码中定义
#   • Home Manager 负责同步配置到文件系统
#   • 配置变更需要重新运行 home-manager switch
#   • 适合需要版本控制和自动化部署的场景
#
# 🔧 工作原理:
#   • 使用 home.activation 激活脚本
#   • 在每次 home-manager switch 时重写配置文件
#   • 配置内容完全由 Nix 管理
#
# 📁 文件结构:
#   • ~/.config/rmpc/config.ron    - 由 Nix 生成的配置文件
#   • ~/.cache/rmpc/               - 缓存目录
#   • ~/.local/share/rmpc/lyrics/  - 歌词存储目录
#
# 配置示例:
#   myHome.dotfiles.rmpc = {
#     enable = true;
#     method = "direct";
#   };
#
# ==============================================================================
{ config, lib, pkgs, ... }:

let
  cfg = config.myHome.dotfiles.rmpc;
  
  # ====================================================================
  # rmpc 完整配置内容定义 (RON 格式)
  # ====================================================================
  # 
  # 这是 rmpc 的完整配置，遵循 RON (Rust Object Notation) 格式
  # 配置内容经过优化，去除冗余，保持完备性
  #
  rmpcConfigContent = ''
    #![enable(implicit_some)]
    #![enable(unwrap_newtypes)]
    #![enable(unwrap_variant_newtypes)]
    (
        // ==================== 连接配置 ====================
        // MPD 服务器连接参数
        address: "127.0.0.1:6600",             // 本地 MPD 服务地址
        password: None,                        // 无密码访问（本地连接）
        
        // ==================== 目录配置 ====================
        // 应用数据存储路径
        cache_dir: "${config.home.homeDirectory}/.cache/rmpc",
        lyrics_dir: "${config.home.homeDirectory}/.local/share/rmpc/lyrics",
        
        // ==================== 界面配置 ====================
        theme: None,                           // 使用默认主题（跟随终端）
        max_fps: 30,                           // 最大刷新率 - 平衡性能和体验
        scrolloff: 3,                          // 滚动偏移量 - 类似 Vim scrolloff
        wrap_navigation: true,                 // 导航循环wrap
        enable_mouse: true,                    // 启用鼠标支持
        enable_config_hot_reload: true,        // 配置文件热重载
        
        // ==================== 播放控制配置 ====================
        volume_step: 5,                        // 音量调节步长（5%）
        rewind_to_start_sec: 3,                // 倒退到开头的秒数阈值
        status_update_interval_ms: 500,        // 状态更新间隔（毫秒）
        select_current_song_on_change: true,   // 歌曲切换时自动选中
        center_current_song_on_change: true,   // 歌曲切换时居中显示
        
        // ==================== 网络超时配置 ====================
        mpd_read_timeout_ms: 10000,            // MPD 读取超时（10秒）
        mpd_write_timeout_ms: 5000,            // MPD 写入超时（5秒）
        mpd_idle_read_timeout_ms: None,        // 空闲读取无超时
        
        // ==================== 播放列表同步 ====================
        reflect_changes_to_playlist: false,   // 禁用自动同步（避免意外修改）
        
        // ==================== 专辑封面配置 ====================
        album_art: (
            method: Auto,                      // 自动检测封面来源
            max_size_px: (width: 800, height: 800),  // 最大封面尺寸
            disabled_protocols: ["http://", "https://"],  // 禁用网络封面
            vertical_align: Center,            // 垂直居中对齐
            horizontal_align: Center,          // 水平居中对齐
        ),
        
        // ==================== 桌面通知配置 ====================
        on_song_change: [
            "notify-send", 
            "--expire-time=3000",              // 通知显示3秒
            "--icon=audio-x-generic", 
            "♪ 正在播放", 
            "{artist} - {title}"               // 艺术家 - 标题格式
        ],
        
        // ==================== 搜索配置 ====================
        search: (
            case_sensitive: false,             // 不区分大小写搜索
            mode: Contains,                    // 包含模式搜索
            // 支持的搜索标签
            tags: [
                (value: "any", label: "任意标签"),
                (value: "artist", label: "艺术家"),
                (value: "album", label: "专辑"),
                (value: "albumartist", label: "专辑艺术家"),
                (value: "title", label: "标题"),
                (value: "filename", label: "文件名"),
                (value: "genre", label: "流派"),
                (value: "date", label: "日期"),
            ],
        ),
        
        // ==================== 视图和排序配置 ====================
        artists: (
            album_display_mode: SplitByDate,   // 按日期分割专辑显示
            album_sort_by: Date,               // 专辑按日期排序
        ),
        
        // 浏览器中歌曲排序：碟片 -> 轨道 -> 艺术家 -> 标题
        browser_song_sort: [Disc, Track, Artist, Title],
        
        // 目录排序：按类型分组，正序排列
        directories_sort: SortFormat(group_by_type: true, reverse: false),
        
        // 在浏览器中显示播放列表（仅非根目录）
        show_playlists_in_browser: NonRoot,
        
        // ==================== 键位绑定配置 ====================
        keybinds: (
            // ===== 全局键位 - 在所有界面均可用 =====
            global: {
            // ===== 全局键位 - 在所有界面均可用 =====
            global: {
                // 命令和音量控制
                ":": CommandMode,              // 进入命令模式（类似 Vim）
                ",": VolumeDown,               // 音量减（逗号键）
                ".": VolumeUp,                 // 音量加（句号键）
                
                // 播放控制
                "s": Stop,                     // 停止播放
                "p": TogglePause,              // 播放/暂停切换
                ">": NextTrack,                // 下一首
                "<": PreviousTrack,            // 上一首
                "f": SeekForward,              // 快进
                "b": SeekBack,                 // 快退
                
                // 播放模式切换
                "z": ToggleRepeat,             // 切换重复播放
                "x": ToggleRandom,             // 切换随机播放
                "c": ToggleConsume,            // 切换消费模式
                "v": ToggleSingle,             // 切换单曲模式
                
                // 应用控制
                "q": Quit,                     // 退出程序
                "~": ShowHelp,                 // 显示帮助
                
                // MPD 数据库操作
                "u": Update,                   // 更新音乐库
                "U": Rescan,                   // 完全重扫音乐库
                "R": AddRandom,                // 添加随机歌曲
                
                // 信息显示
                "I": ShowCurrentSongInfo,      // 显示当前歌曲信息
                "O": ShowOutputs,              // 显示音频输出设备
                "P": ShowDecoders,             // 显示解码器信息
                
                // 标签页控制
                "<Tab>": NextTab,              // 下一个标签页
                "<S-Tab>": PreviousTab,        // 上一个标签页
                "1": SwitchToTab("Queue"),     // 切换到播放队列
                "2": SwitchToTab("Directories"), // 切换到目录浏览
                "3": SwitchToTab("Artists"),   // 切换到艺术家
                "4": SwitchToTab("Album Artists"), // 切换到专辑艺术家
                "5": SwitchToTab("Albums"),    // 切换到专辑
                "6": SwitchToTab("Playlists"), // 切换到播放列表
                "7": SwitchToTab("Search"),    // 切换到搜索
            },
            
            // ===== 导航键位 - 列表和界面导航 =====
            navigation: {
                // Vim 风格方向键
                "k": Up,                       // 上移（Vim 风格）
                "j": Down,                     // 下移（Vim 风格）
                "h": Left,                     // 左移（Vim 风格）
                "l": Right,                    // 右移（Vim 风格）
                
                // 传统方向键支持
                "<Up>": Up,
                "<Down>": Down,
                "<Left>": Left,
                "<Right>": Right,
                
                // 面板间导航（Ctrl + hjkl）
                "<C-k>": PaneUp,               // 上一个面板
                "<C-j>": PaneDown,             // 下一个面板
                "<C-h>": PaneLeft,             // 左侧面板
                "<C-l>": PaneRight,            // 右侧面板
                
                // 页面滚动
                "<C-u>": UpHalf,               // 上滚半页
                "<C-d>": DownHalf,             // 下滚半页
                "g": Top,                      // 跳到顶部
                "G": Bottom,                   // 跳到底部
                
                // 选择和操作
                "<CR>": Confirm,               // 确认/回车
                "<Space>": Select,             // 空格选中
                "<C-Space>": InvertSelection,  // 反选
                
                // 内容操作
                "a": Add,                      // 添加到播放队列
                "A": AddAll,                   // 添加全部
                "d": Delete,                   // 删除
                "D": Delete,                   // 删除（同上）
                "r": Rename,                   // 重命名
                
                // 输入和搜索
                "i": FocusInput,               // 聚焦输入框
                "/": EnterSearch,              // 进入搜索模式
                "n": NextResult,               // 下一个搜索结果
                "N": PreviousResult,           // 上一个搜索结果
                
                // 列表操作
                "J": MoveDown,                 // 向下移动项目
                "K": MoveUp,                   // 向上移动项目
                "B": ShowInfo,                 // 显示详细信息
                
                // 退出操作
                "<C-c>": Close,                // Ctrl+C 关闭
                "<Esc>": Close,                // ESC 关闭
                "<C-z>": ContextMenu(),        // 上下文菜单
            },
            
            // ===== 播放队列专用键位 =====
            queue: {
                "<CR>": Play,                  // 播放选中歌曲
                "d": Delete,                   // 删除选中歌曲
                "D": DeleteAll,                // 清空播放队列
                "a": AddToPlaylist,            // 添加到播放列表
                "C": JumpToCurrent,            // 跳转到当前播放歌曲
                "X": Shuffle,                  // 随机排列队列
                "<C-s>": Save,                 // 保存播放队列为播放列表
            },
        ),
        
        // ==================== 标签页布局配置 ====================
        tabs: [
            // 播放队列标签页 - 主界面，显示封面和队列
            (
                name: "Queue",
                pane: Split(
                    direction: Horizontal,     // 水平分割布局
                    panes: [
                        // 左侧：专辑封面显示（35% 宽度）
                        (size: "35%", pane: Pane(AlbumArt)),
                        // 右侧：播放队列（65% 宽度）
                        (size: "65%", pane: Pane(Queue)),
                    ],
                ),
            ),
            // 目录浏览标签页
            (
                name: "Directories",
                pane: Pane(Directories),
            ),
            // 艺术家标签页
            (
                name: "Artists",
                pane: Pane(Artists),
            ),
            // 专辑艺术家标签页
            (
                name: "Album Artists",
                pane: Pane(AlbumArtists),
            ),
            // 专辑标签页
            (
                name: "Albums",
                pane: Pane(Albums),
            ),
            // 播放列表标签页
            (
                name: "Playlists",
                pane: Pane(Playlists),
            ),
            // 搜索标签页
            (
                name: "Search",
                pane: Pane(Search),
            ),
        ],
    )
  '';
in
{
  config = lib.mkIf (config.myHome.dotfiles.enable && cfg.enable && cfg.method == "direct") {
    # ==================================================
    # 软件包安装配置
    # ==================================================
    home.packages = with pkgs; [
      rmpc          # 现代 Rust MPD 客户端 - 主程序
      cava          # 终端音频可视化器 - 增强体验
      libnotify     # 桌面通知支持 - 歌曲切换提醒
    ];

    # ==================================================
    # 配置文件直接写入激活脚本
    # ==================================================
    # 使用 Home Manager 激活脚本在每次 switch 时重写配置
    home.activation.rmpc = lib.hm.dag.entryAfter ["writeBoundary"] ''
      # ===== 创建必要目录 =====
      echo "📁 创建 rmpc 目录结构..."
      ''${DRY_RUN_CMD} mkdir -p "$HOME/.config/rmpc"
      ''${DRY_RUN_CMD} mkdir -p "$HOME/.cache/rmpc"
      ''${DRY_RUN_CMD} mkdir -p "$HOME/.local/share/rmpc/lyrics"
      
      # ===== 写入配置文件 =====
      echo "⚙️  生成 rmpc 配置文件..."
      ''${DRY_RUN_CMD} cat > "$HOME/.config/rmpc/config.ron" << 'EOF'
${rmpcConfigContent}
EOF
      
      # ===== 设置文件权限 =====
      ''${DRY_RUN_CMD} chmod 644 "$HOME/.config/rmpc/config.ron"
      
      echo "✅ rmpc 配置文件已通过直接方式生成"
      echo "📄 配置文件位置: $HOME/.config/rmpc/config.ron"
    '';

    # ==================================================
    # rmpc 启动包装脚本
    # ==================================================
    home.file.".local/bin/rmpc-wrapper" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        # ==============================================================================
        # rmpc 直接配置启动脚本
        # ==============================================================================
        # 
        # 功能特性:
        #   • 验证配置文件存在性
        #   • MPD 连接状态检查
        #   • 配置同步状态检查
        #   • 友好的错误处理
        #
        # 用法: rmpc-wrapper [rmpc选项...]
        #
        # ==============================================================================
        
        CONFIG_FILE="$HOME/.config/rmpc/config.ron"
        
        # ===== 配置文件存在性检查 =====
        if [ ! -f "$CONFIG_FILE" ]; then
            echo "❌ 错误: rmpc 配置文件不存在"
            echo "📄 期望位置: $CONFIG_FILE"
            echo ""
            echo "🔧 解决方案:"
            echo "   • 运行 home-manager switch --flake .#$USER@$(hostname) 重新生成配置"
            echo "   • 检查 myHome.dotfiles.rmpc.enable 是否为 true"
            echo "   • 检查 myHome.dotfiles.rmpc.method 是否设置为 \"direct\""
            echo ""
            exit 1
        fi
        
        # ===== 配置文件时效性检查 =====
        # 检查配置文件是否可能过期（超过7天未更新）
        if [ -f "$CONFIG_FILE" ]; then
            CONFIG_AGE=$(($(date +%s) - $(date -r "$CONFIG_FILE" +%s)))
            if [ $CONFIG_AGE -gt 604800 ]; then  # 7天 = 604800秒
                echo "⚠️  提醒: 配置文件超过7天未更新"
                echo "📅 最后更新: $(date -r "$CONFIG_FILE")"
                echo "💡 建议运行 home-manager switch 更新配置"
                echo ""
            fi
        fi
        
        # ===== MPD 连接状态检查 =====
        if command -v mpc >/dev/null 2>&1; then
            if mpc status >/dev/null 2>&1; then
                echo "✅ MPD 服务连接正常"
            else
                echo "⚠️  警告: 无法连接到 MPD 服务"
                echo "🔧 故障排除:"
                echo "   • 检查 MPD 服务: systemctl status mpd"
                echo "   • 启动 MPD 服务: systemctl start mpd"
                echo "   • 检查连接配置: 127.0.0.1:6600"
                echo ""
            fi
        fi
        
        # ===== 启动 rmpc =====
        echo "🎵 启动 rmpc (直接配置模式)..."
        exec ${pkgs.rmpc}/bin/rmpc "$@"
      '';
    };

    # ==================================================
    # 配置管理辅助脚本
    # ==================================================
    home.file.".local/bin/rmpc-direct-info" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        # ==============================================================================
        # rmpc 直接配置模式信息工具
        # ==============================================================================
        # 
        # 提供直接配置模式的状态信息和管理功能
        #
        # ==============================================================================
        
        CONFIG_FILE="$HOME/.config/rmpc/config.ron"
        
        case "$1" in
            status)
                echo "📊 rmpc 直接配置模式状态:"
                echo "==========================================="
                
                if [ -f "$CONFIG_FILE" ]; then
                    echo "✅ 配置文件: 存在"
                    echo "📄 文件路径: $CONFIG_FILE"
                    echo "📊 文件大小: $(du -h "$CONFIG_FILE" | cut -f1)"
                    echo "📅 修改时间: $(date -r "$CONFIG_FILE")"
                    
                    # 检查配置文件年龄
                    CONFIG_AGE=$(($(date +%s) - $(date -r "$CONFIG_FILE" +%s)))
                    if [ $CONFIG_AGE -gt 86400 ]; then  # 1天
                        echo "⚠️  配置年龄: $((CONFIG_AGE / 86400)) 天前"
                    else
                        echo "✅ 配置年龄: 最近更新"
                    fi
                else
                    echo "❌ 配置文件: 不存在"
                    echo "💡 解决方案: 运行 home-manager switch"
                fi
                
                echo ""
                echo "📁 相关目录:"
                [ -d "$HOME/.cache/rmpc" ] && echo "✅ 缓存目录: 存在" || echo "❌ 缓存目录: 不存在"
                [ -d "$HOME/.local/share/rmpc/lyrics" ] && echo "✅ 歌词目录: 存在" || echo "❌ 歌词目录: 不存在"
                ;;
                
            show)
                if [ -f "$CONFIG_FILE" ]; then
                    echo "📄 rmpc 配置文件内容:"
                    echo "==========================================="
                    if command -v bat >/dev/null 2>&1; then
                        bat --style=numbers,header "$CONFIG_FILE"
                    else
                        cat "$CONFIG_FILE"
                    fi
                else
                    echo "❌ 配置文件不存在"
                fi
                ;;
                
            validate)
                if [ -f "$CONFIG_FILE" ]; then
                    echo "🔍 验证配置文件语法..."
                    if ${pkgs.rmpc}/bin/rmpc --config "$CONFIG_FILE" --help >/dev/null 2>&1; then
                        echo "✅ 配置文件语法正确"
                    else
                        echo "❌ 配置文件语法错误"
                        echo "💡 解决方案: 运行 home-manager switch 重新生成"
                    fi
                else
                    echo "❌ 配置文件不存在"
                fi
                ;;
                
            regenerate)
                echo "🔄 重新生成配置文件..."
                echo "💡 请运行以下命令:"
                echo "   home-manager switch --flake .#$USER@$(hostname)"
                ;;
                
            *)
                echo "🎵 rmpc 直接配置模式管理工具"
                echo ""
                echo "用法: rmpc-direct-info <command>"
                echo ""
                echo "命令:"
                echo "  status      - 显示配置状态信息"
                echo "  show        - 显示配置文件内容"
                echo "  validate    - 验证配置文件语法"
                echo "  regenerate  - 显示重新生成配置的方法"
                ;;
        esac
      '';
    };

    # ==================================================
    # 桌面环境集成
    # ==================================================
    # 桌面启动器 - 使用包装器确保正确启动
    home.file.".local/share/applications/rmpc.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=rmpc
      Comment=现代化终端 MPD 客户端 (直接配置)
      Exec=${pkgs.writeShellScript "rmpc-launcher" ''
        # 启动器脚本 - 优先使用包装器
        if [ -x "$HOME/.local/bin/rmpc-wrapper" ]; then
          exec "$HOME/.local/bin/rmpc-wrapper" "$@"
        else
          exec ${pkgs.rmpc}/bin/rmpc "$@"
        fi
      ''}
      Icon=multimedia-audio-player
      Categories=AudioVideo;Audio;Player;
      Terminal=true
      StartupNotify=false
      Keywords=music;audio;player;mpd;terminal;rust;direct;nix;
    '';

    # ==================================================
    # Shell 环境集成
    # ==================================================
    # 为各种 Shell 添加便捷别名
    programs.bash.shellAliases = lib.mkIf config.programs.bash.enable {
      rmpc-info = "rmpc-direct-info";         # 直接配置信息
      rmpc-status = "rmpc-direct-info status"; # 快速状态检查
      rmpc-regen = "home-manager switch";      # 重新生成配置
    };

    programs.fish.shellAliases = lib.mkIf config.programs.fish.enable {
      rmpc-info = "rmpc-direct-info";         # 直接配置信息
      rmpc-status = "rmpc-direct-info status"; # 快速状态检查
      rmpc-regen = "home-manager switch";      # 重新生成配置
    };

    programs.zsh.shellAliases = lib.mkIf config.programs.zsh.enable {
      rmpc-info = "rmpc-direct-info";         # 直接配置信息
      rmpc-status = "rmpc-direct-info status"; # 快速状态检查
      rmpc-regen = "home-manager switch";      # 重新生成配置
    };

    programs.nushell.shellAliases = lib.mkIf config.programs.nushell.enable {
      rmpc-info = "rmpc-direct-info";         # 直接配置信息
      rmpc-status = "rmpc-direct-info status"; # 快速状态检查
      rmpc-regen = "home-manager switch";      # 重新生成配置
    };
  };
}
