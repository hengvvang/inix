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
            Source for bash package installation:
            - none: Don't install bash package
            - nixpkgs: Use bash package from nixpkgs
            - flake: Use bash package from flake
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
            Source for zsh package installation:
            - none: Don't install zsh package
            - nixpkgs: Use zsh package from nixpkgs
            - flake: Use zsh package from flake
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable zsh real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "Path to the zsh configuration directory for real-time method.";
        };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for zsh package installation:
            - none: Don't install zsh package
            - nixpkgs: Use zsh package from nixpkgs
            - flake: Use zsh package from flake
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
            Source for vim package installation:
            - none: Don't install vim package
            - nixpkgs: Use vim package from nixpkgs
            - flake: Use vim package from flake
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable vim real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "Path to the vim configuration directory for real-time method.";
        };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for vim package installation:
            - none: Don't install vim package
            - nixpkgs: Use vim package from nixpkgs
            - flake: Use vim package from flake
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
            Source for fish package installation:
            - none: Don't install fish package
            - nixpkgs: Use fish package from nixpkgs
            - flake: Use fish package from flake
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable fish real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "Path to the fish configuration directory for real-time method.";
        };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for fish package installation:
            - none: Don't install fish package
            - nixpkgs: Use fish package from nixpkgs
            - flake: Use fish package from flake
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
            Source for nushell package installation:
            - none: Don't install nushell package
            - nixpkgs: Use nushell package from nixpkgs
            - flake: Use nushell package from flake
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable nushell real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "Path to the nushell configuration directory for real-time method.";
        };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for nushell package installation:
            - none: Don't install nushell package
            - nixpkgs: Use nushell package from nixpkgs
            - flake: Use nushell package from flake
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
            Source for starship package installation:
            - none: Don't install starship package
            - nixpkgs: Use starship package from nixpkgs
            - flake: Use starship package from flake
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable starship real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "Path to the starship configuration directory for real-time method.";
        };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for starship package installation:
            - none: Don't install starship package
            - nixpkgs: Use starship package from nixpkgs
            - flake: Use starship package from flake
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
            Source for alacritty package installation:
            - none: Don't install alacritty package
            - nixpkgs: Use alacritty package from nixpkgs
            - flake: Use alacritty package from flake
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable alacritty real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "Path to the alacritty configuration directory for real-time method.";
        };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for alacritty package installation:
            - none: Don't install alacritty package
            - nixpkgs: Use alacritty package from nixpkgs
            - flake: Use alacritty package from flake
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
            Source for ghostty package installation:
            - none: Don't install ghostty package
            - nixpkgs: Use ghostty package from nixpkgs
            - flake: Use ghostty package from flake
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable ghostty real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "Path to the ghostty configuration directory for real-time method.";
        };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for ghostty package installation:
            - none: Don't install ghostty package
            - nixpkgs: Use ghostty package from nixpkgs
            - flake: Use ghostty package from flake
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
            Source for rio package installation:
            - none: Don't install rio package
            - nixpkgs: Use rio package from nixpkgs
            - flake: Use rio package from flake
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable rio real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "Path to the rio configuration directory for real-time method.";
        };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for rio package installation:
            - none: Don't install rio package
            - nixpkgs: Use rio package from nixpkgs
            - flake: Use rio package from flake
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
            Source for git package installation:
            - none: Don't install git package
            - nixpkgs: Use git package from nixpkgs
            - flake: Use git package from flake
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable git real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "Path to the git configuration directory for real-time method.";
        };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for git package installation:
            - none: Don't install git package
            - nixpkgs: Use git package from nixpkgs
            - flake: Use git package from flake
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
            Source for lazygit package installation:
            - none: Don't install lazygit package
            - nixpkgs: Use lazygit package from nixpkgs
            - flake: Use lazygit package from flake
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable lazygit real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "Path to the lazygit configuration directory for real-time method.";
        };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for lazygit package installation:
            - none: Don't install lazygit package
            - nixpkgs: Use lazygit package from nixpkgs
            - flake: Use lazygit package from flake
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
            Source for tmux package installation:
            - none: Don't install tmux package
            - nixpkgs: Use tmux package from nixpkgs
            - flake: Use tmux package from flake
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable tmux real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "Path to the tmux configuration directory for real-time method.";
        };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for tmux package installation:
            - none: Don't install tmux package
            - nixpkgs: Use tmux package from nixpkgs
            - flake: Use tmux package from flake
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
            Source for zellij package installation:
            - none: Don't install zellij package
            - nixpkgs: Use zellij package from nixpkgs
            - flake: Use zellij package from flake
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable zellij real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "Path to the zellij configuration directory for real-time method.";
        };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for zellij package installation:
            - none: Don't install zellij package
            - nixpkgs: Use zellij package from nixpkgs
            - flake: Use zellij package from flake
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
            Source for rofi package installation:
            - none: Don't install rofi package
            - nixpkgs: Use rofi package from nixpkgs
            - flake: Use rofi package from flake
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable rofi real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "Path to the rofi configuration directory for real-time method.";
        };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for rofi package installation:
            - none: Don't install rofi package
            - nixpkgs: Use rofi package from nixpkgs
            - flake: Use rofi package from flake
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
            Source for sherlock package installation:
            - none: Don't install sherlock package
            - nixpkgs: Use sherlock package from nixpkgs
            - flake: Use sherlock package from flake
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable sherlock real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "Path to the sherlock configuration directory for real-time method.";
        };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for sherlock package installation:
            - none: Don't install sherlock package
            - nixpkgs: Use sherlock package from nixpkgs
            - flake: Use sherlock package from flake
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
            Source for rmpc package installation:
            - none: Don't install rmpc package
            - nixpkgs: Use rmpc package from nixpkgs
            - flake: Use rmpc package from flake
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable rmpc real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "Path to the rmpc configuration directory for real-time method.";
        };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for rmpc package installation:
            - none: Don't install rmpc package
            - nixpkgs: Use rmpc package from nixpkgs
            - flake: Use rmpc package from flake
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
            Source for yazi package installation:
            - none: Don't install yazi package
            - nixpkgs: Use yazi package from nixpkgs
            - flake: Use yazi package from flake
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable yazi real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "Path to the yazi configuration directory for real-time method.";
        };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for yazi package installation:
            - none: Don't install yazi package
            - nixpkgs: Use yazi package from nixpkgs
            - flake: Use yazi package from flake
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
            Source for qutebrowser package installation:
            - none: Don't install qutebrowser package
            - nixpkgs: Use qutebrowser package from nixpkgs
            - flake: Use qutebrowser package from flake
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable qutebrowser real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "Path to the qutebrowser configuration directory for real-time method.";
        };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for qutebrowser package installation:
            - none: Don't install qutebrowser package
            - nixpkgs: Use qutebrowser package from nixpkgs
            - flake: Use qutebrowser package from flake
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
            Source for obs-studio package installation:
            - none: Don't install obs-studio package
            - nixpkgs: Use obs-studio package from nixpkgs
            - flake: Use obs-studio package from flake
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable obs-studio real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "Path to the obs-studio configuration directory for real-time method.";
        };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for obs-studio package installation:
            - none: Don't install obs-studio package
            - nixpkgs: Use obs-studio package from nixpkgs
            - flake: Use obs-studio package from flake
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
            Source for vscode package installation:
            - none: Don't install vscode package
            - nixpkgs: Use vscode package from nixpkgs
            - flake: Use vscode package from flake
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable vscode real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "Path to the vscode configuration directory for real-time method.";
        };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for vscode package installation:
            - none: Don't install vscode package
            - nixpkgs: Use vscode package from nixpkgs
            - flake: Use vscode package from flake
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
            Source for zed package installation:
            - none: Don't install zed package
            - nixpkgs: Use zed package from nixpkgs
            - flake: Use zed package from flake
          '';
        };
      };
      realTime = {
        enable = lib.mkEnableOption "Enable zed real-time configuration (symbolic link)" // { default = false; };
        configPath = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "Path to the zed configuration directory for real-time method.";
        };
        packageSource = lib.mkOption {
          type = lib.types.enum [ "none" "nixpkgs" "flake" ];
          default = "nixpkgs";
          description = ''
            Source for zed package installation:
            - none: Don't install zed package
            - nixpkgs: Use zed package from nixpkgs
            - flake: Use zed package from flake
          '';
        };
      };
      homeManager = {
        enable = lib.mkEnableOption "Enable zed Home Manager configuration" // { default = false; };
      };
    };
  };
}
