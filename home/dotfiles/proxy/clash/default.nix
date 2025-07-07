{ config, lib, pkgs, ... }:

{
  imports = [
    ./homemanager.nix
    ./direct.nix
    ./external.nix
  ];
}
