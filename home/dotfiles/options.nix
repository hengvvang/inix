{ lib, ... }:

{
  options.myHome.dotfiles = {
    enable = lib.mkEnableOption "Enable dotfiles management";

    bash = {
      enable = lib.mkEnableOption "Enable bash configuration";
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy bash configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install bash package";
      };
    };

    zsh = {
      enable = lib.mkEnableOption "Enable zsh configuration";
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy zsh configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install zsh package";
      };
    };

    vim = {
      enable = lib.mkEnableOption "Enable vim configuration";
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy vim configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install vim package";
      };
    };

    fish = {
      enable = lib.mkEnableOption "Enable fish configuration";
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy fish configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install fish package";
      };
    };

    nushell = {
      enable = lib.mkEnableOption "Enable nushell configuration";
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy nushell configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install nushell package";
      };
    };

    starship = {
      enable = lib.mkEnableOption "Enable starship configuration";
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy starship configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install starship package";
      };
    };

    alacritty = {
      enable = lib.mkEnableOption "Enable alacritty configuration";
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy alacritty configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install alacritty package";
      };
    };

    ghostty = {
      enable = lib.mkEnableOption "Enable ghostty configuration";
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy ghostty configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install ghostty package";
      };
    };

    rio = {
      enable = lib.mkEnableOption "Enable rio configuration";
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy rio configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install rio package";
      };
    };

    git = {
      enable = lib.mkEnableOption "Enable git configuration";
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy git configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install git package";
      };
    };

    lazygit = {
      enable = lib.mkEnableOption "Enable lazygit configuration";
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy lazygit configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install lazygit package";
      };
    };

    tmux = {
      enable = lib.mkEnableOption "Enable tmux configuration";
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy tmux configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install tmux package";
      };
    };

    zellij = {
      enable = lib.mkEnableOption "Enable zellij configuration";
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy zellij configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install zellij package";
      };
    };

    rofi = {
      enable = lib.mkEnableOption "Enable rofi configuration";
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy rofi configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install rofi package";
      };
    };

    sherlock = {
      enable = lib.mkEnableOption "Enable sherlock configuration";
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy sherlock configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install sherlock package";
      };
    };

    rmpc = {
      enable = lib.mkEnableOption "Enable rmpc configuration";
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy rmpc configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install rmpc package";
      };
    };

    yazi = {
      enable = lib.mkEnableOption "Enable yazi configuration";
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy yazi configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install yazi package";
      };
    };

    qutebrowser = {
      enable = lib.mkEnableOption "Enable qutebrowser configuration";
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy qutebrowser configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install qutebrowser package";
      };
    };

    obs-studio = {
      enable = lib.mkEnableOption "Enable obs-studio configuration";
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy obs-studio configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install obs-studio package";
      };
    };

    vscode = {
      enable = lib.mkEnableOption "Enable vscode configuration";
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy vscode configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install vscode package";
      };
    };

    zed = {
      enable = lib.mkEnableOption "Enable zed configuration";
      method = lib.mkOption {
        type = lib.types.enum [ "copyLink" "symlink" "homemanager" ];
        default = "copyLink";
        description = "Method to deploy zed configuration files: copyLink (file copyLink), symlink (symbolic link), or homemanager (Home Manager native)";
      };
      useNixPackage = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install zed-editor package";
      };
    };
  };
}
