# 🌔 盈凸月

{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.pkgs.toolkits.waxingGibbous.enable {
    environment.systemPackages = with pkgs; [

    ];
  };
}
