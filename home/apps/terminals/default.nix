{ config, lib, pkgs, ... }:

{
  options.myHome.apps.terminals = {
    ghostty.enable = lib.mkEnableOption "Ghostty 终端";
  };

  imports = [
    ./ghostty.nix
  ];
}