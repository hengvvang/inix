{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.method == "external") {
    
    # 应用启动器 - macOS Tathoe 毛玻璃风格
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
    };

    # rofi 配置文件
    home.file.".config/rofi/config.rasi".source = ./configs/config.rasi;
    home.file.".config/rofi/themes".source = ./configs/themes;
    
    # 确保字体可用
    fonts.fontconfig.enable = true;
    
    # 安装图标主题以获得更好的应用图标显示
    home.packages = with pkgs; [
      papirus-icon-theme
    ];
  };
}
