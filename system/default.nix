{ config, lib, pkgs, ... }:

{
  imports = [
    ./desktop
    ./locale
    ./services
    ./pkgs
    ./profiles
  ];

}
