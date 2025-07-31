{ config, lib, pkgs, ... }:

{
  imports = [
    ./develop
    ./desktop
    ./profiles
    ./dotfiles
    ./pkgs
    ./services
  ];
}
