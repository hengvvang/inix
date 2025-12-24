{ lib, ... }:

{
  options.myHome.desktop.niri = {

    packages = {
      enable = lib.mkEnableOption "Enable Niri ecosystem packages" // { default = false; };
      configStyle = lib.mkOption {
        type = lib.types.enum [ "homeManager" "copyFiles" ];
        default = "copyFiles";
        description = "Configuration style: homeManager (Home Manager) or copyFiles (copy files)";
      };
    };

    # 环境变量选项
    environment = {
      enable = lib.mkEnableOption "Enable Niri environment variables" // { default = false; };
      configStyle = lib.mkOption {
        type = lib.types.enum [ "homeManager" "copyFiles" ];
        default = "copyFiles";
        description = "Configuration style: homeManager (Home Manager) or copyFiles (copy files)";
      };
    };

    niri = {
      enable = lib.mkEnableOption "Enable Niri core configuration" // { default = false; };
      configStyle = lib.mkOption {
        type = lib.types.enum [ "homeManager" "copyFiles" ];
        default = "copyFiles";
        description = "Configuration style: homeManager (Home Manager) or copyFiles (copy files)";
      };
    };

    waybar = {
      enable = lib.mkEnableOption "Enable Waybar configuration" // { default = false; };
      configStyle = lib.mkOption {
        type = lib.types.enum [ "homeManager" "copyFiles" ];
        default = "copyFiles";
        description = "Configuration style: homeManager (Home Manager) or copyFiles (copy files)";
      };
    };

    ironbar = {
      enable = lib.mkEnableOption "Enable Ironbar configuration" // { default = false; };
      configStyle = lib.mkOption {
        type = lib.types.enum [ "homeManager" "copyFiles" ];
        default = "copyFiles";
        description = "Configuration style: homeManager (Home Manager) or copyFiles (copy files)";
      };
    };

    rofi = {
      enable = lib.mkEnableOption "Enable Rofi configuration" // { default = false; };
      configStyle = lib.mkOption {
        type = lib.types.enum [ "homeManager" "copyFiles" ];
        default = "copyFiles";
        description = "Configuration style: homeManager (Home Manager) or copyFiles (copy files)";
      };
    };

    vicinae = {
      enable = lib.mkEnableOption "Enable Vicinae configuration" // { default = false; };
      configStyle = lib.mkOption {
        type = lib.types.enum [ "homeManager" "copyFiles" ];
        default = "copyFiles";
        description = "Configuration style: homeManager (Home Manager) or copyFiles (copy files)";
      };
    };

    fuzzel = {
      enable = lib.mkEnableOption "Enable Fuzzel configuration" // { default = false; };
      configStyle = lib.mkOption {
        type = lib.types.enum [ "homeManager" "copyFiles" ];
        default = "copyFiles";
        description = "Configuration style: homeManager (Home Manager) or copyFiles (copy files)";
      };
    };

    swaylock = {
      enable = lib.mkEnableOption "Enable Swaylock configuration" // { default = false; };
      configStyle = lib.mkOption {
        type = lib.types.enum [ "homeManager" "copyFiles" ];
        default = "copyFiles";
        description = "Configuration style: homeManager (Home Manager) or copyFiles (copy files)";
      };
    };

    swayidle = {
      enable = lib.mkEnableOption "Enable Swayidle configuration" // { default = false; };
      configStyle = lib.mkOption {
        type = lib.types.enum [ "homeManager" "copyFiles" ];
        default = "copyFiles";
        description = "Configuration style: homeManager (Home Manager) or copyFiles (copy files)";
      };
    };

    wlogout = {
      enable = lib.mkEnableOption "Enable Wlogout configuration" // { default = false; };
      configStyle = lib.mkOption {
        type = lib.types.enum [ "homeManager" "copyFiles" ];
        default = "copyFiles";
        description = "Configuration style: homeManager (Home Manager) or copyFiles (copy files)";
      };
    };

    dunst = {
      enable = lib.mkEnableOption "Enable Dunst configuration" // { default = false; };
      configStyle = lib.mkOption {
        type = lib.types.enum [ "homeManager" "copyFiles" ];
        default = "copyFiles";
        description = "Configuration style: homeManager (Home Manager) or copyFiles (copy files)";
      };
    };

    mako = {
      enable = lib.mkEnableOption "Enable Mako configuration" // { default = false; };
      configStyle = lib.mkOption {
        type = lib.types.enum [ "homeManager" "copyFiles" ];
        default = "copyFiles";
        description = "Configuration style: homeManager (Home Manager) or copyFiles (copy files)";
      };
    };

    appearance = {
      enable = lib.mkEnableOption "Enable Niri appearance configuration" // { default = false; };
      configStyle = lib.mkOption {
        type = lib.types.enum [ "homeManager" "copyFiles" ];
        default = "copyFiles";
        description = "Configuration style: homeManager (Home Manager) or copyFiles (copy files)";
      };
    };
  };
}
