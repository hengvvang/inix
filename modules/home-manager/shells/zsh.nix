{ config, lib, pkgs, ... }:

{
  # Zsh Shell 配置
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };
}