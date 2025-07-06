{ config, lib, pkgs, ... }:

{
  imports = [
    ./tailscale
    ./ssh
  ];
}
