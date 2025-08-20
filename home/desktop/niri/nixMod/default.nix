{ config, lib, pkgs, ... }:

{
  imports = [
    ../options.nix
    ./appearance
  ];
}
