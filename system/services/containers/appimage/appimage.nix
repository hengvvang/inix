{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.containers.appimage;
in
{
  config = lib.mkIf cfg.enable {
    programs.appimage = {
      package = pkgs.appimage-run;
      enable = true;
      binfmt = true;
    };
  };
}
