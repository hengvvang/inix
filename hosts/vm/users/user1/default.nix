{ config, pkgs, lib, inputs, outputs, userMapping, hostMapping, ... }:

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
    home.username = userMapping.user1;
    home.homeDirectory = "/home/${userMapping.user1}";
    home.stateVersion = "25.05";
    programs.home-manager.enable = true;

  };
}
