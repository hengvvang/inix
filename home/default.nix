{ config, lib, pkgs, ... }:

{
  imports = [
    ./develop
    ./profiles
    ./dotfiles
  ];
}
