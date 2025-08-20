{ config, lib, pkgs, ... }:

{
  imports = [
    ../options.nix
    ./hypr
  ];
}
