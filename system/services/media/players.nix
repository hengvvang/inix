{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.media.players.enable {
    environment.systemPackages = with pkgs; [
      mpv
      vlc
    ];
  };
}