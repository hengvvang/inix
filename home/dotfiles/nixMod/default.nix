{ config, lib, pkgs, ... }:

{
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
    ./sherlock
    ./qutebrowser
    ./obs-studio
    ./rmpc
    ./vscode
    ./zed
    ./rofi
    ./vicinae
  ];
}
