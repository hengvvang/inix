# ==============================================================================
# rmpc (Rust MPD Client) Home Manager 配置模块
# ==============================================================================
#
# rmpc 是一个现代化的终端 MPD 客户端，使用 Rust 编写，提供：
# 
# 🎵 核心功能:
#   • 快速响应的 TUI 界面
#   • 多标签页音乐管理
#   • 专辑封面显示支持
#   • 实时音频可视化集成
#
# ⚡ 高级特性:
#   • Vim 风格键位绑定
#   • 歌曲变更桌面通知
#   • 歌词显示和管理
#   • 自定义主题支持
#
# 🔧 系统集成:
#   • MPD 服务自动连接
#   • 桌面环境集成
#   • 缓存和数据管理
#
# 配置示例:
#   myHome.dotfiles.rmpc = {
#     enable = true;
#     method = "homemanager";
#   };
#
# ==============================================================================
{ config, lib, pkgs, ... }:

let
  cfg = config.myHome.dotfiles.rmpc;
in
{
  config = lib.mkIf (config.myHome.dotfiles.enable && cfg.enable && cfg.method == "homemanager") {
    # ==================================================
    # 软件包安装配置
    # ==================================================
    home.packages = with pkgs; [
      rmpc          # 现代 Rust MPD 客户端 - 主程序
      cava          # 终端音频可视化器 - 配合使用效果更佳
      libnotify     # 桌面通知支持 - 歌曲切换提醒
    ];

    # ==================================================
    # rmpc 主配置文件 (RON 格式)
    # ==================================================
    home.file.".config/rmpc/config.ron".text = ''
      #![enable(implicit_some)]
      #![enable(unwrap_newtypes)]
      #![enable(unwrap_variant_newtypes)]
      (
          // ==================== 连接配置 ====================
          // MPD 服务器连接地址和端口
          address: "127.0.0.1:6600",
          password: None,                    // 无密码访问（本地连接）
          
          // ==================== 目录配置 ====================
          // 缓存目录 - 存储临时数据和封面缓存
          cache_dir: "${config.home.homeDirectory}/.cache/rmpc",
          // 歌词目录 - 存储下载的歌词文件
          lyrics_dir: "${config.home.homeDirectory}/.local/share/rmpc/lyrics",
          
          // ==================== 界面配置 ====================
          theme: None,                       // 使用默认主题（跟随终端配色）
          max_fps: 30,                       // 最大刷新率 - 平衡性能和响应
          scrolloff: 3,                      // 滚动偏移量 - 类似 Vim 的 scrolloff
          wrap_navigation: true,             // 列表导航循环wrap
          enable_mouse: true,                // 启用鼠标支持
          enable_config_hot_reload: true,    // 配置文件热重载
          
          // ==================== 播放控制配置 ====================
          volume_step: 5,                           // 音量调节步长（5%）
          rewind_to_start_sec: 3,                   // 倒退到开头的秒数阈值
          status_update_interval_ms: 500,           // 状态更新间隔（毫秒）
          select_current_song_on_change: true,      // 歌曲切换时自动选中
          center_current_song_on_change: true,      // 歌曲切换时居中显示
          
          // ==================== 网络超时配置 ====================
          mpd_read_timeout_ms: 10000,        // MPD 读取超时（10秒）
          mpd_write_timeout_ms: 5000,        // MPD 写入超时（5秒）
          mpd_idle_read_timeout_ms: None,    // 空闲读取无超时
          
          // ==================== 播放列表同步 ====================
          // 禁用自动同步到播放列表（避免意外修改）
          reflect_changes_to_playlist: false,
          
          // ==================== 专辑封面配置 ====================
          album_art: (
              method: Auto,                       // 自动检测封面来源
              max_size_px: (width: 800, height: 800),  // 最大封面尺寸
              disabled_protocols: ["http://", "https://"],  // 禁用网络封面（安全考虑）
              vertical_align: Center,             // 垂直居中对齐
              horizontal_align: Center,           // 水平居中对齐
          ),
          
          // ==================== 桌面通知配置 ====================
          // 歌曲切换时的桌面通知命令
          on_song_change: [
              "notify-send", 
              "--expire-time=3000",               // 通知显示3秒
              "--icon=audio-x-generic", 
              "♪ 正在播放", 
              "{artist} - {title}"                // 显示艺术家和曲目
          ],
          
          // ==================== 搜索配置 ====================
          search: (
              case_sensitive: false,              // 不区分大小写搜索
              mode: Contains,                     // 包含模式搜索
              // 搜索标签定义 - 支持的元数据字段
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
          // 艺术家视图配置
          artists: (
              album_display_mode: SplitByDate,    // 按日期分割专辑显示
              album_sort_by: Date,                // 专辑按日期排序
          ),
          
          // 浏览器中歌曲排序优先级：碟片 -> 轨道 -> 艺术家 -> 标题
          browser_song_sort: [Disc, Track, Artist, Title],
          
          // 目录排序：按类型分组，正序排列
          directories_sort: SortFormat(group_by_type: true, reverse: false),
          
          // 在浏览器中显示播放列表（仅非根目录）
          show_playlists_in_browser: NonRoot,
          
          // ==================== 键位绑定配置 ====================
          keybinds: (
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
          // 定义用户界面的标签页布局和面板配置
          tabs: [
              // 播放队列标签页 - 主界面，显示封面和队列
              (
                  name: "Queue",
                  pane: Split(
                      direction: Horizontal,      // 水平分割布局
                      panes: [
                          // 左侧：专辑封面显示（35% 宽度）
                          (size: "35%", pane: Pane(AlbumArt)),
                          // 右侧：播放队列（65% 宽度）
                          (size: "65%", pane: Pane(Queue)),
                      ],
                  ),
              ),
              // 目录浏览标签页 - 文件系统浏览
              (
                  name: "Directories",
                  pane: Pane(Directories),
              ),
              // 艺术家标签页 - 按艺术家浏览音乐
              (
                  name: "Artists",
                  pane: Pane(Artists),
              ),
              // 专辑艺术家标签页 - 按专辑艺术家浏览
              (
                  name: "Album Artists",
                  pane: Pane(AlbumArtists),
              ),
              // 专辑标签页 - 按专辑浏览音乐
              (
                  name: "Albums",
                  pane: Pane(Albums),
              ),
              // 播放列表标签页 - 管理自定义播放列表
              (
                  name: "Playlists",
                  pane: Pane(Playlists),
              ),
              // 搜索标签页 - 音乐搜索功能
              (
                  name: "Search",
                  pane: Pane(Search),
              ),
          ],
      )
    '';

    # ==================================================
    # 系统目录和文件创建
    # ==================================================
    # 创建 rmpc 运行所需的目录结构
    home.file.".cache/rmpc/.keep".text = "";                    # 缓存目录标记文件
    home.file.".local/share/rmpc/lyrics/.keep".text = "";       # 歌词目录标记文件

    # ==================================================
    # 桌面环境集成
    # ==================================================
    # 创建桌面启动器 - 在应用菜单中显示 rmpc
    home.file.".local/share/applications/rmpc.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=rmpc
      Comment=现代化终端 MPD 客户端
      Exec=${pkgs.rmpc}/bin/rmpc
      Icon=multimedia-audio-player
      Categories=AudioVideo;Audio;Player;
      Terminal=true
      StartupNotify=false
      Keywords=music;audio;player;mpd;terminal;rust;
    '';

    # ==================================================
    # 便捷启动脚本
    # ==================================================
    # rmpc 启动包装脚本 - 确保目录存在并提供额外功能
    home.file.".local/bin/rmpc-wrapper" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        # ==============================================================================
        # rmpc 启动包装脚本
        # ==============================================================================
        # 
        # 功能:
        #   • 自动创建必要的目录
        #   • 检查 MPD 服务状态
        #   • 提供友好的错误信息
        #
        # 用法: rmpc-wrapper [rmpc选项...]
        #
        # ==============================================================================
        
        # 创建必要目录
        echo "🔧 准备 rmpc 运行环境..."
        mkdir -p "$HOME/.cache/rmpc"
        mkdir -p "$HOME/.local/share/rmpc/lyrics"
        
        # 检查 MPD 连接（可选）
        if command -v mpc >/dev/null 2>&1; then
            if ! mpc status >/dev/null 2>&1; then
                echo "⚠️  警告: 无法连接到 MPD 服务"
                echo "💡 提示: 请确保 MPD 服务正在运行"
                echo "   检查命令: systemctl status mpd"
                echo ""
            else
                echo "✅ MPD 连接正常"
            fi
        fi
        
        # 启动 rmpc
        echo "🎵 启动 rmpc..."
        exec ${pkgs.rmpc}/bin/rmpc "$@"
      '';
    };
  };
}
