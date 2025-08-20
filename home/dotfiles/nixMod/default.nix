{ config, lib, pkgs, ... }:

{
  imports = [
    ../options.nix  # 引用上级目录的统一选项定义
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
