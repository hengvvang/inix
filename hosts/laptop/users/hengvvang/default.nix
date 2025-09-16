{ config, pkgs, lib, inputs, outputs, userName, ... }:

{
  imports = [
    outputs.home
    ./home.nix
    ./apps.nix
    ./develop.nix
  ];

  config = {
    nixpkgs.config = {
      allowUnfree = true;
    };
    home.username = userName;
    home.homeDirectory = "/home/${userName}";
    home.stateVersion = "25.05";
    programs.home-manager.enable = true;
  };
}
