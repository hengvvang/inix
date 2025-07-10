{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.ghostty.enable && config.myHome.dotfiles.ghostty.method == "direct") {
    home.file.".config/ghostty/config".text = ''
      # Ghostty 基础配置
      
      # 字体设置
      font-family = "JetBrains Mono"
      font-size = 12
      
      # 主题设置
      theme = "catppuccin-mocha"
      
      # 窗口设置
      window-decoration = false
      window-padding-x = 4
      window-padding-y = 4
      
      # 光标设置
      cursor-style = block
      cursor-style-blink = false
      
      # 滚动设置
      scrollback-limit = 10000
      
      # 快捷键绑定
      keybind = ctrl+shift+c=copy_to_clipboard
      keybind = ctrl+shift+v=paste_from_clipboard
      keybind = ctrl+shift+t=new_tab
      keybind = ctrl+shift+w=close_surface
      keybind = ctrl+shift+n=new_window
      keybind = ctrl+equal=increase_font_size:1
      keybind = ctrl+minus=decrease_font_size:1
      keybind = ctrl+zero=reset_font_size
    '';
  };
}
