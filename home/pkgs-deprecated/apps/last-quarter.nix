# 🌗 下弦月

{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.pkgs.apps.lastQuarter.enable {
    home.packages = with pkgs; [
      
    ];
  };
}
