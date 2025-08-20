{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zed.enable && config.myHome.dotfiles.zed.method == "direct") {

    home.file.".config/zed/settings.json" = {
      text = ''
      '';
      target = ".config/zed/settings.json";
      force = false;
    };
  };
}
