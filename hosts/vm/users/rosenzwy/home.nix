{ config, pkgs, lib, inputs, outputs, ... }:

{
  myHome = {
    desktop = {
      enable = true;
      preset = "gnome";
    };

    dotfiles = {
      enable = true;
      fish = {
        homeManager = {
          enable = true;
        };
      };
      yazi = {
        homeManager = {
          enable = true;
        };
      };
      starship = {
        homeManager = {
          enable = true;
        };
      };
    };

    develop = {
      enable = true;
      devenv = {
        enable = false;
        autoSwitch = false;
        shell = "fish";
        templates = false;
        cache = false;
      };
    };

    profiles = {
      enable = true;
      fonts = {
        enable = true;
        preset = "basic";
      };
    };
  };
}
