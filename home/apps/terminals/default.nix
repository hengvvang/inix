{ config, lib, pkgs, ... }:

{
  options.myHome.apps.terminals = {
    ghostty = lib.mkEnableOption "Ghostty 终端";
  };

  imports = [
    ./ghostty.nix
  ];
}