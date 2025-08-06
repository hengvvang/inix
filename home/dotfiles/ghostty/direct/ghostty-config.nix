{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.ghostty.enable && config.myHome.dotfiles.ghostty.method == "direct") {
    
    home.file.".config/ghostty/config" = {
      text = ''
        # Ghostty 终端配置
        # 配置方式: direct - 直接文件配置

        # 字体设置
        font-family = JetBrains Mono
        font-size = 16
        font-thicken = true

        # 主题和颜色
        theme = github-dark
        background-opacity = 0.95

        # 窗口设置
        window-width = 120
        window-height = 30
        window-padding-x = 8
        window-padding-y = 8
        window-decoration = true

        # 光标设置
        cursor-style = block
        cursor-blink = true

        # 滚动设置
        scrollback-limit = 10000

        # 键绑定
        keybind = ctrl+shift+c=copy_to_clipboard
        keybind = ctrl+shift+v=paste_from_clipboard
        keybind = ctrl+shift+n=new_window
        keybind = ctrl+shift+t=new_tab
        keybind = ctrl+shift+w=close_surface

        # 其他设置
        confirm-close-surface = false
        quit-after-last-window-closed = true
        macos-non-native-fullscreen = true
      '';
    };
  };
}
