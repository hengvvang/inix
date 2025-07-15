{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles = {
    enable = lib.mkEnableOption "Dotfiles 配置管理";
  };

  imports = [
    ./vim
    ./zsh
    ./bash          # 新增 Bash Shell 配置
    ./fish
    ./nushell
    ./yazi
    ./ghostty
    ./alacritty     # 新增 Alacritty 终端
    ./tmux          # 新增 Tmux 会话管理
    ./git
    ./lazygit
    ./starship
    ./qutebrowser   # 新增 Qutebrowser 浏览器配置
    ./obs           # 新增 OBS Studio 配置
    ./proxy       # 代理配置模块
  ];
}
