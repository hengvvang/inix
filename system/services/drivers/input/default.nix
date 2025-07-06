{ config, lib, pkgs, ... }:

{
  imports = [
    ./touchpad.nix
    ./wacom.nix
  ];
}
