{ config, lib, pkgs, ... }:

{
  options.mySystem.desktop.plasma.enable = lib.mkEnableOption "plasma desktop environment" // {
    default = false; # 默认不开启桌面环境
  };

  config = lib.mkIf config.mySystem.desktop.plasma.enable {
  # ------ Plasma ------
  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration # Comment out this line if you use KDE Connect
    kdepim-runtime # Unneeded if you use Thunderbird, etc.
    konsole # Comment out this line if you use KDE's default terminal app
    oxygen
  ];

  environment.systemPackages = [
  # ---- kde plasma packages ----
    pkgs.kdePackages.discover # Optional: Install if you use Flatpak or fwupd firmware update sevice
    pkgs.kdePackages.kcalc # Calculator
    pkgs.kdePackages.kcharselect # Tool to select and copy special characters from all installed fonts
    pkgs.kdePackages.kcolorchooser # A small utility to select a color
    pkgs.kdePackages.kolourpaint # Easy-to-use paint program
    pkgs.kdePackages.ksystemlog # KDE SystemLog Application
    pkgs.kdePackages.sddm-kcm # Configuration module for SDDM
    pkgs.kdiff3 # Compares and merges 2 or 3 files or directories
    pkgs.hardinfo2 # System information and benchmarks for Linux systems
    pkgs.haruna # Open source video player built with Qt/QML and libmpv
    pkgs.xclip # Tool to access the X clipboard from a console application
  ];
 };
}
