{ config, lib, pkgs, ... }:

{
  imports = [
    ./git.nix
    ./editors.nix
    ./languages.nix
    ./embedded.nix
    ./modern-tools.nix
  ];
}
