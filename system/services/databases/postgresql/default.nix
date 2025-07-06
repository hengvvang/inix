{ config, lib, pkgs, ... }:

{
  imports = [
    ./core.nix
    ./backup.nix
    ./replication.nix
    ./monitoring.nix
  ];
}
