{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles = {
    enable = lib.mkEnableOption "Dotfiles 配置管理";
  };

  imports = [
    ./vim
    ./zsh
    ./fish
    ./nushell
    ./yazi
    ./ghostty
    ./git
    ./lazygit
    ./starship
  ];
}
