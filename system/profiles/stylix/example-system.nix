# Stylix 使用示例
{ config, lib, ... }:

{
  # 系统配置示例
  mySystem.profiles.stylix = {
    enable = true;
    
    # 基础配置
    image = ./wallpapers/sea.jpg;  # 使用预设壁纸
    polarity = "dark";             # 深色主题
    
    # 可选：指定特定颜色方案而不是从壁纸生成
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
