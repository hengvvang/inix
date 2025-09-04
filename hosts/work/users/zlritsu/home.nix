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
      rust.enable = false;
      python.enable = true;
      javascript.enable = true;
      typescript.enable = false;
      cpp.enable = false;
    };

    dotfiles = {
      enable = true;
      vim = {
        enable = true;
        method = "homeManager";
      };
      zsh = {
        enable = false;
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
      nushell = {
        enable = false;
        method = "homeManager";
      };
      yazi = {
        enable = true;
        method = "homeManager";
      };
      ghostty = {
        enable = false;
        method = "homeManager";
      };
      alacritty = {
        enable = false;
        method = "copyLink";
      };
      tmux.enable = false;
      git.enable = true;
      lazygit.enable = false;
      starship = {
        enable = true;
        method = "homeManager";
      };
      ripgrep.enable = true;
      fd.enable = true;
      lsd.enable = true;
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
