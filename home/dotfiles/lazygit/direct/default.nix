{ config, lib, pkgs, ... }:

{
  imports = [
    ./lazygit-config.nix
  ];

  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.lazygit.enable && config.myHome.dotfiles.lazygit.method == "direct") {

    home.packages = with pkgs; [ lazygit ];
  };
}
