{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myPkgs.apps.office.enable {
    environment.systemPackages = with pkgs; [
      wpsoffice-cn    # WPS Office
    ];
  };
}
