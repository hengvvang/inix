{ config, lib, pkgs, ... }:

{
  imports = [
    ./options.nix
    ./nixMod
    ./tilde
  ];
}
