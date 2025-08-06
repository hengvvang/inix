{ config, lib, pkgs, ... }:

{
  imports = [
    ./fish-config.nix
    ./fish-functions.nix
  ];
  
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.fish.enable && config.myHome.dotfiles.fish.method == "direct") {
    home.packages = with pkgs; [ fish ];
  };
}
