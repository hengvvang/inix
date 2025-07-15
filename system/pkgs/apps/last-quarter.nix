# 🌗 下弦月

{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.pkgs.apps.lastQuarter.enable {
    environment.systemPackages = with pkgs; [
      # OBS Studio with plugins properly integrated
      (wrapOBS {
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          input-overlay
          obs-backgroundremoval
          obs-pipewire-audio-capture
          obs-vaapi #optional AMD hardware acceleration
          obs-gstreamer
          obs-vkcapture
        ];
      })
      yazi
      vscode
      zed-editor
      google-chrome
    ];
  };
}
