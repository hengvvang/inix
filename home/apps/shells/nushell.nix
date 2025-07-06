{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.apps.shells.nushell.enable {
    programs.nushell = {
      enable = true;
    };
  };
}