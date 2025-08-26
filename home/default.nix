{ config, lib, pkgs, ... }:

{
  imports = [
    ./develop
    ./desktop
    ./profiles
    ./dotfiles
    ./services
  ];
}
