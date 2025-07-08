{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.alacritty.enable && 
                    config.myHome.dotfiles.alacritty.method == "direct") {
    home.packages = with pkgs; [ alacritty ];
    
    # 直接写入配置文件
    home.file.".config/alacritty/alacritty.toml" = {
      source = ./configs/alacritty.toml;
      executable = false;
    };
  };
}
