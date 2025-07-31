
{ config, lib, pkgs, ... }:

{
    config = lib.mkIf (config.mySystem.desktop.enable && config.mySystem.desktop.preset == "hyprland") {

        programs.hyprland = {
            enable = true;
            withUWSM = true;
        };
        environment.sessionVariables.NIXOS_OZONE_WL = "1";
        environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

        programs.hyprlock.enable = true;
        services.hypridle.enable = true;

        environment.systemPackages = with pkgs; [
            pyprland
            hyprpicker
            hyprcursor
            hyprlock
            hypridle
            hyprpaper

            kitty
        ];
    };
}
