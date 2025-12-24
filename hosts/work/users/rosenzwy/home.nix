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
        enable = true;
        style = "nixStyle";
      };
      zsh = {
        enable = false;
        style = "nixStyle";
      };
      bash = {
        enable = true;
        style = "nixStyle";
      };
      fish = {
        enable = true;
        style = "nixStyle";
      };
      nushell = {
        enable = false;
        style = "nixStyle";
      };
      yazi = {
        enable = true;
        style = "nixStyle";
      };
      ghostty = {
        enable = false;
        style = "nixStyle";
      };
      alacritty = {
        enable = false;
        style = "copyStyle";
      };
      tmux = {
        enable = false;
        style = "nixStyle";
      };
      git = {
        enable = true;
        style = "nixStyle";
      };
      lazygit = {
        enable = false;
        style = "nixStyle";
      };
      starship = {
        enable = true;
        style = "nixStyle";
      };
      ripgrep = {
        enable = true;
        style = "nixStyle";
      };
      fd = {
        enable = true;
        style = "nixStyle";
      };
      lsd = {
        enable = true;
        style = "nixStyle";
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
