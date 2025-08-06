{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.qutebrowser.enable && config.myHome.dotfiles.qutebrowser.method == "direct") {

    home.file.".config/qutebrowser/config.py" = {
      text = ''
      '';
      target = ".config/qutebrowser/config.py";
      force = false;
    };
  };
}
