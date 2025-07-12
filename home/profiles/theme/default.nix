{ config, pkgs, lib, ... }:

{
  imports = [
    ./stylix.nix
    ./fonts.nix
    ./colors.nix
  ];

  options.myHome.profiles.theme = {
    enable = lib.mkEnableOption "主题配置支持";
    
    # 壁纸选择选项
    wallpaper = lib.mkOption {
      type = lib.types.str;
      default = "sea";
      description = "选择壁纸主题";
      example = "sea";
    };
    
    # 主题极性选项
    polarity = lib.mkOption {
      type = lib.types.enum [ "light" "dark" ];
      default = "dark";
      description = "主题极性";
    };
  };

  config = lib.mkIf config.myHome.profiles.theme.enable {
    stylix = {
      enable = true;
      autoEnable = false;  # 禁用自动启用，手动控制目标
      
      # 壁纸配置
      image = ./wallpapers + "/${config.myHome.profiles.theme.wallpaper}.jpg";
      
      # 主题极性
      polarity = config.myHome.profiles.theme.polarity;
    };
  };
}
