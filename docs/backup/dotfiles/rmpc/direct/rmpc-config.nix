{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rmpc.enable && config.myHome.dotfiles.rmpc.method == "direct") {
    
    home.file.".config/rmpc/config.toml" = {
      text = ''
        # RMPC (Rust Music Player Client) 配置文件
        # 配置方式: direct - 直接文件配置

        [mpd]
        # MPD 服务器连接设置
        host = "localhost"
        port = 6600
        password = ""  # 如果没有密码则留空
        timeout = 10   # 连接超时时间（秒）
        
        [ui]
        # 界面设置
        layout = "default"
        show_album_art = true
        album_art_position = "right"
        show_status_bar = true
        show_volume = true
        show_progress = true
        
        # 窗口设置
        fullscreen = false
        minimal_ui = false
        
        [appearance]
        # 外观主题 - GitHub Dark
        theme = "custom"
        
        [colors]
        # 自定义颜色主题
        background = "#0d1117"
        foreground = "#c9d1d9"
        accent = "#58a6ff"
        secondary = "#21262d"
        highlight = "#30363d"
        error = "#ff7b72"
        warning = "#f0883e"
        success = "#7ee787"
        
        # 文本颜色
        primary_text = "#c9d1d9"
        secondary_text = "#7d8590"
        muted_text = "#6e7681"
        
        # 界面元素颜色
        border = "#30363d"
        selection = "#58a6ff"
        cursor = "#58a6ff"
        
        [keys]
        # 键盘快捷键设置
        # 播放控制
        play_pause = "space"
        stop = "s"
        next = "n"
        previous = "p"
        
        # 音量控制
        volume_up = "+"
        volume_down = "-"
        mute = "m"
        
        # 导航
        move_up = "k"
        move_down = "j"
        move_left = "h"
        move_right = "l"
        page_up = "ctrl+b"
        page_down = "ctrl+f"
        
        # 选择和操作
        select = "enter"
        back = "escape"
        add_to_queue = "a"
        remove_from_queue = "d"
        clear_queue = "c"
        
        # 搜索
        search = "/"
        search_next = "n"
        search_prev = "N"
        
        # 界面切换
        toggle_queue = "q"
        toggle_library = "l"
        toggle_playlists = "p"
        toggle_help = "?"
        
        # 应用控制
        quit = "q"
        refresh = "r"
        
        [behavior]
        # 行为设置
        auto_save_queue = true
        save_queue_on_exit = true
        restore_queue_on_start = true
        
        # 播放行为
        repeat = false
        random = false
        single = false
        consume = false
        
        # 搜索行为
        search_delay = 500  # 搜索延迟（毫秒）
        case_sensitive_search = false
        
        [display]
        # 显示设置
        time_format = "%M:%S"
        date_format = "%Y-%m-%d"
        
        # 歌曲信息显示格式
        song_format = "{artist} - {title}"
        album_format = "{albumartist} - {album} ({date})"
        
        # 列表显示
        show_track_numbers = true
        show_duration = true
        show_file_type = false
        
        [library]
        # 音乐库设置
        sort_by = "artist"
        sort_order = "ascending"
        group_by_album = true
        show_all_artists = true
        
        [queue]
        # 队列设置
        max_queue_size = 1000
        auto_scroll_to_current = true
        remove_played_songs = false
        
        [performance]
        # 性能设置
        update_interval = 1000  # 界面更新间隔（毫秒）
        cache_size = 100        # 缓存大小（MB）
        lazy_loading = true     # 延迟加载
        
        [logging]
        # 日志设置
        level = "info"
        file = "~/.local/share/rmpc/rmpc.log"
        max_size = "10MB"
        
        [plugins]
        # 插件设置（如果支持）
        enable_lyrics = true
        enable_scrobbling = false
        enable_notifications = true
        
        [network]
        # 网络设置
        connection_retry = 3
        connection_delay = 2000  # 重连延迟（毫秒）
        keep_alive = true
      '';
    };
    
    # 创建必要的目录
    home.file.".local/share/rmpc/.gitkeep" = {
      text = "";
    };
  };
}
