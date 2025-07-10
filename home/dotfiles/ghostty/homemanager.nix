{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.ghostty.enable && config.myHome.dotfiles.ghostty.method == "homemanager") {
    # 方式1: Home Manager 程序模块
    # 注意：Ghostty 可能没有官方的 Home Manager 模块，所以使用文件配置
    home.packages = with pkgs; [ ghostty ];
    
    home.file.".config/ghostty/config".text = ''
      # Ghostty 终端配置 - Home Manager 方式
      
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
      window-title-font-family = "FiraCode Nerd Font"
      
      # 主题设置 (Catppuccin Macchiato)
      background = 24273a
      foreground = cad3f5
      cursor-color = f4dbd6
      selection-background = 5b6078
      selection-foreground = cad3f5
      
      # 调色板
      palette = 0=#494d64
      palette = 8=#5b6078
      palette = 1=#ed8796
      palette = 9=#ed8796
      palette = 2=#a6da95
      palette = 10=#a6da95
      palette = 3=#eed49f
      palette = 11=#eed49f
      palette = 4=#8aadf4
      palette = 12=#8aadf4
      palette = 5=#f5bde6
      palette = 13=#f5bde6
      palette = 6=#8bd5ca
      palette = 14=#8bd5ca
      palette = 7=#b8c0e0
      palette = 15=#a5adcb
      
      # 终端设置
      scrollback-limit = 100000
      mouse-hide-while-typing = true
      copy-on-select = false
      confirm-close-surface = false
      shell-integration = fish
      
      # 性能设置
      unfocused-split-opacity = 0.7
      resize-overlay = true
      resize-overlay-position = center
      resize-overlay-duration = 500
      
      # 光标和铃声设置
      cursor-style = block
      cursor-style-blink = false
      audio-bell = false
      visual-bell = true
      visual-bell-color = f5a97f
      visual-bell-duration = 100
      
      # 工作目录和命令
      working-directory = inherit
      command = fish
    '';
  };
}
