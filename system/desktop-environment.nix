{ config, lib, pkgs, ... }:

{
  options.mySystem.desktop.enable = lib.mkEnableOption "桌面环境" // {
    default = false;
  };

  config = lib.mkIf config.mySystem.desktop.enable {
# ------ Plasma ------
  # services = {
  #   desktopManager.plasma6.enable = true;
  #   displayManager.sddm.enable = true;
  #   displayManager.sddm.wayland.enable = true;
  # };

  # environment.plasma6.excludePackages = with pkgs.kdePackages; [
  #   plasma-browser-integration # Comment out this line if you use KDE Connect
  #   kdepim-runtime # Unneeded if you use Thunderbird, etc.
  #   konsole # Comment out this line if you use KDE's default terminal app
  #   oxygen
  # ];
# ------ Gnome ------
  #  --- before---
  # services.xserver = {
  #     enable = true;
  #     displayManager.gdm.enable = true;
  #     desktopManager.gnome.enable = true;
  # }

  #  --- now ---
  # services = {
  #   desktopManager.gnome.enable = true;
  #   displayManager.gdm.enable = true;
  # };
# ----- cosmic -----
  services = {
        displayManager.cosmic-greeter.package = pkgs.cosmic-greeter;
        displayManager.cosmic-greeter.enable = true;
        desktopManager.cosmic.enable = true;
        desktopManager.cosmic.xwayland.enable = true;
  };
  # environment.cosmic.excludePackages = [
  #   plasma-browser-integration # Comment out this line if you use KDE Connect
  #   kdepim-runtime # Unneeded if you use Thunderbird, etc.
  #   konsole # Comment out this line if you use KDE's default terminal app
  #   oxygen
  # ];



    environment.systemPackages = [
   # ---- gnome extentsion ----
   # pkgs.gnome-tweaks # required
   # pkgs.gnomeExtensions.user-themes
   # pkgs.gnomeExtensions.blur-my-shell
   # pkgs.gnomeExtensions.extension-list
   # pkgs.gnomeExtensions.dash-to-dock
   # pkgs.gnomeExtensions.logo-menu
   # pkgs.gnomeExtensions.clipboard-indicator
   # pkgs.gnomeExtensions.caffeine
   # pkgs.gnomeExtensions.kimpanel # fcitx need;   recommand extension: Fcitx HUD


   # ---- kde plasma packages ----
   # kdePackages.discover # Optional: Install if you use Flatpak or fwupd firmware update sevice
   # kdePackages.kcalc # Calculator
   # kdePackages.kcharselect # Tool to select and copy special characters from all installed fonts
   # kdePackages.kcolorchooser # A small utility to select a color
   # kdePackages.kolourpaint # Easy-to-use paint program
   # kdePackages.ksystemlog # KDE SystemLog Application
   # kdePackages.sddm-kcm # Configuration module for SDDM
   # kdiff3 # Compares and merges 2 or 3 files or directories
   # hardinfo2 # System information and benchmarks for Linux systems
   # haruna # Open source video player built with Qt/QML and libmpv
   # xclip # Tool to access the X clipboard from a console application
  ];
  };
}
