{ config, pkgs, lib, inputs, outputs, ... }:

{
  imports = [
    outputs.home
    ./home.nix
    ./apps.nix
  ];

  config = {
    nixpkgs.config = {
      allowUnfree = true;
    };
    home.username = "hengvvang";
    home.homeDirectory = "/home/hengvvang";
    home.stateVersion = "25.05";
    programs.home-manager.enable = true;
  };
}
