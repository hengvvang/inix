{ lib, ... }:

{
  options.myHome.desktop.hyprland = {

    packages = {
      enable = lib.mkEnableOption "Enable Hyprland ecosystem packages" // { default = true; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy Hyprland configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
    };

    # 环境变量选项
    environment = {
      enable = lib.mkEnableOption "Enable Hyprland environment variables" // { default = true; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy Hyprland configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
    };

    hypr = {
      enable = lib.mkEnableOption "Enable Hyprland core configuration" // { default = true; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy Hyprland configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install Hyprland packages";
      };
    };

    waybar = {
      enable = lib.mkEnableOption "Enable Waybar configuration" // { default = true; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy Waybar configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install Waybar package";
      };
    };

    dunst = {
      enable = lib.mkEnableOption "Enable Dunst notification daemon configuration" // { default = true; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy Dunst configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install Dunst package";
      };
    };

    rofi = {
      enable = lib.mkEnableOption "Enable Rofi application launcher configuration" // { default = true; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy Rofi configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install Rofi package";
      };
    };

    swappy = {
      enable = lib.mkEnableOption "Enable Swappy screenshot annotation tool configuration" // { default = true; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy Swappy configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install Swappy package";
      };
    };

    wlogout = {
      enable = lib.mkEnableOption "Enable Wlogout session manager configuration" // { default = true; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy Wlogout configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install Wlogout package";
      };
    };

    fuzzel = {
      enable = lib.mkEnableOption "Enable Fuzzel application launcher configuration" // { default = true; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy Fuzzel configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install Fuzzel package";
      };
    };

    ironbar = {
      enable = lib.mkEnableOption "Enable IronBar status bar configuration" // { default = true; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy IronBar configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install IronBar package";
      };
    };
  };
}
