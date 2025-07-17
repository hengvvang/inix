{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.profiles.fonts.enable && config.mySystem.profiles.fonts.preset == "tokyo") {
    # 系统级字体包配置 - 东京风格
    fonts.packages = with pkgs; [
      # 主要字体 - 日式简约风格
      noto-fonts           # Google 现代设计
      source-sans-pro      # Adobe 简洁风格
      
      # Nerd Font 支持 - 现代简约
      (nerdfonts.override { 
        fonts = [ 
          "JetBrainsMono" "SourceCodePro" "RobotoMono" "Iosevka"
          "FiraCode" "Hack" "UbuntuMono" "CascadiaCode"
        ]; 
      })
      jetbrains-mono       # 现代编程字体
      
      # 中文字体 - 日式风格
      noto-fonts-cjk-sans
      source-han-sans
      lxgw-wenkai         # 现代中文字体
      
      # 基础字体
      noto-fonts-emoji
      font-awesome
      material-design-icons
    ];

    # 系统级字体配置
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif" "Source Han Serif SC" ];
        sansSerif = [ "Noto Sans" "Source Sans Pro" "Source Han Sans SC" "LXGW WenKai" ];
        monospace = [ 
          "JetBrains Mono Nerd Font" 
          "Source Code Pro Nerd Font"
          "Iosevka Nerd Font"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
