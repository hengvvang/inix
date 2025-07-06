{ config, lib, pkgs, ... }:

{
  imports = [
    ./ssd.nix
    ./usb.nix
  ];
}
