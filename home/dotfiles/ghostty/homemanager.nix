{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.ghostty.enable && config.myHome.dotfiles.ghostty.method == "homemanager") {
    programs.ghostty = {
      enable = true;
      package = pkgs.ghostty;
      
      # 主要配置设置
      settings = {
        # 字体设置
        # font-family = "FiraCode Nerd Font";  # 注释掉，使用系统默认
        font-size = 12;
        font-feature = [
          "+ss01"
          "+ss02"
          "+ss03"
          "+ss04"
          "+ss05"
          "+ss06"
          "+ss07"
          "+ss08"
          "+ss09"
          "+ss10"
          "+cv01"
          "+cv02"
          "+cv05"
          "+cv09"
          "+cv10"
          "+cv11"
          "+cv12"
          "+cv13"
          "+cv14"
        ];
        
        # 窗口设置
        window-padding-x = 8;
        window-padding-y = 8;
        window-decoration = true;
        window-title-font-family = "FiraCode Nerd Font";
        
        # 终端设置
        scrollback-limit = 100000;
        mouse-hide-while-typing = true;
        copy-on-select = false;
        confirm-close-surface = false;
        shell-integration = "fish";
        
        # 性能设置
        unfocused-split-opacity = 0.7;
        resize-overlay = true;
        resize-overlay-position = "center";
        resize-overlay-duration = 500;
        
        # 光标和铃声设置
        cursor-style = "block";
        cursor-style-blink = false;
        audio-bell = false;
        visual-bell = true;
        visual-bell-color = "f5a97f";
        visual-bell-duration = 100;
        
        # 工作目录和命令
        working-directory = "inherit";
        command = "fish";
        
        # 使用自定义主题
        theme = "catppuccin-macchiato";
      };
      
      # 自定义主题定义
      themes = {
        catppuccin-macchiato = {
          # 基本颜色
          background = "24273a";
          foreground = "cad3f5";
          cursor-color = "f4dbd6";
          selection-background = "5b6078";
          selection-foreground = "cad3f5";
          
          # 调色板
          palette = [
            "0=#494d64"
            "8=#5b6078"
            "1=#ed8796"
            "9=#ed8796"
            "2=#a6da95"
            "10=#a6da95"
            "3=#eed49f"
            "11=#eed49f"
            "4=#8aadf4"
            "12=#8aadf4"
            "5=#f5bde6"
            "13=#f5bde6"
            "6=#8bd5ca"
            "14=#8bd5ca"
            "7=#b8c0e0"
            "15=#a5adcb"
          ];
        };
      };
      
      # 启用 shell 集成
      enableFishIntegration = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
  };
}
