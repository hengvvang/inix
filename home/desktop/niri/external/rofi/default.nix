{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.method == "external") {

    home.packages = with pkgs; [
      papirus-icon-theme
      rofi-wayland
    ];


    # rofi 配置文件
    home.file.".config/rofi/config.rasi".source = ./configs/config.rasi;
    home.file.".config/rofi/themes".source = ./configs/themes;
    
    fonts.fontconfig.enable = true;
    
    # ===== 环境变量设置 =====
    home.sessionVariables = {
      # Rofi 配置路径
      ROFI_CONFIG_DIR = "${config.home.homeDirectory}/.config/rofi";
      
      # 图标主题
      ROFI_ICON_THEME = "Papirus";
    };
  };
}