{ config, lib, pkgs, ... }:

{
  imports = [
    ./docker
    ./network
    ./media
    ./drivers
  ];
}
