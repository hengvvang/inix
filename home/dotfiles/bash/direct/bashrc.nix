{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.bash.enable && config.myHome.dotfiles.bash.method == "direct") {
    home.packages = with pkgs; [ bash ];

    home.file.".bashrc" = {
      text = ''
        # Bash configuration file
        export PATH="$HOME/bin:$PATH"
        alias ll='ls -la'
        alias gs='git status'
        source ~/.bash_aliases
      '';
      target = ".bashrc";
      force = true; # Ensure the file is always written
    };
  };
}
