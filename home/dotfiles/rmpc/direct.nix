# rmpc 直接配置方式
{ config, lib, pkgs, ... }:

let
  cfg = config.myHome.dotfiles.rmpc;
  
  rmpcConfigContent = ''
    #![enable(implicit_some)]
    #![enable(unwrap_newtypes)]
    #![enable(unwrap_variant_newtypes)]
    (
        address: "127.0.0.1:6600",
        password: None,
        cache_dir: "${config.home.homeDirectory}/.cache/rmpc",
        lyrics_dir: "${config.home.homeDirectory}/.local/share/rmpc/lyrics",
        theme: None,
        max_fps: 30,
        scrolloff: 3,
        wrap_navigation: true,
        enable_mouse: true,
        enable_config_hot_reload: true,
        volume_step: 5,
        rewind_to_start_sec: 3,
        status_update_interval_ms: 500,
        select_current_song_on_change: true,
        center_current_song_on_change: true,
        mpd_read_timeout_ms: 10000,
        mpd_write_timeout_ms: 5000,
        mpd_idle_read_timeout_ms: None,
        reflect_changes_to_playlist: false,
        album_art: (
            method: Auto,
            max_size_px: (width: 800, height: 800),
            disabled_protocols: ["http://", "https://"],
            vertical_align: Center,
            horizontal_align: Center,
        ),
        on_song_change: ["notify-send", "--expire-time=3000", "--icon=audio-x-generic", "♪ 正在播放", "{artist} - {title}"],
        on_resize: None,
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
        artists: (
            album_display_mode: SplitByDate,
            album_sort_by: Date,
        ),
        browser_song_sort: [Disc, Track, Artist, Title],
        directories_sort: SortFormat(group_by_type: true, reverse: false),
        show_playlists_in_browser: NonRoot,
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
in
{
  config = lib.mkIf (config.myHome.dotfiles.enable && cfg.enable && cfg.method == "direct") {
    # 安装 rmpc
    home.packages = with pkgs; [
      rmpc
      cava
      libnotify
    ];

    # 使用激活脚本直接写入配置文件
    home.activation.rmpc = lib.hm.dag.entryAfter ["writeBoundary"] ''
      # 创建配置目录
      $DRY_RUN_CMD mkdir -p "$HOME/.config/rmpc"
      $DRY_RUN_CMD mkdir -p "$HOME/.cache/rmpc"
      $DRY_RUN_CMD mkdir -p "$HOME/.local/share/rmpc/lyrics"
      
      # 写入配置文件
      $DRY_RUN_CMD cat > "$HOME/.config/rmpc/config.ron" << 'EOF'
      ${rmpcConfigContent}
      EOF
      
      echo "rmpc 配置文件已通过直接方式创建"
    '';

    # 创建脚本和桌面文件
    home.file.".local/bin/rmpc-wrapper" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        # rmpc 直接配置启动脚本
        
        # 确保配置文件存在
        if [ ! -f "$HOME/.config/rmpc/config.ron" ]; then
          echo "错误: rmpc 配置文件不存在"
          echo "请运行 home-manager switch 重新生成配置"
          exit 1
        fi
        
        # 启动 rmpc
        exec ${pkgs.rmpc}/bin/rmpc "$@"
      '';
    };

    home.file.".local/share/applications/rmpc.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=rmpc (直接配置)
      Comment=终端音乐播放器客户端 (直接配置方式)
      Exec=rmpc-wrapper
      Icon=multimedia-audio-player
      Categories=AudioVideo;Audio;Player;
      Terminal=true
      StartupNotify=false
    '';
  };
}
