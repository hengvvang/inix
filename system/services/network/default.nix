{ config, lib, pkgs, ... }:

{
  imports = [
    ./ssh
    ./tailscale.nix
    ./wireguard.nix
    ./tools.nix
  ];
}
