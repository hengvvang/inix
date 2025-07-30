{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.alacritty.enable && 
                    config.myHome.dotfiles.alacritty.method == "external") {
    home.packages = with pkgs; [ alacritty ];
    
    home.file.".config/alacritty/alacritty.toml" = {
      source = ./configs/alacritty.toml;
      executable = false;
    };
  };
}
