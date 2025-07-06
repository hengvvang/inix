{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.docker.enable {

    services.openssh.enable = true;

  };
}