{ lib, ... }:

{
  options.myHome.desktop.hyprland = {

    packages = {
      enable = lib.mkEnableOption "Enable Hyprland ecosystem packages" // { default = true; };

      copyLink = {
        enable = lib.mkEnableOption "Enable copyLink method for Hyprland ecosystem packages" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for packages installation when using copyLink method:
            - none: Don't install packages
            - nixpkgs: Use packages from nixpkgs
            - flake: Use packages from flake
          '';
        };
      };

      realTime = {
        enable = lib.mkEnableOption "Enable realTime method for Hyprland ecosystem packages" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for packages installation when using realTime method:
            - none: Don't install packages
            - nixpkgs: Use packages from nixpkgs
            - flake: Use packages from flake
          '';
        };
      };

      homeManager = {
        enable = lib.mkEnableOption "Enable homeManager method for Hyprland ecosystem packages" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for packages installation when using homeManager method:
            - none: Don't install packages
            - nixpkgs: Use packages from nixpkgs
            - flake: Use packages from flake
          '';
        };
      };
    };

    # 环境变量选项
    environment = {
      enable = lib.mkEnableOption "Enable Hyprland environment variables" // { default = true; };

      copyLink = {
        enable = lib.mkEnableOption "Enable copyLink method for Hyprland environment variables" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "none";
          description = ''
            Source for packages when using copyLink method:
            - none: Don't install packages (environment variables only)
            - nixpkgs: Use packages from nixpkgs
            - flake: Use packages from flake
          '';
        };
      };

      realTime = {
        enable = lib.mkEnableOption "Enable realTime method for Hyprland environment variables" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "none";
          description = ''
            Source for packages when using realTime method:
            - none: Don't install packages (environment variables only)
            - nixpkgs: Use packages from nixpkgs
            - flake: Use packages from flake
          '';
        };
      };

      homeManager = {
        enable = lib.mkEnableOption "Enable homeManager method for Hyprland environment variables" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "none";
          description = ''
            Source for packages when using homeManager method:
            - none: Don't install packages (environment variables only)
            - nixpkgs: Use packages from nixpkgs
            - flake: Use packages from flake
          '';
        };
      };
    };

    hypr = {
      enable = lib.mkEnableOption "Enable Hyprland core configuration" // { default = true; };

      copyLink = {
        enable = lib.mkEnableOption "Enable copyLink method for Hyprland core configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "flake";
          description = ''
            Source for Hyprland package installation when using copyLink method:
            - none: Don't install Hyprland package (use system-level installation)
            - nixpkgs: Use stable Hyprland package from nixpkgs
            - flake: Use newer Hyprland package from official upstream flake
          '';
        };
      };

      realTime = {
        enable = lib.mkEnableOption "Enable realTime method for Hyprland core configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "flake";
          description = ''
            Source for Hyprland package installation when using realTime method:
            - none: Don't install Hyprland package (use system-level installation)
            - nixpkgs: Use stable Hyprland package from nixpkgs
            - flake: Use newer Hyprland package from official upstream flake
          '';
        };
      };

      homeManager = {
        enable = lib.mkEnableOption "Enable homeManager method for Hyprland core configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "flake";
          description = ''
            Source for Hyprland package installation when using homeManager method:
            - none: Don't install Hyprland package (use system-level installation)
            - nixpkgs: Use stable Hyprland package from nixpkgs
            - flake: Use newer Hyprland package from official upstream flake
          '';
        };
      };
    };

    waybar = {
      enable = lib.mkEnableOption "Enable Waybar configuration" // { default = true; };

      copyLink = {
        enable = lib.mkEnableOption "Enable copyLink method for Waybar configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for Waybar package installation when using copyLink method:
            - none: Don't install Waybar package
            - nixpkgs: Use Waybar package from nixpkgs
            - flake: Use Waybar package from flake
          '';
        };
      };

      realTime = {
        enable = lib.mkEnableOption "Enable realTime method for Waybar configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for Waybar package installation when using realTime method:
            - none: Don't install Waybar package
            - nixpkgs: Use Waybar package from nixpkgs
            - flake: Use Waybar package from flake
          '';
        };
      };

      homeManager = {
        enable = lib.mkEnableOption "Enable homeManager method for Waybar configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for Waybar package installation when using homeManager method:
            - none: Don't install Waybar package
            - nixpkgs: Use Waybar package from nixpkgs
            - flake: Use Waybar package from flake
          '';
        };
      };
    };

    dunst = {
      enable = lib.mkEnableOption "Enable Dunst notification daemon configuration" // { default = true; };

      copyLink = {
        enable = lib.mkEnableOption "Enable copyLink method for Dunst configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for Dunst package installation when using copyLink method:
            - none: Don't install Dunst package
            - nixpkgs: Use Dunst package from nixpkgs
            - flake: Use Dunst package from flake
          '';
        };
      };

      realTime = {
        enable = lib.mkEnableOption "Enable realTime method for Dunst configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for Dunst package installation when using realTime method:
            - none: Don't install Dunst package
            - nixpkgs: Use Dunst package from nixpkgs
            - flake: Use Dunst package from flake
          '';
        };
      };

      homeManager = {
        enable = lib.mkEnableOption "Enable homeManager method for Dunst configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for Dunst package installation when using homeManager method:
            - none: Don't install Dunst package
            - nixpkgs: Use Dunst package from nixpkgs
            - flake: Use Dunst package from flake
          '';
        };
      };
    };

    rofi = {
      enable = lib.mkEnableOption "Enable Rofi application launcher configuration" // { default = true; };

      copyLink = {
        enable = lib.mkEnableOption "Enable copyLink method for Rofi configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for Rofi package installation when using copyLink method:
            - none: Don't install Rofi package
            - nixpkgs: Use Rofi package from nixpkgs
            - flake: Use Rofi package from flake
          '';
        };
      };

      realTime = {
        enable = lib.mkEnableOption "Enable realTime method for Rofi configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for Rofi package installation when using realTime method:
            - none: Don't install Rofi package
            - nixpkgs: Use Rofi package from nixpkgs
            - flake: Use Rofi package from flake
          '';
        };
      };

      homeManager = {
        enable = lib.mkEnableOption "Enable homeManager method for Rofi configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for Rofi package installation when using homeManager method:
            - none: Don't install Rofi package
            - nixpkgs: Use Rofi package from nixpkgs
            - flake: Use Rofi package from flake
          '';
        };
      };
    };

    swappy = {
      enable = lib.mkEnableOption "Enable Swappy screenshot annotation tool configuration" // { default = true; };

      copyLink = {
        enable = lib.mkEnableOption "Enable copyLink method for Swappy configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for Swappy package installation when using copyLink method:
            - none: Don't install Swappy package
            - nixpkgs: Use Swappy package from nixpkgs
            - flake: Use Swappy package from flake
          '';
        };
      };

      realTime = {
        enable = lib.mkEnableOption "Enable realTime method for Swappy configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for Swappy package installation when using realTime method:
            - none: Don't install Swappy package
            - nixpkgs: Use Swappy package from nixpkgs
            - flake: Use Swappy package from flake
          '';
        };
      };

      homeManager = {
        enable = lib.mkEnableOption "Enable homeManager method for Swappy configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for Swappy package installation when using homeManager method:
            - none: Don't install Swappy package
            - nixpkgs: Use Swappy package from nixpkgs
            - flake: Use Swappy package from flake
          '';
        };
      };
    };

    wlogout = {
      enable = lib.mkEnableOption "Enable Wlogout session manager configuration" // { default = true; };

      copyLink = {
        enable = lib.mkEnableOption "Enable copyLink method for Wlogout configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for Wlogout package installation when using copyLink method:
            - none: Don't install Wlogout package
            - nixpkgs: Use Wlogout package from nixpkgs
            - flake: Use Wlogout package from flake
          '';
        };
      };

      realTime = {
        enable = lib.mkEnableOption "Enable realTime method for Wlogout configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for Wlogout package installation when using realTime method:
            - none: Don't install Wlogout package
            - nixpkgs: Use Wlogout package from nixpkgs
            - flake: Use Wlogout package from flake
          '';
        };
      };

      homeManager = {
        enable = lib.mkEnableOption "Enable homeManager method for Wlogout configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for Wlogout package installation when using homeManager method:
            - none: Don't install Wlogout package
            - nixpkgs: Use Wlogout package from nixpkgs
            - flake: Use Wlogout package from flake
          '';
        };
      };
    };

    fuzzel = {
      enable = lib.mkEnableOption "Enable Fuzzel application launcher configuration" // { default = true; };

      copyLink = {
        enable = lib.mkEnableOption "Enable copyLink method for Fuzzel configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for Fuzzel package installation when using copyLink method:
            - none: Don't install Fuzzel package
            - nixpkgs: Use Fuzzel package from nixpkgs
            - flake: Use Fuzzel package from flake
          '';
        };
      };

      realTime = {
        enable = lib.mkEnableOption "Enable realTime method for Fuzzel configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for Fuzzel package installation when using realTime method:
            - none: Don't install Fuzzel package
            - nixpkgs: Use Fuzzel package from nixpkgs
            - flake: Use Fuzzel package from flake
          '';
        };
      };

      homeManager = {
        enable = lib.mkEnableOption "Enable homeManager method for Fuzzel configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for Fuzzel package installation when using homeManager method:
            - none: Don't install Fuzzel package
            - nixpkgs: Use Fuzzel package from nixpkgs
            - flake: Use Fuzzel package from flake
          '';
        };
      };
    };

    ironbar = {
      enable = lib.mkEnableOption "Enable IronBar status bar configuration" // { default = true; };

      copyLink = {
        enable = lib.mkEnableOption "Enable copyLink method for IronBar configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for IronBar package installation when using copyLink method:
            - none: Don't install IronBar package
            - nixpkgs: Use IronBar package from nixpkgs
            - flake: Use IronBar package from flake
          '';
        };
      };

      realTime = {
        enable = lib.mkEnableOption "Enable realTime method for IronBar configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for IronBar package installation when using realTime method:
            - none: Don't install IronBar package
            - nixpkgs: Use IronBar package from nixpkgs
            - flake: Use IronBar package from flake
          '';
        };
      };

      homeManager = {
        enable = lib.mkEnableOption "Enable homeManager method for IronBar configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for IronBar package installation when using homeManager method:
            - none: Don't install IronBar package
            - nixpkgs: Use IronBar package from nixpkgs
            - flake: Use IronBar package from flake
          '';
        };
      };
    };
  };
}
