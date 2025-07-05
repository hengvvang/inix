{ config, lib, pkgs, ... }:

{
    imports = [
        ./utilities.nix
        ./hardware.nix
        ./network.nix
        ./monitor.nix
    ];
}