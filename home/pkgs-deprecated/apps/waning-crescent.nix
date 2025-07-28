# 🌘 残月

{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.pkgs.apps.waningCrescent.enable {
    home.packages = with pkgs; [
      
    ];
  };
}
