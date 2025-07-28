# 🌔 盈凸月

{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.pkgs.toolkits.waxingGibbous.enable {
    home.packages = with pkgs; [
      
    ];
  };
}
