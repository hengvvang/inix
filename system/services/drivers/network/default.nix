{ config, lib, pkgs, ... }:

{
  imports = [
    ./wifi.nix
    ./bluetooth.nix
    ./ethernet.nix
  ];
}
