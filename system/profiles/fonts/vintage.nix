{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.profiles.fonts.enable && config.mySystem.profiles.fonts.preset == "vintage") {
    # 系统级字体包配置 - 复古风格
    fonts.packages = with pkgs; [
      # 主要字体 - 复古经典风格
      liberation_ttf       # 经典替代字体
      source-serif-pro     # 优雅衬线字体
      crimson              # 传统阅读字体
      
      # Nerd Font 支持 - 经典风格
      (nerdfonts.override { 
        fonts = [ 
          "DejaVuSansMono" "LiberationMono" "SourceCodePro" "UbuntuMono"
          "JetBrainsMono" "Meslo" "AnonymousPro" "ProFont"
        ]; 
      })
      source-code-pro     # 经典编程字体
      
      # 中文字体 - 传统风格
      noto-fonts-cjk-serif
      source-han-serif
      
      # 基础字体
      noto-fonts
      noto-fonts-emoji
      font-awesome
    ];

    # 系统级字体配置
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Source Serif Pro" "Crimson Text" "Source Han Serif SC" ];
        sansSerif = [ "Liberation Sans" "Noto Sans" "Source Han Sans SC" ];
        monospace = [ 
          "DejaVu Sans Mono Nerd Font" 
          "Liberation Mono Nerd Font"
          "Source Code Pro Nerd Font"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
