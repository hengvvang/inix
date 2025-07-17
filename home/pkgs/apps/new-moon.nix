# 🌑 新月

{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.pkgs.apps.newMoon.enable {
    home.packages = with pkgs; [
      
    ];
  };
}
