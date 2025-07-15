# 🌓 上弦月

{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.pkgs.toolkits.firstQuarter.enable {
    environment.systemPackages = with pkgs; [
      
    ];
  };
}
