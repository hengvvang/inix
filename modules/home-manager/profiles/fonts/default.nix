{ config, lib, pkgs, ... }:

{
  imports = [
    ./fonts.nix
    ./environment.nix
    ./directories.nix
  ];
}