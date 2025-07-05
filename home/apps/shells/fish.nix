{ config, lib, pkgs, ... }:

{
  options.myHome.apps.shells.fish.enable = lib.mkEnableOption "Fish Shell 配置";

  config = lib.mkIf config.myHome.apps.shells.fish.enable {
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