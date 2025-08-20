{ config, lib, pkgs, ... }:

{
  imports = [
    ./options.nix  # 统一的选项定义
    # ./tilde
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
  ];
}
