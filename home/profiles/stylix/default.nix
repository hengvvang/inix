{ config, pkgs, lib, ... }:

{
  imports = [
    ./targets.nix
    ./fonts.nix
    ./colors.nix
    ./wallpapers.nix
  ];

  options.myHome.profiles.stylix = {
    enable = lib.mkEnableOption "Stylix 主题系统";
    
    # 主题极性
    polarity = lib.mkOption {
      type = lib.types.enum [ "light" "dark" ];
      default = "dark";
      description = "主题极性（明亮/暗色）";
    };
    
    # 内部使用的解析后图片路径（由 wallpapers.nix 设置）
    _internal.resolvedImage = lib.mkOption {
      type = lib.types.path;
      internal = true;
      description = "内部解析的壁纸路径";
    };
  };

  config = lib.mkIf config.myHome.profiles.stylix.enable {
    stylix = {
      enable = true;
      autoEnable = false;  # 完全手动控制
      
      # 基础配置
      image = config.myHome.profiles.stylix._internal.resolvedImage;
      polarity = config.myHome.profiles.stylix.polarity;
    };
  };
}
