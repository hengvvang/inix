{ lib, ... }:

{
  options.myHome.desktop.niri = {

    packages = {
      copyLink = {
        enable = lib.mkEnableOption "Enable Niri ecosystem packages via copyLink method";
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = "Source for packages installation";
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable Niri ecosystem packages via realTime method";
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = "Source for packages installation";
        };
      };
      homeManager = {
        enable = lib.mkEnableOption "Enable Niri ecosystem packages via homeManager method";
      };
    };

    # 环境变量选项
    environment = {
      copyLink = {
        enable = lib.mkEnableOption "Enable Niri environment variables via copyLink method";
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = "Source for packages installation";
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable Niri environment variables via realTime method";
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = "Source for packages installation";
        };
      };
      homeManager = {
        enable = lib.mkEnableOption "Enable Niri environment variables via homeManager method";
      };
    };

    niri = {
      copyLink = {
        enable = lib.mkEnableOption "Enable Niri core configuration via copyLink method";
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
          '';
        };
      };
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
          '';
        };
      };
      homeManager = {
        enable = lib.mkEnableOption "Enable Niri core configuration via homeManager method";
      };
    };

    waybar = {
      copyLink = {
        enable = lib.mkEnableOption "Enable Waybar configuration via copyLink method";
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
          '';
        };
      };
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
          '';
        };
      };
      homeManager = {
        enable = lib.mkEnableOption "Enable Waybar configuration via homeManager method";
      };
    };

    ironbar = {
      copyLink = {
        enable = lib.mkEnableOption "Enable Ironbar configuration via copyLink method";
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable Ironbar configuration via realTime method";
        configPath = lib.mkOption {
          type = lib.types.str;
          default = ".config/ironbar";
          description = "Path to Ironbar configuration directory";
        };
      };
      homeManager = {
        enable = lib.mkEnableOption "Enable Ironbar configuration via homeManager method";
      };
    };

    rofi = {
      copyLink = {
        enable = lib.mkEnableOption "Enable Rofi configuration via copyLink method";
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
          '';
        };
      };
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
          '';
        };
      };
      homeManager = {
        enable = lib.mkEnableOption "Enable Rofi configuration via homeManager method";
      };
    };

    vicinae = {
      copyLink = {
        enable = lib.mkEnableOption "Enable Vicinae configuration via copyLink method";
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Package source for Vicinae launcher.
            - none: Do not install package
            - nixpkgs: Use stable version from nixpkgs
            - flake: Use latest version from official flake
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable Vicinae configuration via realTime method";
        configPath = lib.mkOption {
          type = lib.types.str;
          default = ".config/vicinae";
          description = "Path to Vicinae configuration directory";
        };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Package source for Vicinae launcher.
            - none: Do not install package
            - nixpkgs: Use stable version from nixpkgs
            - flake: Use latest version from official flake
          '';
        };
      };
      homeManager = {
        enable = lib.mkEnableOption "Enable Vicinae configuration via homeManager method";
      };
    };

    fuzzel = {
      copyLink = {
        enable = lib.mkEnableOption "Enable Fuzzel configuration via copyLink method";
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "none";
          description = ''
          '';
        };
      };
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
          '';
        };
      };
      homeManager = {
        enable = lib.mkEnableOption "Enable Fuzzel configuration via homeManager method";
      };
    };

    swaylock = {
      copyLink = {
        enable = lib.mkEnableOption "Enable Swaylock configuration via copyLink method";
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
          '';
        };
      };
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
          '';
        };
      };
      homeManager = {
        enable = lib.mkEnableOption "Enable Swaylock configuration via homeManager method";
      };
    };

    swayidle = {
      copyLink = {
        enable = lib.mkEnableOption "Enable Swayidle configuration via copyLink method";
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
          '';
        };
      };
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
          '';
        };
      };
      homeManager = {
        enable = lib.mkEnableOption "Enable Swayidle configuration via homeManager method";
      };
    };

    wlogout = {
      copyLink = {
        enable = lib.mkEnableOption "Enable Wlogout configuration via copyLink method";
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable Wlogout configuration via realTime method";
        configPath = lib.mkOption {
          type = lib.types.str;
          default = ".config/wlogout";
          description = "";
        };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
          '';
        };
      };
      homeManager = {
        enable = lib.mkEnableOption "Enable Wlogout configuration via homeManager method";
      };
    };

    dunst = {
      copyLink = {
        enable = lib.mkEnableOption "Enable Dunst configuration via copyLink method";
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable Dunst configuration via realTime method";
        configPath = lib.mkOption {
          type = lib.types.str;
          default = ".config/dunst";
          description = "";
        };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
          '';
        };
      };
      homeManager = {
        enable = lib.mkEnableOption "Enable Dunst configuration via homeManager method";
      };
    };

    mako = {
      copyLink = {
        enable = lib.mkEnableOption "Enable Mako configuration via copyLink method";
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable Mako configuration via realTime method";
        configPath = lib.mkOption {
          type = lib.types.str;
          default = ".config/mako";
          description = "";
        };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
          '';
        };
      };
      homeManager = {
        enable = lib.mkEnableOption "Enable Mako configuration via homeManager method";
      };
    };

    appearance = {
      copyLink = {
        enable = lib.mkEnableOption "Enable Niri appearance configuration via copyLink method";
      };
      realTime = {
        enable = lib.mkEnableOption "Enable Niri appearance configuration via realTime method";
      };
      homeManager = {
        enable = lib.mkEnableOption "Enable Niri appearance configuration via homeManager method";
      };
    };
  };
}
