{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.bash.enable && config.myHome.dotfiles.bash.method == "direct") {

    home.file.".bash_profile" = {
      text = ''
        # Bash profile file
        if [ -f ~/.bashrc ]; then
          source ~/.bashrc
        fi
      '';
      target = ".bash_profile";
      force = true; # Ensure the file is always written
    };
  };
}
