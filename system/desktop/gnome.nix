
{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.desktop.gnome {
  #  --- before---
  # services.xserver = {
  #     enable = true;
  #     displayManager.gdm.enable = true;
  #     desktopManager.gnome.enable = true;
  # }

  #  --- now ---
  services = {
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    xserver.enable = true;
  };

  environment.systemPackages = [
  # ---- gnome extentsion ----
  pkgs.gnome-tweaks # required
  pkgs.gnomeExtensions.user-themes
  pkgs.gnomeExtensions.blur-my-shell
  pkgs.gnomeExtensions.extension-list
  pkgs.gnomeExtensions.dash-to-dock
  pkgs.gnomeExtensions.logo-menu
  pkgs.gnomeExtensions.clipboard-indicator
  pkgs.gnomeExtensions.caffeine
  pkgs.gnomeExtensions.kimpanel # fcitx need; recommand extension: Fcitx HUD
  ];
 };
}
