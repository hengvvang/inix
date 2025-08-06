{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.bash.enable && config.myHome.dotfiles.bash.method == "external") {

    home.packages = with pkgs; [ bash ];    

    home.file.".bashrc".source = ../configs/bashrc;
    home.file.".bash_profile".source = ../configs/bash_profile;
    home.file.".bash_aliases".source = ../configs/bash_aliases;
    home.file.".bash_functions".source = ../configs/bash_functions;
  };
}
