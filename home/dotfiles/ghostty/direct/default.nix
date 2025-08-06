{ config, lib, pkgs, ... }:

{
  imports = [
    ./ghostty-config.nix
  ];

  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.ghostty.enable && config.myHome.dotfiles.ghostty.method == "direct") {

    home.packages = with pkgs; [ ghostty ];
  };
}
