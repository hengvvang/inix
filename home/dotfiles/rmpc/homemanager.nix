{ config, lib, pkgs, ... }:

let
  cfg = config.myHome.dotfiles.rmpc;
  
  # 根据主题选择确定主题配置
  themeConfig = if cfg.theme == "default" then null else cfg.theme;
  
  # 主题文件映射
  rosePineTheme = ./configs/themes/rose-pine.ron;
  rosePineDawnTheme = ./configs/themes/rose-pine-dawn.ron;
  rosePineMoonTheme = ./configs/themes/rose-pine-moon.ron;
in
{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rmpc.enable && 
                    config.myHome.dotfiles.rmpc.method == "homemanager") {
    home.packages = with pkgs; [ rmpc ];
    
    programs.rmpc = {
      enable = true;
      package = pkgs.rmpc;
      config = ''
      '';
    };
  };
}
