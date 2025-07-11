{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.pkgs.apps.shells.enable {
    home.packages = with pkgs; [
      fish            # Fish shell
      nushell         # Nushell
    ];
  };
}
