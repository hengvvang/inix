# rmpc Home Manager 配置
{ config, lib, pkgs, ... }:

let
  cfg = config.myHome.dotfiles.rmpc;
in
{
  config = lib.mkIf (config.myHome.dotfiles.enable && cfg.enable && cfg.method == "homemanager") {
    # 安装 rmpc 和相关工具
    home.packages = with pkgs; [
      rmpc          # 终端音乐播放器客户端
      cava          # 终端音频可视化器（可选）
      libnotify     # 桌面通知支持
    ];

    # rmpc 配置文件
    home.file.".config/rmpc/config.ron".text = ''
      #![enable(implicit_some)]
      #![enable(unwrap_newtypes)]
      #![enable(unwrap_variant_newtypes)]
      (
          // MPD 连接配置
          address: "127.0.0.1:6600",
          password: None,
          
          // 缓存和存储目录
          cache_dir: "${config.home.homeDirectory}/.cache/rmpc",
          lyrics_dir: "${config.home.homeDirectory}/.local/share/rmpc/lyrics",
          
          // 界面配置
          theme: None,
          max_fps: 30,
          scrolloff: 3,
          wrap_navigation: true,
          enable_mouse: true,
          enable_config_hot_reload: true,
          
          // 播放控制
          volume_step: 5,
          rewind_to_start_sec: 3,
          status_update_interval_ms: 500,
          select_current_song_on_change: true,
          center_current_song_on_change: true,
          
          // 超时设置
          mpd_read_timeout_ms: 10000,
          mpd_write_timeout_ms: 5000,
          mpd_idle_read_timeout_ms: None,
          
          // 播放列表同步
          reflect_changes_to_playlist: false,
          
          // 专辑封面配置
          album_art: (
              method: Auto,
              max_size_px: (width: 800, height: 800),
              disabled_protocols: ["http://", "https://"],
              vertical_align: Center,
              horizontal_align: Center,
          ),
          
          // 歌曲变更通知
          on_song_change: ["notify-send", "--expire-time=3000", "--icon=audio-x-generic", "♪ 正在播放", "{artist} - {title}"],
          
          // 搜索配置
          search: (
              case_sensitive: false,
              mode: Contains,
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
          
          // 艺术家视图配置
          artists: (
              album_display_mode: SplitByDate,
              album_sort_by: Date,
          ),
          
          // 浏览器歌曲排序
          browser_song_sort: [Disc, Track, Artist, Title],
          
          // 目录排序
          directories_sort: SortFormat(group_by_type: true, reverse: false),
          
          // 播放列表显示
          show_playlists_in_browser: NonRoot,
          
          // 自定义键位绑定
          keybinds: (
              global: {
                  ":": CommandMode,
                  ",": VolumeDown,
                  ".": VolumeUp,
                  "s": Stop,
                  "p": TogglePause,
                  ">": NextTrack,
                  "<": PreviousTrack,
                  "f": SeekForward,
                  "b": SeekBack,
                  "z": ToggleRepeat,
                  "x": ToggleRandom,
                  "c": ToggleConsume,
                  "v": ToggleSingle,
                  "q": Quit,
                  "~": ShowHelp,
                  "u": Update,
                  "U": Rescan,
                  "I": ShowCurrentSongInfo,
                  "O": ShowOutputs,
                  "P": ShowDecoders,
                  "R": AddRandom,
                  "<Tab>": NextTab,
                  "<S-Tab>": PreviousTab,
                  "1": SwitchToTab("Queue"),
                  "2": SwitchToTab("Directories"),
                  "3": SwitchToTab("Artists"),
                  "4": SwitchToTab("Album Artists"),
                  "5": SwitchToTab("Albums"),
                  "6": SwitchToTab("Playlists"),
                  "7": SwitchToTab("Search"),
              },
              navigation: {
                  "k": Up,
                  "j": Down,
                  "h": Left,
                  "l": Right,
                  "<Up>": Up,
                  "<Down>": Down,
                  "<Left>": Left,
                  "<Right>": Right,
                  "<C-k>": PaneUp,
                  "<C-j>": PaneDown,
                  "<C-h>": PaneLeft,
                  "<C-l>": PaneRight,
                  "<C-u>": UpHalf,
                  "<C-d>": DownHalf,
                  "g": Top,
                  "G": Bottom,
                  "<CR>": Confirm,
                  "<Space>": Select,
                  "<C-Space>": InvertSelection,
                  "a": Add,
                  "A": AddAll,
                  "d": Delete,
                  "D": Delete,
                  "r": Rename,
                  "i": FocusInput,
                  "/": EnterSearch,
                  "n": NextResult,
                  "N": PreviousResult,
                  "J": MoveDown,
                  "K": MoveUp,
                  "B": ShowInfo,
                  "<C-c>": Close,
                  "<Esc>": Close,
                  "<C-z>": ContextMenu(),
              },
              queue: {
                  "<CR>": Play,
                  "d": Delete,
                  "D": DeleteAll,
                  "a": AddToPlaylist,
                  "C": JumpToCurrent,
                  "X": Shuffle,
                  "<C-s>": Save,
              },
          ),
          
          // 标签页布局配置
          tabs: [
              (
                  name: "Queue",
                  pane: Split(
                      direction: Horizontal,
                      panes: [
                          (size: "35%", pane: Pane(AlbumArt)),
                          (size: "65%", pane: Pane(Queue)),
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

    # 创建必要的目录
    home.file.".cache/rmpc/.keep".text = "";
    home.file.".local/share/rmpc/lyrics/.keep".text = "";

    # 创建桌面启动器
    home.file.".local/share/applications/rmpc.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=rmpc
      Comment=终端音乐播放器客户端
      Exec=${pkgs.rmpc}/bin/rmpc
      Icon=multimedia-audio-player
      Categories=AudioVideo;Audio;Player;
      Terminal=true
      StartupNotify=false
      Keywords=music;audio;player;mpd;terminal;
    '';

    # 创建简单的 rmpc 启动包装脚本
    home.file.".local/bin/rmpc-wrapper" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        # rmpc 简单启动包装脚本
        
        # 创建必要目录
        mkdir -p "$HOME/.cache/rmpc"
        mkdir -p "$HOME/.local/share/rmpc/lyrics"
        
        # 启动 rmpc
        exec ${pkgs.rmpc}/bin/rmpc "$@"
      '';
    };
  };
}
