{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.pkgs.apps.shells.enable {
    environment.systemPackages = with pkgs; [
      fish            # Fish shell
      nushell         # Nushell
    ];
  };
}
