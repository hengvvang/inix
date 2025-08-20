{ config, lib, pkgs, ... }:

{
  imports = [
    ./options.nix
    ./tilde
    ./nixMod
  ];
}
