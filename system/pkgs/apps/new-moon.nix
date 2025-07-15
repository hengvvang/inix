# 🌑 新月

{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.pkgs.apps.newMoon.enable {
    environment.systemPackages = with pkgs; [
      spotify
      cider-2
    ];
  };
}
