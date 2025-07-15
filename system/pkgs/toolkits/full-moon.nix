# 🌕 满月

{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.pkgs.toolkits.fullMoon.enable {
    environment.systemPackages = with pkgs; [
      
    ];
  };
}
