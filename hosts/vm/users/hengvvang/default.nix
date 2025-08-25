{ config, pkgs, lib, inputs, outputs, ... }:

{
  imports = [
    outputs.home
  ];

  config = {
    nixpkgs.config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "libsoup-2.74.3"
      ];
    };
    home.username = hengvvang;
    home.homeDirectory = "/home/hengvvang";
    home.stateVersion = "25.05";
    programs.home-manager.enable = true;

  };
}
