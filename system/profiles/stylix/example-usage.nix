{ config, lib, pkgs, ... }:

{
  # 系统级 Stylix 配置示例
  mySystem.profiles.stylix = {
    enable = true;
    
    # 基础主题配置
    image = ./stylix/wallpapers/sea.jpg;  # 使用预设壁纸
    polarity = "dark";                    # 深色主题
    
    # 可选：使用特定颜色方案
    # colorScheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    
    # 字体配置
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };
      serif = {
        package = pkgs.noto-fonts;  
        name = "Noto Serif";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 11;
        terminal = 12;
        desktop = 10;
        popups = 10;
      };
    };
  };
}
