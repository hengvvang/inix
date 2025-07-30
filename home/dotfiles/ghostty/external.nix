{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.ghostty.enable && config.myHome.dotfiles.ghostty.method == "external") {

    home.packages = with pkgs; [ ghostty ];

    home.file.".config/ghostty/config".source = ./configs/config;
    
    # 额外的主题和配置文件
    home.file.".config/ghostty/themes/.keep".text = "";
  };
}
