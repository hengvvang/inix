# Sherlock Launcher - Home Manager Configuration Mode
{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.sherlock.homeManager.enable) {

    home.packages = with pkgs; [
      sherlock-launcher
    ];

     # Environment variables
    home.sessionVariables = {
      LAUNCHER = "sherlock";
      GDK_BACKEND = "wayland,x11";
      QT_QPA_PLATFORM = "wayland;xcb";
    };
  };
}
