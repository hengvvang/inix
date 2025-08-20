{ lib, ... }:

{
  options.myHome.desktop.hyprland = {

    packages = {
      enable = lib.mkEnableOption "Enable Hyprland ecosystem packages";
      method = lib.mkOption {
        type = lib.types.enum [ "copy" "symlink" "homemanager" ];
        default = "copy";
        description = "Method to deploy Hyprland configuration files: copy (file copy), symlink (symbolic link), or homemanager (Home Manager native)";
      };
    };

    # 环境变量选项
    environment = {
      enable = lib.mkEnableOption "Enable Hyprland environment variables";
      method = lib.mkOption {
        type = lib.types.enum [ "copy" "symlink" "homemanager" ];
        default = "copy";
        description = "Method to deploy Hyprland configuration files: copy (file copy), symlink (symbolic link), or homemanager (Home Manager native)";
      };
    };

    hypr = {
      enable = lib.mkEnableOption "Enable Hyprland core configuration";
      method = lib.mkOption {
        type = lib.types.enum [ "copy" "symlink" "homemanager" ];
        default = "copy";
        description = "Method to deploy Hyprland configuration files: copy (file copy), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install Hyprland packages";
      };
    };

    waybar = {
      enable = lib.mkEnableOption "Enable Waybar configuration";
      method = lib.mkOption {
        type = lib.types.enum [ "copy" "symlink" "homemanager" ];
        default = "copy";
        description = "Method to deploy Waybar configuration files: copy (file copy), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install Waybar package";
      };
    };

    dunst = {
      enable = lib.mkEnableOption "Enable Dunst notification daemon configuration";
      method = lib.mkOption {
        type = lib.types.enum [ "copy" "symlink" "homemanager" ];
        default = "copy";
        description = "Method to deploy Dunst configuration files: copy (file copy), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install Dunst package";
      };
    };

    rofi = {
      enable = lib.mkEnableOption "Enable Rofi application launcher configuration";
      method = lib.mkOption {
        type = lib.types.enum [ "copy" "symlink" "homemanager" ];
        default = "copy";
        description = "Method to deploy Rofi configuration files: copy (file copy), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install Rofi package";
      };
    };

    swappy = {
      enable = lib.mkEnableOption "Enable Swappy screenshot annotation tool configuration";
      method = lib.mkOption {
        type = lib.types.enum [ "copy" "symlink" "homemanager" ];
        default = "copy";
        description = "Method to deploy Swappy configuration files: copy (file copy), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install Swappy package";
      };
    };

    wlogout = {
      enable = lib.mkEnableOption "Enable Wlogout session manager configuration";
      method = lib.mkOption {
        type = lib.types.enum [ "copy" "symlink" "homemanager" ];
        default = "copy";
        description = "Method to deploy Wlogout configuration files: copy (file copy), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install Wlogout package";
      };
    };

    fuzzel = {
      enable = lib.mkEnableOption "Enable Fuzzel application launcher configuration";
      method = lib.mkOption {
        type = lib.types.enum [ "copy" "symlink" "homemanager" ];
        default = "copy";
        description = "Method to deploy Fuzzel configuration files: copy (file copy), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install Fuzzel package";
      };
    };

    ironbar = {
      enable = lib.mkEnableOption "Enable IronBar status bar configuration";
      method = lib.mkOption {
        type = lib.types.enum [ "copy" "symlink" "homemanager" ];
        default = "copy";
        description = "Method to deploy IronBar configuration files: copy (file copy), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install IronBar package";
      };
    };
  };
}
