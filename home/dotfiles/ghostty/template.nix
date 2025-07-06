{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.ghostty.enable && config.myHome.dotfiles.ghostty.method == "template") {
    # 方式4: 模板化配置
    home.file.".config/ghostty/config".text = 
      let
        cfg = config.myHome.dotfiles.ghostty;
      in ''
        # Ghostty 终端配置 - 模板化配置
        
        # 字体设置
        font-family = "${cfg.fontFamily}"
        font-size = ${toString cfg.fontSize}
        
        # 主题设置
        theme = "${cfg.theme}"
        
        # 窗口设置
        window-opacity = ${toString cfg.opacity}
        window-decoration = ${cfg.windowDecorations}
        
        # 光标设置
        cursor-style = "${cfg.cursorStyle}"
        
        # 鼠标设置
        mouse-hide-while-typing = ${if cfg.mouseHideWhileTyping then "true" else "false"}
        
        # 选择设置
        copy-on-select = ${if cfg.copyOnSelect then "true" else "false"}
        
        # 滚动设置
        scrollback-limit = ${toString cfg.scrollbackLines}
        
        # Shell 设置
        shell-integration = true
        shell-integration-features = "cursor,sudo,title"
        
        # 默认命令
        command = "${cfg.shell}"
        
        # 快捷键设置
        keybind = ctrl+shift+c=copy_to_clipboard
        keybind = ctrl+shift+v=paste_from_clipboard
        keybind = ctrl+shift+n=new_window
        keybind = ctrl+shift+t=new_tab
        keybind = ctrl+shift+w=close_surface
        keybind = ctrl+shift+enter=toggle_fullscreen
        keybind = ctrl+shift+plus=increase_font_size:1
        keybind = ctrl+shift+minus=decrease_font_size:1
        keybind = ctrl+shift+zero=reset_font_size
        
        # 性能设置
        confirm-close-surface = false
        quit-after-last-window-closed = true
        
        # 渲染设置
        renderer = auto
        unfocused-split-opacity = 0.7
        
        # 调试设置 (可选)
        # gtk-single-instance = false
        
        # 自定义快捷键示例
        # keybind = ctrl+shift+o=open_config
        # keybind = ctrl+shift+r=reload_config
      '';
    
    # 创建主题目录和示例主题
    home.file.".config/ghostty/themes/custom.conf".text = ''
      # 自定义主题配置
      background = 1a1b26
      foreground = c0caf5
      cursor-color = c0caf5
      selection-background = 33467c
      selection-foreground = c0caf5
      
      # 标准颜色
      palette = 0=#15161e
      palette = 1=#f7768e
      palette = 2=#9ece6a
      palette = 3=#e0af68
      palette = 4=#7aa2f7
      palette = 5=#bb9af7
      palette = 6=#7dcfff
      palette = 7=#a9b1d6
      palette = 8=#414868
      palette = 9=#f7768e
      palette = 10=#9ece6a
      palette = 11=#e0af68
      palette = 12=#7aa2f7
      palette = 13=#bb9af7
      palette = 14=#7dcfff
      palette = 15=#c0caf5
    '';
  };
}
