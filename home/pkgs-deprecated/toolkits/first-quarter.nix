# 🌓 上弦月

{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.pkgs.toolkits.firstQuarter.enable {
    home.packages = with pkgs; [
      

    ];
  };
}
