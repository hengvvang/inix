{ config, lib, ... }:

{
  # 系统级字体配置 - 与 home/profiles/stylix/fonts.nix 结构对称
  config = lib.mkIf (config.mySystem.profiles.stylix.enable && config.mySystem.profiles.stylix.fonts.enable) {
    # 系统级字体包管理
    fonts.packages = with config.mySystem.profiles.stylix.fonts.packages; [
      monospace
      sansSerif
      serif
      emoji
    ];
    
    # 可选：系统级字体缓存配置
    fonts.fontconfig = {
      defaultFonts = {
        monospace = [ config.mySystem.profiles.stylix.fonts.names.monospace ];
        sansSerif = [ config.mySystem.profiles.stylix.fonts.names.sansSerif ];
        serif = [ config.mySystem.profiles.stylix.fonts.names.serif ];
        emoji = [ config.mySystem.profiles.stylix.fonts.names.emoji ];
      };
    };
  };
}
