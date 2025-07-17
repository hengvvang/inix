{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.profiles.fonts.enable && config.mySystem.profiles.fonts.preset == "sakura") {
    # 系统级字体包配置 - 樱花风格
    fonts.packages = with pkgs; [
      # 主要字体 - 优雅日式风格
      noto-fonts           # 优雅现代设计
      source-sans-pro      # Adobe 优雅设计
      
      # Nerd Font 支持 - 优雅风格
      (nerdfonts.override { 
        fonts = [ 
          "JetBrainsMono" "SourceCodePro" "Iosevka" "RobotoMono"
          "FiraCode" "UbuntuMono" "CascadiaCode" "Meslo"
        ]; 
      })
      
      # 中文字体 - 优雅风格
      lxgw-wenkai         # 优雅中文字体
      noto-fonts-cjk-sans
      source-han-sans
      
      # 基础字体
      noto-fonts-emoji
      font-awesome
    ];

    # 系统级字体配置
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif" "Source Han Serif SC" ];
        sansSerif = [ "Noto Sans" "LXGW WenKai" "Source Han Sans SC" ];
        monospace = [ 
          "JetBrains Mono Nerd Font" 
          "Iosevka Nerd Font"
          "Fira Code Nerd Font"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
