{ config, pkgs, lib, ... }:

{
  stylix.fonts = {
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
    
    # 字体大小配置
    sizes = {
      applications = 11;
      terminal = 12;
      desktop = 10;
      popups = 10;
    };
  };
}
