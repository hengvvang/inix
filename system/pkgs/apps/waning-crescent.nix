# 🌘 残月

{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.pkgs.apps.waningCrescent.enable {
    environment.systemPackages = with pkgs; [

    ];
  };
}
