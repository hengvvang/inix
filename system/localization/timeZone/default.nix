{ config, lib, pkgs, ... }:

{
  imports = [
    ./shanghai.nix
    ./newYork.nix
    ./losAngeles.nix
  ];
}
