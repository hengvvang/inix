{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.bash.enable && config.myHome.dotfiles.bash.method == "direct") {

    home.file.".bash_aliases" = {
      text = ''
        # Bash aliases
        alias ll='ls -la'
        alias gs='git status'
        alias v='vim'
        alias c='clear'
      '';
      target = ".bash_aliases";
      force = true; # Ensure the file is always written
    };
  };
}
