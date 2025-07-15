# 🌖 亏凸月

{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.pkgs.apps.waningGibbous.enable {
    environment.systemPackages = with pkgs; [
      nano
      vim
      git
    ];
  };
}
