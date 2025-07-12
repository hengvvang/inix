{ config, pkgs, lib, ... }:

{
  options.myHome.profiles.stylix.wallpapers = {
    enable = lib.mkEnableOption "Stylix 壁纸配置";
    
    # 预设壁纸选择
    preset = lib.mkOption {
      type = lib.types.enum [ "sea" "forest" "mountain" "city" "abstract" ];
      default = "sea";
      description = "预设壁纸选择";
      example = "sea";
    };
    
    # 自定义壁纸路径
    custom = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "自定义壁纸路径，优先于预设壁纸";
      example = ./my-wallpaper.jpg;
    };
  };

  config = lib.mkIf (config.myHome.profiles.stylix.enable && config.myHome.profiles.stylix.wallpapers.enable) {
    # 根据配置选择壁纸路径
    myHome.profiles.stylix._internal.resolvedImage = 
      if config.myHome.profiles.stylix.wallpapers.custom != null
      then config.myHome.profiles.stylix.wallpapers.custom
      else ./wallpapers + "/${config.myHome.profiles.stylix.wallpapers.preset}.jpg";
  };
}
