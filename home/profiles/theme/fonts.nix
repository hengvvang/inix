{ config, pkgs, lib, ... }:

{
  options.myHome.profiles.theme.fonts = {
    enable = lib.mkEnableOption "字体主题支持";
    
    # 字体选择选项
    monospace = lib.mkOption {
      type = lib.types.str;
      default = "jetbrains-mono";
      description = "等宽字体选择";
    };
    
    sansSerif = lib.mkOption {
      type = lib.types.str;
      default = "noto-sans";
      description = "无衬线字体选择";
    };
  };

  config = lib.mkIf (config.myHome.profiles.theme.enable && config.myHome.profiles.theme.fonts.enable) {
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
  };
}
