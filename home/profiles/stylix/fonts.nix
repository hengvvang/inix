{ config, pkgs, lib, ... }:

{
  options.myHome.profiles.stylix.fonts = {
    enable = lib.mkEnableOption "Stylix 字体配置";
    
    # 字体包选择
    packages = {
      monospace = lib.mkOption {
        type = lib.types.package;
        default = pkgs.nerd-fonts.jetbrains-mono;
        description = "等宽字体包";
      };
      
      sansSerif = lib.mkOption {
        type = lib.types.package;
        default = pkgs.noto-fonts;
        description = "无衬线字体包";
      };
      
      serif = lib.mkOption {
        type = lib.types.package;
        default = pkgs.noto-fonts;
        description = "衬线字体包";
      };
      
      emoji = lib.mkOption {
        type = lib.types.package;
        default = pkgs.noto-fonts-emoji;
        description = "表情字体包";
      };
    };
    
    # 字体名称
    names = {
      monospace = lib.mkOption {
        type = lib.types.str;
        default = "JetBrainsMono Nerd Font Mono";
        description = "等宽字体名称";
      };
      
      sansSerif = lib.mkOption {
        type = lib.types.str;
        default = "Noto Sans";
        description = "无衬线字体名称";
      };
      
      serif = lib.mkOption {
        type = lib.types.str;
        default = "Noto Serif";
        description = "衬线字体名称";
      };
      
      emoji = lib.mkOption {
        type = lib.types.str;
        default = "Noto Color Emoji";
        description = "表情字体名称";
      };
    };
    
    # 字体大小
    sizes = {
      applications = lib.mkOption {
        type = lib.types.int;
        default = 11;
        description = "应用程序字体大小";
      };
      
      terminal = lib.mkOption {
        type = lib.types.int;
        default = 12;
        description = "终端字体大小";
      };
      
      desktop = lib.mkOption {
        type = lib.types.int;
        default = 10;
        description = "桌面字体大小";
      };
      
      popups = lib.mkOption {
        type = lib.types.int;
        default = 10;
        description = "弹窗字体大小";
      };
    };
  };

  config = lib.mkIf (config.myHome.profiles.stylix.enable && config.myHome.profiles.stylix.fonts.enable) {
    stylix.fonts = {
      monospace = {
        package = config.myHome.profiles.stylix.fonts.packages.monospace;
        name = config.myHome.profiles.stylix.fonts.names.monospace;
      };
      
      sansSerif = {
        package = config.myHome.profiles.stylix.fonts.packages.sansSerif;
        name = config.myHome.profiles.stylix.fonts.names.sansSerif;
      };
      
      serif = {
        package = config.myHome.profiles.stylix.fonts.packages.serif;
        name = config.myHome.profiles.stylix.fonts.names.serif;
      };
      
      emoji = {
        package = config.myHome.profiles.stylix.fonts.packages.emoji;
        name = config.myHome.profiles.stylix.fonts.names.emoji;
      };
      
      sizes = {
        applications = config.myHome.profiles.stylix.fonts.sizes.applications;
        terminal = config.myHome.profiles.stylix.fonts.sizes.terminal;
        desktop = config.myHome.profiles.stylix.fonts.sizes.desktop;
        popups = config.myHome.profiles.stylix.fonts.sizes.popups;
      };
    };
  };
}
