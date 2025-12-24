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
        configStyle = "homeManager";
      };
      zsh = {
        enable = false;
        configStyle = "homeManager";
      };
      bash = {
        enable = true;
        configStyle = "homeManager";
      };
      fish = {
        enable = true;
        configStyle = "homeManager";
      };
      nushell = {
        enable = false;
        configStyle = "homeManager";
      };
      yazi = {
        enable = true;
        configStyle = "homeManager";
      };
      ghostty = {
        enable = false;
        configStyle = "homeManager";
      };
      alacritty = {
        enable = false;
        configStyle = "copyFiles";
      };
      tmux = {
        enable = false;
        configStyle = "homeManager";
      };
      git = {
        enable = true;
        configStyle = "homeManager";
      };
      lazygit = {
        enable = false;
        configStyle = "homeManager";
      };
      starship = {
        enable = true;
        configStyle = "homeManager";
      };
      ripgrep = {
        enable = true;
        configStyle = "homeManager";
      };
      fd = {
        enable = true;
        configStyle = "homeManager";
      };
      lsd = {
        enable = true;
        configStyle = "homeManager";
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
