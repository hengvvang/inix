{ config, lib, pkgs, ... }:

let
  cfg = config.myHome.dotfiles.rmpc;
  
  # 根据主题选择确定主题配置
  themeConfig = if cfg.theme == "default" then null else cfg.theme;
  
  # 主题文件映射
  rosePineTheme = ./configs/themes/rose-pine.ron;
  rosePineDawnTheme = ./configs/themes/rose-pine-dawn.ron;
  rosePineMoonTheme = ./configs/themes/rose-pine-moon.ron;
in
{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rmpc.enable && 
                    config.myHome.dotfiles.rmpc.method == "homemanager") {
    home.packages = with pkgs; [ rmpc ];
    
    # RMPC 配置文件 - Home Manager 方式管理
    home.file.".config/rmpc/config.ron".text = ''
      #![enable(implicit_some)]
      #![enable(unwrap_newtypes)]
      #![enable(unwrap_variant_newtypes)]
      (
        // MPD 连接配置
        address: "127.0.0.1:6600",
        password: None,
        
        // 主题配置
        theme: ${if themeConfig != null then ''"${themeConfig}"'' else "None"},
        
        // 缓存和歌词目录
        cache_dir: None,
        
        // 界面行为配置
        volume_step: 5,                  // 音量调节步长 (%)
        max_fps: 60,                     // 最大帧率
        scrolloff: 3,                    // 滚动偏移行数
        wrap_navigation: true,           // 导航边界换行
        enable_mouse: true,              // 启用鼠标支持
        enable_config_hot_reload: true,  // 启用配置热重载
        
        // 播放器行为
        status_update_interval_ms: 1000,       // 状态更新间隔
        select_current_song_on_change: true,   // 歌曲切换时自动选中
        rewind_to_start_sec: 3,               // 重新开始播放的阈值 (秒)
        reflect_changes_to_playlist: false,    // 反映播放列表更改
        
        // 浏览器歌曲排序
        browser_song_sort: [Disc, Track, Artist, Title],
        
        // 目录排序
        directories_sort: SortFormat(group_by_type: true, reverse: false),
        
        // 专辑封面配置
        album_art: (
          method: Auto,                        // 自动检测显示方法
          max_size_px: (width: 300, height: 300),  // 最大显示尺寸
          disabled_protocols: ["http://", "https://"],
          vertical_align: Center,
          horizontal_align: Center,
        ),
        
        // 键绑定配置 - Vim 风格
        keybinds: (
          global: {
            // 退出和帮助
            "q":         Quit,                 // 退出程序
            "~":         ShowHelp,            // 显示帮助
            
            // 播放控制
            "p":         TogglePause,         // 播放/暂停
            "<Space>":   TogglePause,         // 播放/暂停（备用）
            ">":         NextTrack,           // 下一首
            "<":         PreviousTrack,       // 上一首
            "s":         Stop,                // 停止播放
            
            // 音量控制
            "+":         VolumeUp,            // 音量增加
            "-":         VolumeDown,          // 音量减少
            ".":         VolumeUp,            // 音量增加（备用）
            ",":         VolumeDown,          // 音量减少（备用）
            
            // 播放模式
            "z":         ToggleRepeat,        // 切换重复模式
            "x":         ToggleRandom,        // 切换随机播放
            "c":         ToggleConsume,       // 切换消费模式
            "v":         ToggleSingle,        // 切换单曲模式
            
            // 进度控制
            "f":         SeekForward,         // 快进
            "b":         SeekBack,            // 快退
            
            // 标签页切换
            "1":         SwitchToTab("Queue"),           // 队列
            "2":         SwitchToTab("Directories"),     // 目录
            "3":         SwitchToTab("Artists"),         // 艺术家
            "4":         SwitchToTab("Album Artists"),   // 专辑艺术家
            "5":         SwitchToTab("Albums"),          // 专辑
            "6":         SwitchToTab("Playlists"),       // 播放列表
            "7":         SwitchToTab("Search"),          // 搜索
            "<Tab>":     NextTab,                        // 下一标签页
            "<S-Tab>":   PreviousTab,                    // 上一标签页
            
            // 信息和管理
            "I":         ShowCurrentSongInfo, // 显示当前歌曲信息
            "O":         ShowOutputs,         // 显示输出设备
            "u":         Update,              // 更新数据库
            "U":         Rescan,              // 重新扫描
            "R":         AddRandom,           // 添加随机歌曲
          },
          
          navigation: {
            // Vim 风格导航
            "k":         Up,                  // 向上
            "j":         Down,                // 向下
            "h":         Left,                // 向左
            "l":         Right,               // 向右
            
            // 快速移动
            "g":         Top,                 // 跳转到顶部
            "G":         Bottom,              // 跳转到底部
            "<C-u>":     UpHalf,             // 向上半页
            "<C-d>":     DownHalf,           // 向下半页
            
            // 面板导航
            "<C-h>":     PaneLeft,           // 左侧面板
            "<C-l>":     PaneRight,          // 右侧面板
            "<C-k>":     PaneUp,             // 上方面板
            "<C-j>":     PaneDown,           // 下方面板
            
            // 选择操作
            "<Space>":   Select,             // 选择项目
            "<C-Space>": InvertSelection,    // 反选
            "<CR>":      Confirm,            // 确认
            
            // 功能操作
            "a":         Add,                // 添加
            "A":         AddAll,             // 添加全部
            "D":         Delete,             // 删除
            "r":         Rename,             // 重命名
            "B":         ShowInfo,           // 显示信息
            
            // 移动和搜索
            "J":         MoveDown,           // 向下移动
            "K":         MoveUp,             // 向上移动
            "/":         EnterSearch,        // 进入搜索
            "n":         NextResult,         // 下一个搜索结果
            "N":         PreviousResult,     // 上一个搜索结果
            
            // 输入和关闭
            "i":         FocusInput,         // 聚焦输入框
            "<Esc>":     Close,              // 关闭
            "<C-c>":     Close,              // 关闭（备用）
          },
          
          queue: {
            "<CR>":      Play,               // 播放选中歌曲
            "d":         Delete,             // 删除选中项
            "D":         DeleteAll,          // 清空队列
            "C":         JumpToCurrent,      // 跳转到当前歌曲
            "X":         Shuffle,            // 随机排序
            "<C-s>":     Save,               // 保存为播放列表
            "a":         AddToPlaylist,      // 添加到播放列表
          },
        ),
        
        // 搜索配置
        search: (
          case_sensitive: false,             // 不区分大小写
          mode: Contains,                    // 包含模式
          tags: [
            (value: "any",         label: "任意标签"),
            (value: "artist",      label: "艺术家"),
            (value: "album",       label: "专辑"),
            (value: "albumartist", label: "专辑艺术家"),
            (value: "title",       label: "标题"),
            (value: "filename",    label: "文件名"),
            (value: "genre",       label: "流派"),
          ],
        ),
        
        // 艺术家显示配置
        artists: (
          album_display_mode: SplitByDate,   // 按日期分割显示
          album_sort_by: Date,               // 按日期排序
        ),
        
        // 标签页布局配置
        tabs: [
          (
            name: "Queue",
            pane: Split(
              direction: Horizontal,
              panes: [
                (size: "40%", pane: Pane(AlbumArt)),  // 专辑封面占 40%
                (size: "60%", pane: Pane(Queue))      // 队列占 60%
              ],
            ),
          ),
          (
            name: "Directories",
            pane: Pane(Directories),
          ),
          (
            name: "Artists", 
            pane: Pane(Artists),
          ),
          (
            name: "Album Artists",
            pane: Pane(AlbumArtists),
          ),
          (
            name: "Albums",
            pane: Pane(Albums),
          ),
          (
            name: "Playlists",
            pane: Pane(Playlists),
          ),
          (
            name: "Search",
            pane: Pane(Search),
          ),
        ],
      )
    '';
    
    # 主题文件 - 根据选择复制对应主题
    home.file.".config/rmpc/themes/rose-pine.ron" = lib.mkIf (cfg.theme == "rose-pine") {
      source = rosePineTheme;
    };
    
    home.file.".config/rmpc/themes/rose-pine-dawn.ron" = lib.mkIf (cfg.theme == "rose-pine-dawn") {
      source = rosePineDawnTheme;
    };
    
    home.file.".config/rmpc/themes/rose-pine-moon.ron" = lib.mkIf (cfg.theme == "rose-pine-moon") {
      source = rosePineMoonTheme;
    };
  };
}
