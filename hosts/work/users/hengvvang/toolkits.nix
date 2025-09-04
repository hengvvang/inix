{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    nh
    nix-output-monitor
    nix-tree
    nixos-rebuild
    nvd
  ];
}
