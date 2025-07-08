{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myPkgs.apps.shells.enable {
    environment.systemPackages = with pkgs; [
      fish            # Fish shell
      nushell         # Nushell
    ];
  };
}
