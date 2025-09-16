{ config, pkgs, lib, inputs, outputs, userName, ... }:

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
    home.username = userName;
    home.homeDirectory = "/Users/${userName}";
    home.stateVersion = "25.05";
    programs.home-manager.enable = true;
  };
}
