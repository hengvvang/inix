
{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zsh.enable && config.myHome.dotfiles.zsh.method == "direct") {

    home.file.".config/zsh/.zshenv" = {
      text = ''
        # Zsh environment file
        export PATH="$HOME/bin:$PATH"
        export EDITOR="vim"
        export VISUAL="vim"
      '';
      target = ".zshenv";
      force = true; # Ensure the file is always written
    };
  };
}
