{ config, lib, pkgs, ... }:

{
  imports = [
    ./editors
    ./terminals
    ./shells
  ];
}