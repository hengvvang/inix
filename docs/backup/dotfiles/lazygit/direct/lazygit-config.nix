{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.lazygit.enable && config.myHome.dotfiles.lazygit.method == "direct") {

    home.file.".config/lazygit/config.yml" = {
      text = ''
      '';
      target = ".config/lazygit/config.yml";
      force = false;
    };
  };
}
