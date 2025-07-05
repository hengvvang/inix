{ config, lib, pkgs, ... }:

{
  imports = [
    ./communication.nix
    ./terminal.nix
    ./utilities.nix
  ];
}