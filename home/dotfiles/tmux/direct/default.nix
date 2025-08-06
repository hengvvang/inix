{ config, lib, pkgs, ... }:

let
  tmuxConfig = import ./tmux-config.nix { inherit config lib pkgs; };
in
{
  imports = [
    ./tmux-config.nix
  ];
  
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.tmux.enable && 
                    config.myHome.dotfiles.tmux.method == "direct") {

    home.packages = with pkgs; [ tmux ];
    
    programs.tmux = {
      enable = true;
      package = pkgs.tmux;
      shell = tmuxConfig.shell;
      terminal = tmuxConfig.terminal;
      baseIndex = tmuxConfig.baseIndex;
      keyMode = tmuxConfig.keyMode;
      prefix = tmuxConfig.prefix;
      mouse = tmuxConfig.mouse;
      historyLimit = tmuxConfig.historyLimit;
      escapeTime = tmuxConfig.escapeTime;
      disableConfirmationPrompt = true;
      extraConfig = tmuxConfig.extraConfig;
    };
  };
}
