{ lib, ... }:

{
  options.myHome.dotfiles = {
    enable = lib.mkEnableOption "Enable dotfiles management" // { default = false; };

    bash = {
      copyLink = {
        enable = lib.mkEnableOption "Enable bash copy link configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for bash package installation:
            - none: Don't install bash package
            - nixpkgs: Use bash package from nixpkgs
            - flake: Use bash package from flake
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable bash real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "Path to the bash configuration directory for real-time method.";
        };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
          '';
        };
      };
      homeManager = {
        enable = lib.mkEnableOption "Enable bash Home Manager configuration" // { default = false; };
      };
    };

    zsh = {
      copyLink = {
        enable = lib.mkEnableOption "Enable zsh copy link configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable zsh real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
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
        enable = lib.mkEnableOption "Enable zsh Home Manager configuration" // { default = false; };
      };
    };

    vim = {
      copyLink = {
        enable = lib.mkEnableOption "Enable vim copy link configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable vim real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
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
        enable = lib.mkEnableOption "Enable vim Home Manager configuration" // { default = false; };
      };
    };

    fish = {
      copyLink = {
        enable = lib.mkEnableOption "Enable fish copy link configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable fish real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
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
        enable = lib.mkEnableOption "Enable fish Home Manager configuration" // { default = false; };
      };
    };

    nushell = {
      copyLink = {
        enable = lib.mkEnableOption "Enable nushell copy link configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable nushell real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
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
        enable = lib.mkEnableOption "Enable nushell Home Manager configuration" // { default = false; };
      };
    };

    starship = {
      copyLink = {
        enable = lib.mkEnableOption "Enable starship copy link configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable starship real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
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
        enable = lib.mkEnableOption "Enable starship Home Manager configuration" // { default = false; };
      };
    };

    alacritty = {
      copyLink = {
        enable = lib.mkEnableOption "Enable alacritty copy link configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable alacritty real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
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
        enable = lib.mkEnableOption "Enable alacritty Home Manager configuration" // { default = false; };
      };
    };

    ghostty = {
      copyLink = {
        enable = lib.mkEnableOption "Enable ghostty copy link configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable ghostty real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
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
        enable = lib.mkEnableOption "Enable ghostty Home Manager configuration" // { default = false; };
      };
    };

    rio = {
      copyLink = {
        enable = lib.mkEnableOption "Enable rio copy link configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable rio real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
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
        enable = lib.mkEnableOption "Enable rio Home Manager configuration" // { default = false; };
      };
    };

    git = {
      copyLink = {
        enable = lib.mkEnableOption "Enable git copy link configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable git real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
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
        enable = lib.mkEnableOption "Enable git Home Manager configuration" // { default = false; };
      };
    };

    lazygit = {
      copyLink = {
        enable = lib.mkEnableOption "Enable lazygit copy link configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable lazygit real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
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
        enable = lib.mkEnableOption "Enable lazygit Home Manager configuration" // { default = false; };
      };
    };

    tmux = {
      copyLink = {
        enable = lib.mkEnableOption "Enable tmux copy link configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable tmux real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
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
        enable = lib.mkEnableOption "Enable tmux Home Manager configuration" // { default = false; };
      };
    };

    zellij = {
      copyLink = {
        enable = lib.mkEnableOption "Enable zellij copy link configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable zellij real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
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
        enable = lib.mkEnableOption "Enable zellij Home Manager configuration" // { default = false; };
      };
    };

    rofi = {
      copyLink = {
        enable = lib.mkEnableOption "Enable rofi copy link configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable rofi real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
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
        enable = lib.mkEnableOption "Enable rofi Home Manager configuration" // { default = false; };
      };
    };

    sherlock = {
      copyLink = {
        enable = lib.mkEnableOption "Enable sherlock copy link configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable sherlock real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
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
        enable = lib.mkEnableOption "Enable sherlock Home Manager configuration" // { default = false; };
      };
    };

    rmpc = {
      copyLink = {
        enable = lib.mkEnableOption "Enable rmpc copy link configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable rmpc real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
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
        enable = lib.mkEnableOption "Enable rmpc Home Manager configuration" // { default = false; };
      };
    };

    yazi = {
      copyLink = {
        enable = lib.mkEnableOption "Enable yazi copy link configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable yazi real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
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
        enable = lib.mkEnableOption "Enable yazi Home Manager configuration" // { default = false; };
      };
    };

    qutebrowser = {
      copyLink = {
        enable = lib.mkEnableOption "Enable qutebrowser copy link configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable qutebrowser real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
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
        enable = lib.mkEnableOption "Enable qutebrowser Home Manager configuration" // { default = false; };
      };
    };

    obs-studio = {
      copyLink = {
        enable = lib.mkEnableOption "Enable obs-studio copy link configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable obs-studio real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
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
        enable = lib.mkEnableOption "Enable obs-studio Home Manager configuration" // { default = false; };
      };
    };

    vscode = {
      copyLink = {
        enable = lib.mkEnableOption "Enable vscode copy link configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable vscode real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
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
        enable = lib.mkEnableOption "Enable vscode Home Manager configuration" // { default = false; };
      };
    };

    zed = {
      copyLink = {
        enable = lib.mkEnableOption "Enable zed copy link configuration" // { default = false; };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable zed real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
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
        enable = lib.mkEnableOption "Enable zed Home Manager configuration" // { default = false; };
      };
    };
  };
}
