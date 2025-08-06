{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles = {
    enable = lib.mkEnableOption "Dotfiles 配置管理";
  };

  imports = [
    ./vim
    ./zsh
    ./bash
    ./fish
    ./nushell
    ./yazi
    ./ghostty
    ./alacritty
    ./rio
    ./tmux
    ./zellij
    ./git
    ./lazygit
    ./starship
    ./qutebrowser
    ./obs-studio
    ./rmpc
    ./vscode
    ./zed
    ./rofi
    ./sherlock
  ];
}
