{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.qutebrowser.enable && config.myHome.dotfiles.qutebrowser.method == "direct") {

    home.file.".config/qutebrowser/quickmarks" = {
      text = ''
      '';
      target = ".config/qutebrowser/quickmarks";
      force = false;
    };
  };
}
