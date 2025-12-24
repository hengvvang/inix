{ lib, ... }:

{
  options.myHome.desktop.hyprland = {

    packages = {
      enable = lib.mkEnableOption "Enable Hyprland ecosystem packages" // { default = false; };
      style = lib.mkOption {
        type = lib.types.enum [ "nixStyle" "copyStyle" ];
        default = "copyStyle";
        description = "Configuration style: nixStyle (Home Manager) or copyStyle (copy files)";
      };
    };

    # 环境变量选项
    environment = {
      enable = lib.mkEnableOption "Enable Hyprland environment variables" // { default = false; };
      style = lib.mkOption {
        type = lib.types.enum [ "nixStyle" "copyStyle" ];
        default = "copyStyle";
        description = "Configuration style: nixStyle (Home Manager) or copyStyle (copy files)";
      };
    };

    hypr = {
      enable = lib.mkEnableOption "Enable Hyprland core configuration" // { default = false; };
      style = lib.mkOption {
        type = lib.types.enum [ "nixStyle" "copyStyle" ];
        default = "copyStyle";
        description = "Configuration style: nixStyle (Home Manager) or copyStyle (copy files)";
      };
    };

    waybar = {
      enable = lib.mkEnableOption "Enable Waybar configuration" // { default = false; };
      style = lib.mkOption {
        type = lib.types.enum [ "nixStyle" "copyStyle" ];
        default = "copyStyle";
        description = "Configuration style: nixStyle (Home Manager) or copyStyle (copy files)";
      };
    };

    dunst = {
      enable = lib.mkEnableOption "Enable Dunst configuration" // { default = false; };
      style = lib.mkOption {
        type = lib.types.enum [ "nixStyle" "copyStyle" ];
        default = "copyStyle";
        description = "Configuration style: nixStyle (Home Manager) or copyStyle (copy files)";
      };
    };

    rofi = {
      enable = lib.mkEnableOption "Enable Rofi configuration" // { default = false; };
      style = lib.mkOption {
        type = lib.types.enum [ "nixStyle" "copyStyle" ];
        default = "copyStyle";
        description = "Configuration style: nixStyle (Home Manager) or copyStyle (copy files)";
      };
    };

    swappy = {
      enable = lib.mkEnableOption "Enable Swappy configuration" // { default = false; };
      style = lib.mkOption {
        type = lib.types.enum [ "nixStyle" "copyStyle" ];
        default = "copyStyle";
        description = "Configuration style: nixStyle (Home Manager) or copyStyle (copy files)";
      };
    };

    wlogout = {
      enable = lib.mkEnableOption "Enable Wlogout configuration" // { default = false; };
      style = lib.mkOption {
        type = lib.types.enum [ "nixStyle" "copyStyle" ];
        default = "copyStyle";
        description = "Configuration style: nixStyle (Home Manager) or copyStyle (copy files)";
      };
    };

    fuzzel = {
      enable = lib.mkEnableOption "Enable Fuzzel configuration" // { default = false; };
      style = lib.mkOption {
        type = lib.types.enum [ "nixStyle" "copyStyle" ];
        default = "copyStyle";
        description = "Configuration style: nixStyle (Home Manager) or copyStyle (copy files)";
      };
    };

    ironbar = {
      enable = lib.mkEnableOption "Enable IronBar configuration" // { default = false; };
      style = lib.mkOption {
        type = lib.types.enum [ "nixStyle" "copyStyle" ];
        default = "copyStyle";
        description = "Configuration style: nixStyle (Home Manager) or copyStyle (copy files)";
      };
    };

    swaylock = {
      enable = lib.mkEnableOption "Enable Swaylock configuration" // { default = false; };
      style = lib.mkOption {
        type = lib.types.enum [ "nixStyle" "copyStyle" ];
        default = "copyStyle";
        description = "Configuration style: nixStyle (Home Manager) or copyStyle (copy files)";
      };
    };

    swayidle = {
      enable = lib.mkEnableOption "Enable Swayidle configuration" // { default = false; };
      style = lib.mkOption {
        type = lib.types.enum [ "nixStyle" "copyStyle" ];
        default = "copyStyle";
        description = "Configuration style: nixStyle (Home Manager) or copyStyle (copy files)";
      };
    };

    mako = {
      enable = lib.mkEnableOption "Enable Mako configuration" // { default = false; };
      style = lib.mkOption {
        type = lib.types.enum [ "nixStyle" "copyStyle" ];
        default = "copyStyle";
        description = "Configuration style: nixStyle (Home Manager) or copyStyle (copy files)";
      };
    };

    appearance = {
      enable = lib.mkEnableOption "Enable Hyprland appearance configuration" // { default = false; };
      style = lib.mkOption {
        type = lib.types.enum [ "nixStyle" "copyStyle" ];
        default = "copyStyle";
        description = "Configuration style: nixStyle (Home Manager) or copyStyle (copy files)";
      };
    };
  };
}
