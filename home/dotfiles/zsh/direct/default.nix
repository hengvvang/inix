{ config, lib, pkgs, ... }:

let
  zshConfig = import ./zsh-config.nix { inherit config lib pkgs; };
in
{
  imports = [
    ./zsh-config.nix
  ];
  
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zsh.enable && config.myHome.dotfiles.zsh.method == "direct") {

    home.packages = with pkgs; [ zsh ];
    
    programs.zsh = {
      enable = true;
      package = pkgs.zsh;
      enableCompletion = zshConfig.enableCompletion;
      autosuggestion = zshConfig.autosuggestion;
      syntaxHighlighting = zshConfig.syntaxHighlighting;
      autocd = zshConfig.autocd;
      history = zshConfig.history;
      shellAliases = zshConfig.shellAliases;
      defaultKeymap = zshConfig.defaultKeymap;
      completionInit = zshConfig.completionInit;
      initExtra = zshConfig.initContent;
      envExtra = zshConfig.envExtra;
      oh-my-zsh = zshConfig.oh-my-zsh;
      plugins = zshConfig.plugins;
      dotDir = ".config/zsh";
    };
  };
}
