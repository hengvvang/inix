{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.profiles.fonts.enable && config.mySystem.profiles.fonts.preset == "forest") {
    # 系统级字体包配置 - 森林风格
    fonts.packages = with pkgs; [
      # 主要字体 - 自然有机风格
      source-sans-pro      # 自然流畅设计
      lxgw-wenkai         # 温暖中文字体
      
      # Nerd Font 支持 - 自然风格
      (nerdfonts.override { 
        fonts = [ 
          "JetBrainsMono" "SourceCodePro" "UbuntuMono" "Meslo"
          "DejaVuSansMono" "LiberationMono" "AnonymousPro"
        ]; 
      })
      
      # 中文字体 - 温暖风格
      noto-fonts-cjk-sans
      source-han-sans
      
      # 基础字体
      noto-fonts
      noto-fonts-emoji
      font-awesome
    ];

    # 系统级字体配置
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif" "Source Han Serif SC" ];
        sansSerif = [ "Source Sans Pro" "LXGW WenKai" "Source Han Sans SC" ];
        monospace = [ 
          "JetBrains Mono Nerd Font" 
          "Source Code Pro Nerd Font"
          "Ubuntu Mono Nerd Font"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
