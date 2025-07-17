{ config, lib, pkgs, ... }:

{
  imports = [
    ./waning-crescent.nix
    ./last-quarter.nix
    ./waning-gibbous.nix
    ./new-moon.nix
  ];
}
