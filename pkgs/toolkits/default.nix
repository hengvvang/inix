{ config, lib, pkgs, ... }:

{
  imports = [
    ./waxing-crescent.nix
    ./first-quarter.nix
    ./waxing-gibbous.nix
    ./full-moon.nix
  ];
}
