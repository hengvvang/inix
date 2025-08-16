{ config, lib, pkgs, ... }:

{
  imports = [
    ./app.nix
    ./toolkit.nix
  ];
}
