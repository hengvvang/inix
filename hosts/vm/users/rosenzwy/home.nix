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
        homeManager = {
          enable = true;
        };
      };
      bash = {
        homeManager = {
          enable = true;
        };
      };
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
      git = {
        homeManager = {
          enable = true;
        };
      };
      starship = {
        homeManager = {
          enable = true;
        };
      };
      ripgrep = {
        homeManager = {
          enable = true;
        };
      };
      fd = {
        homeManager = {
          enable = true;
        };
      };
      lsd = {
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
