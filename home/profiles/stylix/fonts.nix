{ config, pkgs, lib, ... }:

{
  # 此模块仅处理字体相关的配置实现
  # options 已在 default.nix 中定义
  
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
