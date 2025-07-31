
{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.desktop.enable && config.mySystem.desktop.preset == "gnome") {
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
  pkgs.refine
  pkgs.gnomeExtensions.fuzzy-app-search
  pkgs.gnomeExtensions.applications-menu
  pkgs.gnomeExtensions.user-themes
  pkgs.gnomeExtensions.blur-my-shell
  pkgs.gnomeExtensions.extension-list
  pkgs.gnomeExtensions.dash-to-dock
  pkgs.gnomeExtensions.logo-menu
  pkgs.gnomeExtensions.clipboard-indicator
  pkgs.gnomeExtensions.caffeine
  pkgs.gnomeExtensions.kimpanel # fcitx need; recommand extension: Fcitx HUD
  # tiling window manager
  pkgs.gnomeExtensions.tiling-shell
  pkgs.gnomeExtensions.forge     # tiling-shell 的替代品
  pkgs.gnomeExtensions.tiling-assistant
  ];
 };
}
