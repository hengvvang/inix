{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./copyLink.nix
    ./realTime.nix
  ];
}
