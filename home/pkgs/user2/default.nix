{ config, lib, pkgs, ... }:

{
  imports = [
    ./apps.nix
    ./toolkits.nix
  ];
}
