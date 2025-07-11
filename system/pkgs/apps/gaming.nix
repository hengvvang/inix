{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.pkgs.apps.gaming.enable {
    environment.systemPackages = with pkgs; [
      # steam           # Steam 游戏平台
    ];
  };
}
