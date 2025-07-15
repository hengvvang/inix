# 🌗 下弦月

{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.pkgs.apps.lastQuarter.enable {
    environment.systemPackages = with pkgs; [
      obs-studio
      yazi
      vscode
      #zed-editor
    ];
  };
}
