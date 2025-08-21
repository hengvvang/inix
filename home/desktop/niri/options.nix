{ lib, ... }:

{
  options.myHome.desktop.niri = {

    packages = {
      enable = lib.mkEnableOption "Enable Niri ecosystem packages" // { default = true; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy Niri configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
    };

    # 环境变量选项
    environment = {
      enable = lib.mkEnableOption "Enable Niri environment variables" // { default = true; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy Niri configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
    };

    niri = {
      enable = lib.mkEnableOption "Enable Niri core configuration" // { default = true; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy Niri configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      packageSource = lib.mkOption {
        type = lib.types.enum [ "none" "nixpkgs" "flake" ];
        default = "flake";
        description = ''
          Source for Niri package installation:
          - none: Don't install Niri package (use system-level installation)
          - nixpkgs: Use stable Niri package from nixpkgs
          - flake: Use newer Niri package from official upstream flake
        '';
      };
    };

    waybar = {
      enable = lib.mkEnableOption "Enable Waybar configuration" // { default = true; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy Waybar configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      packageSource = lib.mkOption {
        type = lib.types.enum [ "none" "nixpkgs" ];
        default = "nixpkgs";
        description = ''
          Source for Waybar package installation:
          - none: Don't install Waybar package
          - nixpkgs: Use Waybar package from nixpkgs
        '';
      };
    };

    ironbar = {
      enable = lib.mkEnableOption "Enable Ironbar configuration" // { default = true; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy Ironbar configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      packageSource = lib.mkOption {
        type = lib.types.enum [ "none" "nixpkgs" ];
        default = "nixpkgs";
        description = ''
          Source for Ironbar package installation:
          - none: Don't install Ironbar package
          - nixpkgs: Use Ironbar package from nixpkgs
        '';
      };
    };

    rofi = {
      enable = lib.mkEnableOption "Enable Rofi configuration" // { default = true; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy Rofi configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      packageSource = lib.mkOption {
        type = lib.types.enum [ "none" "nixpkgs" ];
        default = "nixpkgs";
        description = ''
          Source for Rofi package installation:
          - none: Don't install Rofi package
          - nixpkgs: Use Rofi package from nixpkgs
        '';
      };
    };

    fuzzel = {
      enable = lib.mkEnableOption "Enable Fuzzel configuration" // { default = true; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy Fuzzel configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      packageSource = lib.mkOption {
        type = lib.types.enum [ "none" "nixpkgs" ];
        default = "none";
        description = ''
          Source for Fuzzel package installation:
          - none: Don't install Fuzzel package (use system-level installation)
          - nixpkgs: Use Fuzzel package from nixpkgs
        '';
      };
    };

    swaylock = {
      enable = lib.mkEnableOption "Enable Swaylock configuration" // { default = true; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy Swaylock configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      packageSource = lib.mkOption {
        type = lib.types.enum [ "none" "nixpkgs" ];
        default = "nixpkgs";
        description = ''
          Source for Swaylock package installation:
          - none: Don't install Swaylock package
          - nixpkgs: Use Swaylock package from nixpkgs
        '';
      };
    };

    swayidle = {
      enable = lib.mkEnableOption "Enable Swayidle configuration" // { default = true; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy Swayidle configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      packageSource = lib.mkOption {
        type = lib.types.enum [ "none" "nixpkgs" ];
        default = "nixpkgs";
        description = ''
          Source for Swayidle package installation:
          - none: Don't install Swayidle package
          - nixpkgs: Use Swayidle package from nixpkgs
        '';
      };
    };

    wlogout = {
      enable = lib.mkEnableOption "Enable Wlogout configuration" // { default = true; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy Wlogout configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      packageSource = lib.mkOption {
        type = lib.types.enum [ "none" "nixpkgs" ];
        default = "nixpkgs";
        description = ''
          Source for Wlogout package installation:
          - none: Don't install Wlogout package
          - nixpkgs: Use Wlogout package from nixpkgs
        '';
      };
    };

    dunst = {
      enable = lib.mkEnableOption "Enable Dunst configuration" // { default = true; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy Dunst configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      packageSource = lib.mkOption {
        type = lib.types.enum [ "none" "nixpkgs" ];
        default = "nixpkgs";
        description = ''
          Source for Dunst package installation:
          - none: Don't install Dunst package
          - nixpkgs: Use Dunst package from nixpkgs
        '';
      };
    };

    mako = {
      enable = lib.mkEnableOption "Enable Mako configuration" // { default = true; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy Mako configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      packageSource = lib.mkOption {
        type = lib.types.enum [ "none" "nixpkgs" ];
        default = "nixpkgs";
        description = ''
          Source for Mako package installation:
          - none: Don't install Mako package
          - nixpkgs: Use Mako package from nixpkgs
        '';
      };
    };

    appearance = {
      enable = lib.mkEnableOption "Enable Niri appearance configuration" // { default = true; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "homemanager";
        description = "Method to deploy appearance configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
    };
  };
}
