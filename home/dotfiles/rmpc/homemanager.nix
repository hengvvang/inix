{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rmpc.enable && 
                    config.myHome.dotfiles.rmpc.method == "homemanager") {
    home.packages = with pkgs; [ rmpc ];
    
    # RMPC 配置文件 - Home Manager 方式管理
    home.file.".config/rmpc/config.ron".text = ''
      Config(
        // MPD 连接配置
        address: "127.0.0.1:6600",
        
        // 界面配置
        theme: Some(Theme(
          // 基础颜色配置
          primary_color: Some("#7aa2f7"),      // 蓝色主题
          secondary_color: Some("#bb9af7"),    // 紫色辅助
          tertiary_color: Some("#7dcfff"),     // 青色点缀
          
          // 文本颜色
          text_color: Some("#c0caf5"),         // 前景文本
          text_color_dim: Some("#565f89"),     // 暗淡文本
          text_color_bright: Some("#ffffff"),   // 亮文本
          
          // 背景颜色
          background_color: Some("#1a1b26"),   // 主背景
          background_color_alt: Some("#24283b"), // 备用背景
          
          // 状态颜色
          success_color: Some("#9ece6a"),      // 成功绿色
          warning_color: Some("#e0af68"),      // 警告黄色
          error_color: Some("#f7768e"),        // 错误红色
          
          // 高亮颜色
          highlight_color: Some("#364a82"),    // 选中高亮
          highlight_color_alt: Some("#414868"), // 备用高亮
        )),
        
        // 键绑定配置
        keybinds: Some(KeyBinds(
          // 全局键绑定
          global: {
            // 基本播放控制
            "ctrl+c": "Quit",                  // 退出程序
            "space": "TogglePause",           // 播放/暂停
            "n": "NextSong",                  // 下一首
            "p": "PreviousSong",             // 上一首
            "r": "ToggleRepeat",             // 切换重复模式
            "z": "ToggleRandom",             // 切换随机播放
            "s": "Stop",                      // 停止播放
            
            // 音量控制
            "+": "VolumeUp",                 // 音量增加
            "-": "VolumeDown",               // 音量减少
            "m": "ToggleMute",               // 静音切换
            
            // 界面导航
            "1": "SwitchToQueueTab",         // 切换到队列标签页
            "2": "SwitchToLibraryTab",       // 切换到音乐库标签页
            "3": "SwitchToSearchTab",        // 切换到搜索标签页
            "4": "SwitchToDirectoriesTab",   // 切换到目录标签页
            "5": "SwitchToArtistsTab",       // 切换到艺术家标签页
            "6": "SwitchToAlbumsTab",        // 切换到专辑标签页
            
            // 面板导航
            "h": "FocusLeft",                // 焦点左移
            "l": "FocusRight",               // 焦点右移
            "j": "Down",                     // 向下导航
            "k": "Up",                       // 向上导航
            "g": "Top",                      // 跳转到顶部
            "G": "Bottom",                   // 跳转到底部
            
            // 功能操作
            "enter": "Confirm",              // 确认/播放选中项
            "d": "Delete",                   // 删除选中项
            "a": "AddToQueue",               // 添加到队列
            "i": "AddToQueueNext",           // 添加到队列下一个位置
            "/": "Search",                   // 搜索
            "escape": "ClosePopup",          // 关闭弹窗
            "tab": "NextPanel",              // 切换到下个面板
            "shift+tab": "PrevPanel",        // 切换到上个面板
            
            // 专辑封面和信息
            "f": "ToggleAlbumArt",          // 切换专辑封面显示
            "F": "OpenAlbumArtFull",        // 全屏显示专辑封面
          },
          
          // 队列页面特定键绑定
          queue: {
            "c": "Clear",                    // 清空队列
            "ctrl+s": "Save",               // 保存队列为播放列表
          },
          
          // 搜索页面特定键绑定
          search: {
            "ctrl+f": "FocusInput",         // 聚焦搜索输入框
          },
        }),
        
        // 界面行为配置
        volume_step: 5,                      // 音量调节步长 (%)
        seek_step: 10,                       // 进度条跳转步长 (秒)
        scrolloff: 3,                        // 滚动偏移行数
        wrap_navigation: true,               // 导航边界换行
        
        // 专辑封面配置
        album_art: Some(AlbumArtConfig(
          max_size_px: Some((300, 300)),     // 最大显示尺寸
          method: Kitty,                     // 显示方法 (支持 Kitty 协议)
        )),
        
        // 行为配置
        select_current_song_on_change: true, // 歌曲切换时自动选中
        status_update_interval_ms: 1000,     // 状态更新间隔 (毫秒)
      )
    '';
  };
}
