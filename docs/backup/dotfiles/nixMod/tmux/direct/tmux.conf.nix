{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.tmux.enable &&
                    config.myHome.dotfiles.tmux.method == "direct") {
    home.file.".tmux.conf" ={
      text = ''
        # Tmux configuration file
        set -g default-terminal "screen-256color"
        set -g history-limit 10000
        set -g mouse on
        bind r source-file ~/.tmux.conf \; display "Config reloaded!"
      '';
      target = "tmux.conf";
      force = true; # Ensure the file is always written
    };
  };
}
