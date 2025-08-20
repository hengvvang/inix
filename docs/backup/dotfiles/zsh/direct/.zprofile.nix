
{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zsh.enable && config.myHome.dotfiles.zsh.method == "direct") {

    home.file.".config/zsh/.zprofile" = {
      text = ''
        # Zsh profile file
        if [ -f ~/.zshrc ]; then
          source ~/.zshrc
        fi
      '';
      target = ".zprofile";
      force = true; # Ensure the file is always written
    };
  };
}
