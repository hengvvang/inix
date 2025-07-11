{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.pkgs.apps.gaming.enable {
    home.packages = with pkgs; [
      # steam           # Steam 游戏平台
    ];
  };
}
