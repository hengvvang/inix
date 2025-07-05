{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.apps.shells.fish {
  # Fish Shell 配置
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # Fish shell 初始化配置
      set -g fish_greeting ""
    '';
  };
  };
}