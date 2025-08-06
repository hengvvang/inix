{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.bash.enable && config.myHome.dotfiles.bash.method == "xdirect") {

    home.packages = with pkgs; [ bash ];    

    home.file.".bashrc".text = builtins.readFile ./configs/bashrc;
    home.file.".bash_profile".text = builtins.readFile ./configs/bash_profile;
    home.file.".bash_aliases".text = builtins.readFile ./configs/bash_aliases;
    home.file.".bash_functions".text = builtins.readFile ./configs/bash_functions;
  };
}
