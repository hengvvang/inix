{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.desktop.enable && config.mySystem.desktop.preset == "kde") {
    # ------ KDE ------
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

    ];
  };
}