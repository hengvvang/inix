{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.tmux.enable && 
                    config.myHome.dotfiles.tmux.method == "direct") {

    home.packages = with pkgs; [ tmux ];
    
    home.file.".config/tmux/tmux.conf".text = ''
    '';
  };
}
