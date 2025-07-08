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
    ./alacritty     # 新增 Alacritty 终端
    ./tmux          # 新增 Tmux 会话管理
    ./git
    ./lazygit
    ./starship
    ./proxy       # 代理配置模块
  ];
}
