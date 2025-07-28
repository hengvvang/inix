# 🌖 亏凸月

{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.pkgs.apps.waningGibbous.enable {
    home.packages = with pkgs; [

    ];
  };
}
