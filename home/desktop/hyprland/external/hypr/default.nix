{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.method == "external") {
    
    # Hyprland 核心配置
    xdg.configFile = {
      "hypr/hyprland.conf".source = ./hyprland.conf;
      "hypr/hypridle.conf".source = ./hypridle.conf;
      "hypr/hyprlock.conf".source = ./hyprlock.conf;
      "hypr/hyprpaper.conf".source = ./hyprpaper.conf;
      
      # 主题配置
      "hypr/themes/catppuccin.conf".source = ./themes/catppuccin.conf;
      
      # 脚本配置
      "hypr/scripts/wallpaper.sh" = {
        source = ./scripts/wallpaper.sh;
        executable = true;
      };
    };
    
  };
}
