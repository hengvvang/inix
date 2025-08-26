{ config, lib, pkgs, ... }:

{
    config = lib.mkIf (config.mySystem.desktop.enable && config.mySystem.desktop.preset == "gnome") {

    services = {
      xserver.enable = true;
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
    };

    environment.gnome.excludePackages = [
      # pkgs.gnome-backgrounds
      pkgs.gnome-video-effects
      pkgs.gnome-maps
      pkgs.gnome-music
      pkgs.gnome-tour
      pkgs.gnome-text-editor
      # pkgs.gnome-user-docs
    ];

    environment.systemPackages = [
      pkgs.refine
      pkgs.gnome-tweaks
      pkgs.dconf-editor
    ];
  };
}
