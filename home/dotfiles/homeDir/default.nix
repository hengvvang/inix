{ config, lib, pkgs, ... }:

{
  imports = [
    ./copyLink.nix
    ./realTime.nix
  ];
}
