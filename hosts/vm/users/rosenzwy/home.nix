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
        enable = true;
        configStyle = "homeManager";
      };
      yazi = {
        enable = true;
        configStyle = "homeManager";
      };
      starship = {
        enable = true;
        configStyle = "homeManager";
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
