{ config, lib, pkgs, ... }:

{
  imports = [
    ./desktop-environment.nix
    ./hardware.nix
    ./localization.nix
    ./users.nix
    ./packages.nix
  ];
}
