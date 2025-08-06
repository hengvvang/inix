{ config, lib, pkgs, ... }:

{
  imports = [
    ./.zshrc.nix
    ./zshenv.nix
    ./zprofile.nix
    ./zlogin.nix
    ./zlogout.nix
  ];

  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zsh.enable && config.myHome.dotfiles.zsh.method == "direct") {

    home.packages = with pkgs; [ zsh ];

  };
}
