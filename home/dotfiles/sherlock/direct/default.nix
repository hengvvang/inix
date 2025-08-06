# Sherlock Launcher - Direct Configuration Mode
{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.sherlock.enable && config.myHome.dotfiles.sherlock.method == "direct") {

    home.packages = with pkgs; [
      sherlock-launcher
    ];
  };
}
