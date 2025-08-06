{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zsh.enable && config.myHome.dotfiles.zsh.method == "direct") {

    home.file.".config/zsh/.zlogin" = {
      text = ''
        # Zsh login file
        echo "Welcome to Zsh!"
        if [ -f ~/.zshrc ]; then
          source ~/.zshrc
        fi
      '';
      target = ".zlogin";
      force = true; # Ensure the file is always written
    };
  };
}
