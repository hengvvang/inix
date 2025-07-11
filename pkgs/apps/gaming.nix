{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myPkgs.apps.gaming.enable {
    environment.systemPackages = with pkgs; [
      # steam           # Steam 游戏平台
    ];
  };
}
