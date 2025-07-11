{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.pkgs.apps.office.enable {
    home.packages = with pkgs; [
      wpsoffice-cn    # WPS Office
    ];
  };
}
