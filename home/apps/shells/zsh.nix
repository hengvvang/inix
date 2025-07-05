{ config, lib, pkgs, ... }:

{
  options.myHome.apps.shells.zsh.enable = lib.mkEnableOption "Zsh Shell 配置";

  config = lib.mkIf config.myHome.apps.shells.zsh.enable {
  # Zsh Shell 配置
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };
  };
}