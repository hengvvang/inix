# 🌕 满月

{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.pkgs.toolkits.fullMoon.enable {
    home.packages = with pkgs; [
      
    ];
  };
}
