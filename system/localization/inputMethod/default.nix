{ config, lib, pkgs, ... }:

{
  imports = [
    ./fcitx5.nix
    ./ibus.nix
  ];
}
