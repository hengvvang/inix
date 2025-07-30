{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.fish.enable && config.myHome.dotfiles.fish.method == "direct") {
    
    home.packages = with pkgs; [ fish ];
    
    home.file.".config/fish/config.fish".text = ''
    '';
  };
}
