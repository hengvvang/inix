# 🌑 新月

{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.pkgs.apps.newMoon.enable {
    environment.systemPackages = [
      pkgs.spotify
      #pkgs.cider-2
      pkgs.kdePackages.kdenlive
    ];
  };
}
