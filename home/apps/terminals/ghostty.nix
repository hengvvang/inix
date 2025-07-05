{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.apps.terminals.ghostty {
    # Ghostty 终端配置 - 现代 GPU 加速终端
    home.packages = with pkgs; [
      ghostty                  # Ghostty 终端
    ];
  
  # Ghostty 配置文件
  home.file.".config/ghostty/config".text = ''
    # Ghostty 终端配置
    
    # 字体设置
    font-family = "FiraCode Nerd Font"
    font-size = 12
    font-feature = ss01
    font-feature = ss02
    font-feature = ss03
    font-feature = ss04
    font-feature = ss05
    
    # 窗口设置
    window-padding-x = 8
    window-padding-y = 8
    window-decoration = true
    window-opacity = 0.95
    
    # 主题设置 (One Dark)
    background = 1e1e1e
    foreground = abb2bf
    cursor-color = 528bff
    
    # 普通颜色
    palette = 0=#1e1e1e
    palette = 1=#e06c75
    palette = 2=#98c379
    palette = 3=#e5c07b
    palette = 4=#61afef
    palette = 5=#c678dd
    palette = 6=#56b6c2
    palette = 7=#abb2bf
    
    # 明亮颜色
    palette = 8=#5c6370
    palette = 9=#e06c75
    palette = 10=#98c379
    palette = 11=#e5c07b
    palette = 12=#61afef
    palette = 13=#c678dd
    palette = 14=#56b6c2
    palette = 15=#ffffff
    
    # 行为设置
    scrollback-limit = 10000
    mouse-hide-while-typing = true
    copy-on-select = true
    confirm-close-surface = false
    
    # Shell 设置
    command = fish
    
    # 快捷键绑定
    keybind = ctrl+shift+c=copy_to_clipboard
    keybind = ctrl+shift+v=paste_from_clipboard
    keybind = ctrl+shift+n=new_window
    keybind = ctrl+shift+t=new_tab
    keybind = ctrl+shift+w=close_surface
    keybind = ctrl+shift+f=toggle_fullscreen
    keybind = ctrl+plus=increase_font_size:1
    keybind = ctrl+minus=decrease_font_size:1
    keybind = ctrl+zero=reset_font_size
  '';
  
  # Ghostty 专用别名
  home.shellAliases = {
    "ghost" = "ghostty";
    "ghostty-config" = "$EDITOR ~/.config/ghostty/config";
  };
  };
}
