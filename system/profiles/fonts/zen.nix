{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.profiles.fonts.enable && config.mySystem.profiles.fonts.preset == "zen") {
    # 系统级字体包配置 - 禅意风格
    fonts.packages = with pkgs; [
      # 主要字体 - 宁静专注风格
      source-sans-pro      # 简洁专注
      noto-fonts           # 宁静设计
      
      # Nerd Font 支持 - 专注风格
      (nerdfonts.override { 
        fonts = [ 
          "JetBrainsMono" "SourceCodePro" "DejaVuSansMono" 
          "UbuntuMono" "Meslo" "AnonymousPro"
        ]; 
      })
      
      # 中文字体 - 禅意风格
      lxgw-wenkai         # 文雅字体
      noto-fonts-cjk-sans
      
      # 基础字体
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
          "DejaVu Sans Mono Nerd Font"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
