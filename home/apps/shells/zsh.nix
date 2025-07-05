{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.apps.shells.zsh {
  # Zsh Shell 配置
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };
  };
}