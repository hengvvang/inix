{ config, lib, pkgs, ... }:

{
  imports = [
    ./desktop
    ./locale
    ./services
    ./profiles
  ];
}
