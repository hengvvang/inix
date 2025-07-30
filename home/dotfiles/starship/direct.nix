{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.starship.enable && config.myHome.dotfiles.starship.method == "direct") {
    
    home.packages = with pkgs; [ starship ];

    home.file.".config/starship.toml".text = ''
    '';
  };
}
