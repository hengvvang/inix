{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.git.enable && config.myHome.dotfiles.git.method == "external") {

    home.packages = with pkgs; [ git ];
    
    home.file.".gitconfig".source = ./configs/gitconfig;
  };
}
