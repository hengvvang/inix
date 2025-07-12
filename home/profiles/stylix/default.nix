{ config, pkgs, lib, ... }:

{
  imports = [
    ./targets.nix
    ./fonts.nix
    ./colors.nix
  ];

  options.myHome.profiles.stylix = {
    enable = lib.mkEnableOption "Stylix 主题系统";
    
    # 壁纸配置
    image = lib.mkOption {
      type = lib.types.path;
      default = ./wallpapers/sea.jpg;
      description = "主题壁纸路径";
      example = ./wallpapers/sea.jpg;
    };
    
    # 主题极性
    polarity = lib.mkOption {
      type = lib.types.enum [ "light" "dark" ];
      default = "dark";
      description = "主题极性（明亮/暗色）";
    };
  };

  config = lib.mkIf config.myHome.profiles.stylix.enable {
    stylix = {
      enable = true;
      autoEnable = false;  # 完全手动控制
      
      # 基础配置
      image = config.myHome.profiles.stylix.image;
      polarity = config.myHome.profiles.stylix.polarity;
    };
  };
}
