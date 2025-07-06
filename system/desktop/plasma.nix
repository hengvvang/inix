{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.desktop.plasma.enable {
    # ------ Plasma ------
    services = {
      desktopManager.plasma6.enable = true;
      displayManager.sddm.enable = true;
      displayManager.sddm.wayland.enable = true;
    };

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      plasma-browser-integration
      kdepim-runtime
      konsole
      oxygen
    ];

    environment.systemPackages = with pkgs; [
      # ---- kde plasma packages ----
      kdePackages.discover
      kdePackages.kcalc
      kdePackages.kcharselect
      kdePackages.kcolorchooser
      kdePackages.kolourpaint
      kdePackages.ksystemlog
      kdePackages.sddm-kcm
      kdiff3
      hardinfo2
      haruna
      xclip
    ];
  };
}