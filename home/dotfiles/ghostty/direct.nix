{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.ghostty.enable && config.myHome.dotfiles.ghostty.method == "direct") {
    # Ghostty 终端配置文件
    home.file.".config/ghostty/config".text = ''
      # Ghostty 终端配置
      
      # 字体设置
      font-family = "FiraCode Nerd Font"
      font-size = 12
      font-feature = +ss01
      font-feature = +ss02
      font-feature = +ss03
      font-feature = +ss04
      font-feature = +ss05
      font-feature = +ss06
      font-feature = +ss07
      font-feature = +ss08
      font-feature = +ss09
      font-feature = +ss10
      font-feature = +cv01
      font-feature = +cv02
      font-feature = +cv05
      font-feature = +cv09
      font-feature = +cv10
      font-feature = +cv11
      font-feature = +cv12
      font-feature = +cv13
      font-feature = +cv14
      
      # 窗口设置
      window-padding-x = 8
      window-padding-y = 8
      window-decoration = true
      window-opacity = 0.95
      window-title-font-family = "FiraCode Nerd Font"
      
      # 主题设置 (Catppuccin Macchiato)
      background = 24273a
      foreground = cad3f5
      cursor-color = f4dbd6
      selection-background = 5b6078
      selection-foreground = cad3f5
      
      # 黑色
      palette = 0=#494d64
      palette = 8=#5b6078
      
      # 红色
      palette = 1=#ed8796
      palette = 9=#ed8796
      
      # 绿色
      palette = 2=#a6da95
      palette = 10=#a6da95
      
      # 黄色
      palette = 3=#eed49f
      palette = 11=#eed49f
      
      # 蓝色
      palette = 4=#8aadf4
      palette = 12=#8aadf4
      
      # 洋红色
      palette = 5=#f5bde6
      palette = 13=#f5bde6
      
      # 青色
      palette = 6=#8bd5ca
      palette = 14=#8bd5ca
      
      # 白色
      palette = 7=#b8c0e0
      palette = 15=#a5adcb
      
      # 终端设置
      scrollback-limit = 100000
      mouse-hide-while-typing = true
      copy-on-select = false
      confirm-close-surface = false
      shell-integration = fish
      
      # 键位绑定
      keybind = ctrl+shift+c=copy_to_clipboard
      keybind = ctrl+shift+v=paste_from_clipboard
      keybind = ctrl+shift+t=new_tab
      keybind = ctrl+shift+w=close_surface
      keybind = ctrl+shift+n=new_window
      keybind = ctrl+shift+enter=new_split:right
      keybind = ctrl+shift+minus=new_split:down
      keybind = ctrl+shift+left=goto_split:left
      keybind = ctrl+shift+right=goto_split:right
      keybind = ctrl+shift+up=goto_split:up
      keybind = ctrl+shift+down=goto_split:down
      keybind = ctrl+shift+equal=increase_font_size:1
      keybind = ctrl+shift+minus=decrease_font_size:1
      keybind = ctrl+shift+zero=reset_font_size
      keybind = ctrl+shift+page_up=scroll_page_up
      keybind = ctrl+shift+page_down=scroll_page_down
      keybind = ctrl+shift+home=scroll_to_top
      keybind = ctrl+shift+end=scroll_to_bottom
      
      # 标签页设置
      gtk-tabs-location = top
      tab-width = 200
      
      # 性能设置
      unfocused-split-opacity = 0.7
      resize-overlay = true
      resize-overlay-position = center
      resize-overlay-duration = 500
      
      # 铃声设置
      audio-bell = false
      visual-bell = true
      visual-bell-color = f5a97f
      visual-bell-duration = 100
      
      # 光标设置
      cursor-style = block
      cursor-style-blink = false
      
      # 链接处理
      auto-update = check
      auto-update-channel = tip
      
      # 工作目录
      working-directory = inherit
      
      # 自定义命令
      command = fish
    '';
    
    # Ghostty 主题目录
    home.file.".config/ghostty/themes/.keep".text = "";
  };
}
