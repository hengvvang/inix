{ config, pkgs, lib, inputs, outputs, ... }:

{
  myHome = {
    desktop = {
      enable = true;
      preset = "kde";
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

    dotfiles = {
      enable = true;
      vim = {
        homeManager = {
          enable = true;
        };
      };
      zsh = {
        homeManager = {
          enable = false;
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
      nushell = {
        homeManager = {
          enable = false;
        };
      };
      yazi = {
        homeManager = {
          enable = true;
        };
      };
      ghostty = {
        homeManager = {
          enable = false;
        };
      };
      alacritty = {
        copyLink = {
          enable = false;
        };
      };
      tmux = {
        homeManager = {
          enable = false;
        };
      };
      git = {
        homeManager = {
          enable = true;
        };
      };
      lazygit = {
        homeManager = {
          enable = false;
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

    profiles = {
      enable = true;
      fonts = {
        enable = true;
        preset = "nordic";
      };
      stylix = {
        enable = true;
        wallpaper = "${inputs.wallpapers}/wallpapers/minimal/minimal-nordic.jpg";
        colorScheme = "nord";
        polarity = "dark";
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
