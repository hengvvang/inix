{ config, pkgs, lib, inputs, outputs, ... }:

{
  imports = [
    outputs.home
    ./apps.nix
    ./toolkits.nix
  ];

  config = {
    nixpkgs.config.allowUnfree = true;
    home.username = zlritsu;
    home.homeDirectory = "/home/zlritsu";
    home.stateVersion = "25.05";
    programs.home-manager.enable = true;
  };
}
