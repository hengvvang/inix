{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.docker.enable {

    virtualisation.docker.enable = true;

  };
}
