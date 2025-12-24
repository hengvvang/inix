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
        style = "nixStyle";
      };
      yazi = {
        enable = true;
        style = "nixStyle";
      };
      starship = {
        enable = true;
        style = "nixStyle";
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
