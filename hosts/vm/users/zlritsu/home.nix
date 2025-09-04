{ config, pkgs, lib, inputs, outputs, ... }:

{
  myHome = {
    desktop = {
      enable = true;
      preset = "gnome";
    };

    dotfiles = {
      enable = true;
      vim = {
        enable = true;
        method = "homeManager";
      };
      bash = {
        enable = true;
        method = "homeManager";
      };
      fish = {
        enable = true;
        method = "homeManager";
      };
      yazi = {
        enable = true;
        method = "homeManager";
      };
      git.enable = true;
      starship = {
        enable = true;
        method = "homeManager";
      };
      ripgrep.enable = true;
      fd.enable = true;
      lsd.enable = true;
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
      python.enable = true;
      rust.enable = false;
      javascript.enable = false;
      typescript.enable = false;
      cpp.enable = false;
    };

    profiles = {
      enable = true;
      fonts = {
        enable = true;
        preset = "basic";
      };
      stylix = {
        enable = false;
      };
    };

    services = {
      media = {
        mpd.enable = false;
      };
      proxy = {
        v2ray.enable = false;
        mihomo.enable = false;
      };
    };
  };
}
