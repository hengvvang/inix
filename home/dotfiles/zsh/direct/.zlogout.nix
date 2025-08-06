
{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zsh.enable && config.myHome.dotfiles.zsh.method == "direct") {

    home.file.".config/zsh/.zlogout"  = {
      text = ''
        # Zsh logout file
        echo "Goodbye from Zsh!"
      '';
      target = ".zlogout";
      force = true; # Ensure the file is always written
    };
  };
}
