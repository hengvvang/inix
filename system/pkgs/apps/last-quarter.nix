# 🌗 下弦月

{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.pkgs.apps.lastQuarter.enable {
    environment.systemPackages = with pkgs; [
      # OBS Studio with plugins properly integrated
      (wrapOBS {
        plugins = with obs-studio-plugins; [
          input-overlay
        ];
      })
      yazi
      vscode
      zed-editor
      google-chrome
    ];
  };
}
