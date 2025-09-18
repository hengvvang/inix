{ lib, ... }:

{
  options.myHome.desktop.niri = {

    packages = {
      realTime = {
        enable = lib.mkEnableOption "Enable Niri ecosystem packages via realTime method";
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = "Source for packages installation";
        };
      };
      homeManager = {
        enable = lib.mkEnableOption "Enable Niri ecosystem packages via homeManager method" // { default = true; };
      };
      copyLink = {
        enable = lib.mkEnableOption "Enable Niri ecosystem packages via copyLink method";
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = "Source for packages installation";
        };
      };
    };

    # 环境变量选项
    environment = {
      realTime = {
        enable = lib.mkEnableOption "Enable Niri environment variables via realTime method";
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = "Source for packages installation";
        };
      };
      homeManager = {
        enable = lib.mkEnableOption "Enable Niri environment variables via homeManager method" // { default = true; };
      };
      copyLink = {
        enable = lib.mkEnableOption "Enable Niri environment variables via copyLink method";
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = "Source for packages installation";
        };
      };
    };

    niri = {
      realTime = {
        enable = lib.mkEnableOption "Enable Niri core configuration via realTime method";
        configPath = lib.mkOption {
          type = lib.types.str;
          default = ".config/niri";
          description = "Path to Niri configuration directory";
        };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for Niri package installation:
            - none: Don't install Niri package (use system-level installation)
            - nixpkgs: Use stable Niri package from nixpkgs
            - flake: Use newer Niri package from official upstream flake
          '';
        };
      };
      homeManager = {
        enable = lib.mkEnableOption "Enable Niri core configuration via homeManager method" // { default = true; };
      };
      copyLink = {
        enable = lib.mkEnableOption "Enable Niri core configuration via copyLink method";
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for Niri package installation:
            - none: Don't install Niri package (use system-level installation)
            - nixpkgs: Use stable Niri package from nixpkgs
            - flake: Use newer Niri package from official upstream flake
          '';
        };
      };
    };

    waybar = {
      realTime = {
        enable = lib.mkEnableOption "Enable Waybar configuration via realTime method";
        configPath = lib.mkOption {
          type = lib.types.str;
          default = ".config/waybar";
          description = "Path to Waybar configuration directory";
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
      homeManager = {
        enable = lib.mkEnableOption "Enable Waybar configuration via homeManager method" // { default = true; };
      };
      copyLink = {
        enable = lib.mkEnableOption "Enable Waybar configuration via copyLink method";
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
    };

    ironbar = {
      realTime = {
        enable = lib.mkEnableOption "Enable Ironbar configuration via realTime method";
        configPath = lib.mkOption {
          type = lib.types.str;
          default = ".config/ironbar";
          description = "Path to Ironbar configuration directory";
        };
      };
      homeManager = {
        enable = lib.mkEnableOption "Enable Ironbar configuration via homeManager method" // { default = true; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for Ironbar package installation:
            - none: Don't install Ironbar package
            - nixpkgs: Use Ironbar package from nixpkgs
            - flake: Use Ironbar package from flake
          '';
        };
      };
      copyLink = {
        enable = lib.mkEnableOption "Enable Ironbar configuration via copyLink method";
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for Ironbar package installation:
            - none: Don't install Ironbar package
            - nixpkgs: Use Ironbar package from nixpkgs
            - flake: Use Ironbar package from flake
          '';
        };
      };
    };

    rofi = {
      realTime = {
        enable = lib.mkEnableOption "Enable Rofi configuration via realTime method";
        configPath = lib.mkOption {
          type = lib.types.str;
          default = ".config/rofi";
          description = "Path to Rofi configuration directory";
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
      homeManager = {
        enable = lib.mkEnableOption "Enable Rofi configuration via homeManager method" // { default = true; };
      };
      copyLink = {
        enable = lib.mkEnableOption "Enable Rofi configuration via copyLink method";
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
    };

    fuzzel = {
      realTime = {
        enable = lib.mkEnableOption "Enable Fuzzel configuration via realTime method";
        configPath = lib.mkOption {
          type = lib.types.str;
          default = ".config/fuzzel";
          description = "Path to Fuzzel configuration directory";
        };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "none";
          description = ''
            Source for Fuzzel package installation:
            - none: Don't install Fuzzel package (use system-level installation)
            - nixpkgs: Use Fuzzel package from nixpkgs
            - flake: Use Fuzzel package from flake
          '';
        };
      };
      homeManager = {
        enable = lib.mkEnableOption "Enable Fuzzel configuration via homeManager method" // { default = true; };
      };
      copyLink = {
        enable = lib.mkEnableOption "Enable Fuzzel configuration via copyLink method";
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "none";
          description = ''
            Source for Fuzzel package installation:
            - none: Don't install Fuzzel package (use system-level installation)
            - nixpkgs: Use Fuzzel package from nixpkgs
            - flake: Use Fuzzel package from flake
          '';
        };
      };
    };

    swaylock = {
      realTime = {
        enable = lib.mkEnableOption "Enable Swaylock configuration via realTime method";
        configPath = lib.mkOption {
          type = lib.types.str;
          default = ".config/swaylock";
          description = "Path to Swaylock configuration directory";
        };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for Swaylock package installation:
            - none: Don't install Swaylock package
            - nixpkgs: Use Swaylock package from nixpkgs
            - flake: Use Swaylock package from flake
          '';
        };
      };
      homeManager = {
        enable = lib.mkEnableOption "Enable Swaylock configuration via homeManager method" // { default = true; };
      };
      copyLink = {
        enable = lib.mkEnableOption "Enable Swaylock configuration via copyLink method";
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for Swaylock package installation:
            - none: Don't install Swaylock package
            - nixpkgs: Use Swaylock package from nixpkgs
            - flake: Use Swaylock package from flake
          '';
        };
      };
    };

    swayidle = {
      realTime = {
        enable = lib.mkEnableOption "Enable Swayidle configuration via realTime method";
        configPath = lib.mkOption {
          type = lib.types.str;
          default = ".config/swayidle";
          description = "Path to Swayidle configuration directory";
        };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for Swayidle package installation:
            - none: Don't install Swayidle package
            - nixpkgs: Use Swayidle package from nixpkgs
            - flake: Use Swayidle package from flake
          '';
        };
      };
      homeManager = {
        enable = lib.mkEnableOption "Enable Swayidle configuration via homeManager method" // { default = true; };
      };
      copyLink = {
        enable = lib.mkEnableOption "Enable Swayidle configuration via copyLink method";
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for Swayidle package installation:
            - none: Don't install Swayidle package
            - nixpkgs: Use Swayidle package from nixpkgs
            - flake: Use Swayidle package from flake
          '';
        };
      };
    };

    wlogout = {
      realTime = {
        enable = lib.mkEnableOption "Enable Wlogout configuration via realTime method";
        configPath = lib.mkOption {
          type = lib.types.str;
          default = ".config/wlogout";
          description = "Path to Wlogout configuration directory";
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
      homeManager = {
        enable = lib.mkEnableOption "Enable Wlogout configuration via homeManager method" // { default = true; };
      };
      copyLink = {
        enable = lib.mkEnableOption "Enable Wlogout configuration via copyLink method";
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
    };

    dunst = {
      realTime = {
        enable = lib.mkEnableOption "Enable Dunst configuration via realTime method";
        configPath = lib.mkOption {
          type = lib.types.str;
          default = ".config/dunst";
          description = "Path to Dunst configuration directory";
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
      homeManager = {
        enable = lib.mkEnableOption "Enable Dunst configuration via homeManager method" // { default = true; };
      };
      copyLink = {
        enable = lib.mkEnableOption "Enable Dunst configuration via copyLink method";
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
    };

    mako = {
      realTime = {
        enable = lib.mkEnableOption "Enable Mako configuration via realTime method";
        configPath = lib.mkOption {
          type = lib.types.str;
          default = ".config/mako";
          description = "Path to Mako configuration directory";
        };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for Mako package installation:
            - none: Don't install Mako package
            - nixpkgs: Use Mako package from nixpkgs
            - flake: Use Mako package from flake
          '';
        };
      };
      homeManager = {
        enable = lib.mkEnableOption "Enable Mako configuration via homeManager method" // { default = true; };
      };
      copyLink = {
        enable = lib.mkEnableOption "Enable Mako configuration via copyLink method";
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for Mako package installation:
            - none: Don't install Mako package
            - nixpkgs: Use Mako package from nixpkgs
            - flake: Use Mako package from flake
          '';
        };
      };
    };

    appearance = {
      realTime = {
        enable = lib.mkEnableOption "Enable Niri appearance configuration via realTime method";
      };
      homeManager = {
        enable = lib.mkEnableOption "Enable Niri appearance configuration via homeManager method" // { default = true; };
      };
      copyLink = {
        enable = lib.mkEnableOption "Enable Niri appearance configuration via copyLink method";
      };
    };
  };
}
