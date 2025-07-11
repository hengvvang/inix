{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.pkgs.apps.terminals.enable {
    environment.systemPackages = with pkgs; [
      ghostty         # Ghostty 终端
    ];
  };
}
