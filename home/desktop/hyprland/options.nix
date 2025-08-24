{ lib, ... }:

{
  options.myHome.desktop.hyprland = {

    packages = {
      enable = lib.mkEnableOption "Enable Hyprland ecosystem packages" // { default = true; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symLink" "homeManager" ];
        default = "copyLink";
        description = "Method to deploy Hyprland configuration files: copyLink (file copyLink), symLink (symbolic link), or homeManager (Home Manager native)";
      };
    };

    # 环境变量选项
    environment = {
      enable = lib.mkEnableOption "Enable Hyprland environment variables" // { default = true; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symLink" "homeManager" ];
        default = "copyLink";
        description = "Method to deploy Hyprland configuration files: copyLink (file copyLink), symLink (symbolic link), or homeManager (Home Manager native)";
      };
    };

    hypr = {
      enable = lib.mkEnableOption "Enable Hyprland core configuration" // { default = true; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symLink" "homeManager" ];
        default = "copyLink";
        description = "Method to deploy Hyprland configuration files: copyLink (file copyLink), symLink (symbolic link), or homeManager (Home Manager native)";
      };
      packageSource = lib.mkOption {
        type = lib.types.enum [ "none" "nixpkgs" "flake" ];
        default = "flake";
        description = ''
          Source for Hyprland package installation:
          - none: Don't install Hyprland package (use system-level installation)
          - nixpkgs: Use stable Hyprland package from nixpkgs
          - flake: Use newer Hyprland package from official upstream flake
        '';
      };
    };

    waybar = {
      enable = lib.mkEnableOption "Enable Waybar configuration" // { default = true; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symLink" "homeManager" ];
        default = "copyLink";
        description = "Method to deploy Waybar configuration files: copyLink (file copyLink), symLink (symbolic link), or homeManager (Home Manager native)";
      };
      packageSource = lib.mkOption {
        type = lib.types.enum [ "none" "nixpkgs" "flake" ];
        default = "nixpkgs";
        description = ''
          Source for Waybar package installation:
          - none: Don't install Waybar package
          - nixpkgs: Use Waybar package from nixpkgs
          - flake: Use Waybar package from flake
        '';
      };
    };

    dunst = {
      enable = lib.mkEnableOption "Enable Dunst notification daemon configuration" // { default = true; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symLink" "homeManager" ];
        default = "copyLink";
        description = "Method to deploy Dunst configuration files: copyLink (file copyLink), symLink (symbolic link), or homeManager (Home Manager native)";
      };
      packageSource = lib.mkOption {
        type = lib.types.enum [ "none" "nixpkgs" "flake" ];
        default = "nixpkgs";
        description = ''
          Source for Dunst package installation:
          - none: Don't install Dunst package
          - nixpkgs: Use Dunst package from nixpkgs
          - flake: Use Dunst package from flake
        '';
      };
    };

    rofi = {
      enable = lib.mkEnableOption "Enable Rofi application launcher configuration" // { default = true; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symLink" "homeManager" ];
        default = "copyLink";
        description = "Method to deploy Rofi configuration files: copyLink (file copyLink), symLink (symbolic link), or homeManager (Home Manager native)";
      };
      packageSource = lib.mkOption {
        type = lib.types.enum [ "none" "nixpkgs" "flake" ];
        default = "nixpkgs";
        description = ''
          Source for Rofi package installation:
          - none: Don't install Rofi package
          - nixpkgs: Use Rofi package from nixpkgs
          - flake: Use Rofi package from flake
        '';
      };
    };

    swappy = {
      enable = lib.mkEnableOption "Enable Swappy screenshot annotation tool configuration" // { default = true; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symLink" "homeManager" ];
        default = "copyLink";
        description = "Method to deploy Swappy configuration files: copyLink (file copyLink), symLink (symbolic link), or homeManager (Home Manager native)";
      };
      packageSource = lib.mkOption {
        type = lib.types.enum [ "none" "nixpkgs" "flake" ];
        default = "nixpkgs";
        description = ''
          Source for Swappy package installation:
          - none: Don't install Swappy package
          - nixpkgs: Use Swappy package from nixpkgs
          - flake: Use Swappy package from flake
        '';
      };
    };

    wlogout = {
      enable = lib.mkEnableOption "Enable Wlogout session manager configuration" // { default = true; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symLink" "homeManager" ];
        default = "copyLink";
        description = "Method to deploy Wlogout configuration files: copyLink (file copyLink), symLink (symbolic link), or homeManager (Home Manager native)";
      };
      packageSource = lib.mkOption {
        type = lib.types.enum [ "none" "nixpkgs" "flake" ];
        default = "nixpkgs";
        description = ''
          Source for Wlogout package installation:
          - none: Don't install Wlogout package
          - nixpkgs: Use Wlogout package from nixpkgs
          - flake: Use Wlogout package from flake
        '';
      };
    };

    fuzzel = {
      enable = lib.mkEnableOption "Enable Fuzzel application launcher configuration" // { default = true; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symLink" "homeManager" ];
        default = "copyLink";
        description = "Method to deploy Fuzzel configuration files: copyLink (file copyLink), symLink (symbolic link), or homeManager (Home Manager native)";
      };
      packageSource = lib.mkOption {
        type = lib.types.enum [ "none" "nixpkgs" "flake" ];
        default = "nixpkgs";
        description = ''
          Source for Fuzzel package installation:
          - none: Don't install Fuzzel package
          - nixpkgs: Use Fuzzel package from nixpkgs
          - flake: Use Fuzzel package from flake
        '';
      };
    };

    ironbar = {
      enable = lib.mkEnableOption "Enable IronBar status bar configuration" // { default = true; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symLink" "homeManager" ];
        default = "copyLink";
        description = "Method to deploy IronBar configuration files: copyLink (file copyLink), symLink (symbolic link), or homeManager (Home Manager native)";
      };
      packageSource = lib.mkOption {
        type = lib.types.enum [ "none" "nixpkgs" "flake" ];
        default = "nixpkgs";
        description = ''
          Source for IronBar package installation:
          - none: Don't install IronBar package
          - nixpkgs: Use IronBar package from nixpkgs
          - flake: Use IronBar package from flake
        '';
      };
    };
  };
}
