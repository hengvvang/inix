{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myPkgs.apps.terminals.enable {
    environment.systemPackages = with pkgs; [
      ghostty         # Ghostty 终端
    ];
  };
}
