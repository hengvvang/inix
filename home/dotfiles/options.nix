{ lib, ... }:

{
  options.myHome.dotfiles = {
    enable = lib.mkEnableOption "Enable dotfiles management" // { default = false; };

    bash = {
      enable = lib.mkEnableOption "Enable bash configuration" // { default = false; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "realTime" "homeManager" ];
        default = "copyLink";
        description = "Method to deploy bash configuration files: copyLink (file copyLink), realTime (symbolic link), or homeManager (Home Manager native)";
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

    zsh = {
      enable = lib.mkEnableOption "Enable zsh configuration" // { default = false; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "realTime" "homeManager" ];
        default = "copyLink";
        description = "Method to deploy zsh configuration files: copyLink (file copyLink), realTime (symbolic link), or homeManager (Home Manager native)";
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

    vim = {
      enable = lib.mkEnableOption "Enable vim configuration" // { default = false; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "realTime" "homeManager" ];
        default = "copyLink";
        description = "Method to deploy vim configuration files: copyLink (file copyLink), realTime (symbolic link), or homeManager (Home Manager native)";
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

    fish = {
      enable = lib.mkEnableOption "Enable fish configuration" // { default = false; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "realTime" "homeManager" ];
        default = "copyLink";
        description = "Method to deploy fish configuration files: copyLink (file copyLink), realTime (symbolic link), or homeManager (Home Manager native)";
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

    nushell = {
      enable = lib.mkEnableOption "Enable nushell configuration" // { default = false; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "realTime" "homeManager" ];
        default = "copyLink";
        description = "Method to deploy nushell configuration files: copyLink (file copyLink), realTime (symbolic link), or homeManager (Home Manager native)";
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

    starship = {
      enable = lib.mkEnableOption "Enable starship configuration" // { default = false; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "realTime" "homeManager" ];
        default = "copyLink";
        description = "Method to deploy starship configuration files: copyLink (file copyLink), realTime (symbolic link), or homeManager (Home Manager native)";
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

    alacritty = {
      enable = lib.mkEnableOption "Enable alacritty configuration" // { default = false; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "realTime" "homeManager" ];
        default = "copyLink";
        description = "Method to deploy alacritty configuration files: copyLink (file copyLink), realTime (symbolic link), or homeManager (Home Manager native)";
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

    ghostty = {
      enable = lib.mkEnableOption "Enable ghostty configuration" // { default = false; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "realTime" "homeManager" ];
        default = "copyLink";
        description = "Method to deploy ghostty configuration files: copyLink (file copyLink), realTime (symbolic link), or homeManager (Home Manager native)";
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

    rio = {
      enable = lib.mkEnableOption "Enable rio configuration" // { default = false; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "realTime" "homeManager" ];
        default = "copyLink";
        description = "Method to deploy rio configuration files: copyLink (file copyLink), realTime (symbolic link), or homeManager (Home Manager native)";
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

    git = {
      enable = lib.mkEnableOption "Enable git configuration" // { default = false; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "realTime" "homeManager" ];
        default = "copyLink";
        description = "Method to deploy git configuration files: copyLink (file copyLink), realTime (symbolic link), or homeManager (Home Manager native)";
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

    lazygit = {
      enable = lib.mkEnableOption "Enable lazygit configuration" // { default = false; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "realTime" "homeManager" ];
        default = "copyLink";
        description = "Method to deploy lazygit configuration files: copyLink (file copyLink), realTime (symbolic link), or homeManager (Home Manager native)";
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

    tmux = {
      enable = lib.mkEnableOption "Enable tmux configuration" // { default = false; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "realTime" "homeManager" ];
        default = "copyLink";
        description = "Method to deploy tmux configuration files: copyLink (file copyLink), realTime (symbolic link), or homeManager (Home Manager native)";
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

    zellij = {
      enable = lib.mkEnableOption "Enable zellij configuration" // { default = false; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "realTime" "homeManager" ];
        default = "copyLink";
        description = "Method to deploy zellij configuration files: copyLink (file copyLink), realTime (symbolic link), or homeManager (Home Manager native)";
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

    rofi = {
      enable = lib.mkEnableOption "Enable rofi configuration" // { default = false; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "realTime" "homeManager" ];
        default = "copyLink";
        description = "Method to deploy rofi configuration files: copyLink (file copyLink), realTime (symbolic link), or homeManager (Home Manager native)";
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

    sherlock = {
      enable = lib.mkEnableOption "Enable sherlock configuration" // { default = false; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "realTime" "homeManager" ];
        default = "copyLink";
        description = "Method to deploy sherlock configuration files: copyLink (file copyLink), realTime (symbolic link), or homeManager (Home Manager native)";
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

    rmpc = {
      enable = lib.mkEnableOption "Enable rmpc configuration" // { default = false; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "realTime" "homeManager" ];
        default = "copyLink";
        description = "Method to deploy rmpc configuration files: copyLink (file copyLink), realTime (symbolic link), or homeManager (Home Manager native)";
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

    yazi = {
      enable = lib.mkEnableOption "Enable yazi configuration" // { default = false; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "realTime" "homeManager" ];
        default = "copyLink";
        description = "Method to deploy yazi configuration files: copyLink (file copyLink), realTime (symbolic link), or homeManager (Home Manager native)";
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

    qutebrowser = {
      enable = lib.mkEnableOption "Enable qutebrowser configuration" // { default = false; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "realTime" "homeManager" ];
        default = "copyLink";
        description = "Method to deploy qutebrowser configuration files: copyLink (file copyLink), realTime (symbolic link), or homeManager (Home Manager native)";
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

    obs-studio = {
      enable = lib.mkEnableOption "Enable obs-studio configuration" // { default = false; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "realTime" "homeManager" ];
        default = "copyLink";
        description = "Method to deploy obs-studio configuration files: copyLink (file copyLink), realTime (symbolic link), or homeManager (Home Manager native)";
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

    vscode = {
      enable = lib.mkEnableOption "Enable vscode configuration" // { default = false; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "realTime" "homeManager" ];
        default = "copyLink";
        description = "Method to deploy vscode configuration files: copyLink (file copyLink), realTime (symbolic link), or homeManager (Home Manager native)";
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

    zed = {
      enable = lib.mkEnableOption "Enable zed configuration" // { default = false; };
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "realTime" "homeManager" ];
        default = "copyLink";
        description = "Method to deploy zed configuration files: copyLink (file copyLink), realTime (symbolic link), or homeManager (Home Manager native)";
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
  };
}
