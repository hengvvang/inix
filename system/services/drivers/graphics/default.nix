{ config, lib, pkgs, ... }:

{
  imports = [
    ./nvidia.nix
    ./amd.nix
    ./intel.nix
  ];
}
