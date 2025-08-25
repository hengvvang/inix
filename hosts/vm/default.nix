{ config, lib, pkgs, inputs, outputs, userMapping, hostMapping, ... }:

{
  imports = [
    outputs.system
    ./hardware.nix
    ./system.nix
  ];
}
