{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.apps.shells.zsh.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
    };
  };
}