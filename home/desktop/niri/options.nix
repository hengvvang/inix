{ lib, ... }:

{
  options.myHome.desktop.niri = {

    packages = {
      enable = lib.mkEnableOption "Enable Niri ecosystem packages";
      method = lib.mkOption {
        type = lib.types.enum [ "copy" "symlink" "homemanager" ];
        default = "copy";
        description = "Method to deploy Niri configuration files: copy (file copy), symlink (symbolic link), or homemanager (Home Manager native)";
      };
    };

    # 环境变量选项
    environment = {
      enable = lib.mkEnableOption "Enable Niri environment variables";
      method = lib.mkOption {
        type = lib.types.enum [ "copy" "symlink" "homemanager" ];
        default = "copy";
        description = "Method to deploy Niri configuration files: copy (file copy), symlink (symbolic link), or homemanager (Home Manager native)";
      };
    };

    niri = {
      enable = lib.mkEnableOption "Enable Niri core configuration";
      method = lib.mkOption {
        type = lib.types.enum [ "copy" "symlink" "homemanager" ];
        default = "copy";
        description = "Method to deploy Niri configuration files: copy (file copy), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install Niri packages";
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

    ironbar = {
      enable = lib.mkEnableOption "Enable Ironbar configuration";
      method = lib.mkOption {
        type = lib.types.enum [ "copy" "symlink" "homemanager" ];
        default = "copy";
        description = "Method to deploy Ironbar configuration files: copy (file copy), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install Ironbar package";
      };
    };

    rofi = {
      enable = lib.mkEnableOption "Enable Rofi configuration";
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

    fuzzel = {
      enable = lib.mkEnableOption "Enable Fuzzel configuration";
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

    swaylock = {
      enable = lib.mkEnableOption "Enable Swaylock configuration";
      method = lib.mkOption {
        type = lib.types.enum [ "copy" "symlink" "homemanager" ];
        default = "copy";
        description = "Method to deploy Swaylock configuration files: copy (file copy), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install Swaylock package";
      };
    };

    swayidle = {
      enable = lib.mkEnableOption "Enable Swayidle configuration";
      method = lib.mkOption {
        type = lib.types.enum [ "copy" "symlink" "homemanager" ];
        default = "copy";
        description = "Method to deploy Swayidle configuration files: copy (file copy), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install Swayidle package";
      };
    };

    wlogout = {
      enable = lib.mkEnableOption "Enable Wlogout configuration";
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

    dunst = {
      enable = lib.mkEnableOption "Enable Dunst configuration";
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

    mako = {
      enable = lib.mkEnableOption "Enable Mako configuration";
      method = lib.mkOption {
        type = lib.types.enum [ "copy" "symlink" "homemanager" ];
        default = "copy";
        description = "Method to deploy Mako configuration files: copy (file copy), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install Mako package";
      };
    };

    appearance = {
      enable = lib.mkEnableOption "Enable Niri appearance configuration";
      method = lib.mkOption {
        type = lib.types.enum [ "copy" "symlink" "homemanager" ];
        default = "homemanager";
        description = "Method to deploy appearance configuration files: copy (file copy), symlink (symbolic link), or homemanager (Home Manager native)";
      };
    };
  };
}
