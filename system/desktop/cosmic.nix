
{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.desktop.enable && config.mySystem.desktop.preset == "cosmic") {
    services = {
      displayManager.cosmic-greeter.package = pkgs.cosmic-greeter;
      displayManager.cosmic-greeter.enable = true;
      desktopManager.cosmic.enable = true;
      desktopManager.cosmic.xwayland.enable = true;
  };
    environment.cosmic.excludePackages = [
      # plasma-browser-integration # Comment out this line if you use KDE Connect
      # kdepim-runtime # Unneeded if you use Thunderbird, etc.
      # konsole # Comment out this line if you use KDE's default terminal app
      # oxygen
    ];

    environment.systemPackages = [
      # pkgs.cosmic-shell,
      # pkgs.cosmic-terminal,
      # pkgs.cosmic-file-manager,
      # pkgs.cosmic-settings,
      # pkgs.cosmic-wallpapers,
      # pkgs.cosmic-control-center,
      # pkgs.cosmic-notifications,
      # pkgs.cosmic-calendar,
      # pkgs.cosmic-clipboard,
      # pkgs.cosmic-power-manager,
      # pkgs.cosmic-session
    ];
  };
}
