{ config, lib, pkgs, ... }:

{
  imports = [
    ./options.nix
    ./homeDir
    ./nixMod
  ];
}
