{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.pkgs.apps.office.enable {
    environment.systemPackages = with pkgs; [
      wpsoffice-cn    # WPS Office
    ];
  };
}
