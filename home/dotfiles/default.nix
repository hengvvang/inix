{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles = {
    enable = lib.mkEnableOption "Dotfiles 配置管理";
  };

  imports = [
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
  ];
}
