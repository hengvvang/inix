{ config, pkgs, lib, inputs, outputs, userMapping, hostMapping, ... }:

{
  imports = [
    outputs.home
  ];

  config = {
    nixpkgs.config.allowUnfree = true;
    home.username = users.user2;
    home.homeDirectory = "/home/${users.user2}";
    home.stateVersion = "25.05";
    programs.home-manager.enable = true;
  };
}
