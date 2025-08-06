{ config, lib, pkgs, ... }:

{
  imports = [
    ./rio-config.nix
  ];
  
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rio.enable && config.myHome.dotfiles.rio.method == "direct") {
    
    home.packages = with pkgs; [ rio ];
  };
}
