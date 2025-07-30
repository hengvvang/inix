{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.alacritty.enable && 
                    config.myHome.dotfiles.alacritty.method == "direct") {

    home.packages = with pkgs; [ alacritty ];
    
    home.file.".config/alacritty/alacritty.toml".text = ''
    '';
  };
}
