{ lib, ... }:

{
  options.myHome.dotfiles = {
    enable = lib.mkEnableOption "Enable dotfiles management" // { default = false; };

    bash = {
      enable = lib.mkEnableOption "Enable bash configuration" // { default = false; };
      configStyle = lib.mkOption {
        type = lib.types.enum [ "homeManager" "copyFiles" ];
        default = "homeManager";
        description = "Configuration style: homeManager (Home Manager) or copyFiles (copy files)";
      };
    };

    zsh = {
      enable = lib.mkEnableOption "Enable zsh configuration" // { default = false; };
      configStyle = lib.mkOption {
        type = lib.types.enum [ "homeManager" "copyFiles" ];
        default = "homeManager";
        description = "Configuration style: homeManager (Home Manager) or copyFiles (copy files)";
      };
    };

    vim = {
      enable = lib.mkEnableOption "Enable vim configuration" // { default = false; };
      configStyle = lib.mkOption {
        type = lib.types.enum [ "homeManager" "copyFiles" ];
        default = "homeManager";
        description = "Configuration style: homeManager (Home Manager) or copyFiles (copy files)";
      };
    };

    fish = {
      enable = lib.mkEnableOption "Enable fish configuration" // { default = false; };
      configStyle = lib.mkOption {
        type = lib.types.enum [ "homeManager" "copyFiles" ];
        default = "homeManager";
        description = "Configuration style: homeManager (Home Manager) or copyFiles (copy files)";
      };
    };

    nushell = {
      enable = lib.mkEnableOption "Enable nushell configuration" // { default = false; };
      configStyle = lib.mkOption {
        type = lib.types.enum [ "homeManager" "copyFiles" ];
        default = "homeManager";
        description = "Configuration style: homeManager (Home Manager) or copyFiles (copy files)";
      };
    };

    starship = {
      enable = lib.mkEnableOption "Enable starship configuration" // { default = false; };
      configStyle = lib.mkOption {
        type = lib.types.enum [ "homeManager" "copyFiles" ];
        default = "homeManager";
        description = "Configuration style: homeManager (Home Manager) or copyFiles (copy files)";
      };
    };

    alacritty = {
      enable = lib.mkEnableOption "Enable alacritty configuration" // { default = false; };
      configStyle = lib.mkOption {
        type = lib.types.enum [ "homeManager" "copyFiles" ];
        default = "homeManager";
        description = "Configuration style: homeManager (Home Manager) or copyFiles (copy files)";
      };
    };

    ghostty = {
      enable = lib.mkEnableOption "Enable ghostty configuration" // { default = false; };
      configStyle = lib.mkOption {
        type = lib.types.enum [ "homeManager" "copyFiles" ];
        default = "homeManager";
        description = "Configuration style: homeManager (Home Manager) or copyFiles (copy files)";
      };
    };

    rio = {
      enable = lib.mkEnableOption "Enable rio configuration" // { default = false; };
      configStyle = lib.mkOption {
        type = lib.types.enum [ "homeManager" "copyFiles" ];
        default = "homeManager";
        description = "Configuration style: homeManager (Home Manager) or copyFiles (copy files)";
      };
    };

    git = {
      enable = lib.mkEnableOption "Enable git configuration" // { default = false; };
      configStyle = lib.mkOption {
        type = lib.types.enum [ "homeManager" "copyFiles" ];
        default = "homeManager";
        description = "Configuration style: homeManager (Home Manager) or copyFiles (copy files)";
      };
    };

    lazygit = {
      enable = lib.mkEnableOption "Enable lazygit configuration" // { default = false; };
      configStyle = lib.mkOption {
        type = lib.types.enum [ "homeManager" "copyFiles" ];
        default = "homeManager";
        description = "Configuration style: homeManager (Home Manager) or copyFiles (copy files)";
      };
    };

    tmux = {
      enable = lib.mkEnableOption "Enable tmux configuration" // { default = false; };
      configStyle = lib.mkOption {
        type = lib.types.enum [ "homeManager" "copyFiles" ];
        default = "homeManager";
        description = "Configuration style: homeManager (Home Manager) or copyFiles (copy files)";
      };
    };

    zellij = {
      enable = lib.mkEnableOption "Enable zellij configuration" // { default = false; };
      configStyle = lib.mkOption {
        type = lib.types.enum [ "homeManager" "copyFiles" ];
        default = "homeManager";
        description = "Configuration style: homeManager (Home Manager) or copyFiles (copy files)";
      };
    };

    rofi = {
      enable = lib.mkEnableOption "Enable rofi configuration" // { default = false; };
      configStyle = lib.mkOption {
        type = lib.types.enum [ "homeManager" "copyFiles" ];
        default = "homeManager";
        description = "Configuration style: homeManager (Home Manager) or copyFiles (copy files)";
      };
    };

    sherlock = {
      enable = lib.mkEnableOption "Enable sherlock configuration" // { default = false; };
      configStyle = lib.mkOption {
        type = lib.types.enum [ "homeManager" "copyFiles" ];
        default = "homeManager";
        description = "Configuration style: homeManager (Home Manager) or copyFiles (copy files)";
      };
    };

    rmpc = {
      enable = lib.mkEnableOption "Enable rmpc configuration" // { default = false; };
      configStyle = lib.mkOption {
        type = lib.types.enum [ "homeManager" "copyFiles" ];
        default = "homeManager";
        description = "Configuration style: homeManager (Home Manager) or copyFiles (copy files)";
      };
    };

    yazi = {
      enable = lib.mkEnableOption "Enable yazi configuration" // { default = false; };
      configStyle = lib.mkOption {
        type = lib.types.enum [ "homeManager" "copyFiles" ];
        default = "homeManager";
        description = "Configuration style: homeManager (Home Manager) or copyFiles (copy files)";
      };
    };

    qutebrowser = {
      enable = lib.mkEnableOption "Enable qutebrowser configuration" // { default = false; };
      configStyle = lib.mkOption {
        type = lib.types.enum [ "homeManager" "copyFiles" ];
        default = "homeManager";
        description = "Configuration style: homeManager (Home Manager) or copyFiles (copy files)";
      };
    };

    obs-studio = {
      enable = lib.mkEnableOption "Enable obs-studio configuration" // { default = false; };
      configStyle = lib.mkOption {
        type = lib.types.enum [ "homeManager" "copyFiles" ];
        default = "homeManager";
        description = "Configuration style: homeManager (Home Manager) or copyFiles (copy files)";
      };
    };

    vscode = {
      enable = lib.mkEnableOption "Enable vscode configuration" // { default = false; };
      configStyle = lib.mkOption {
        type = lib.types.enum [ "homeManager" "copyFiles" ];
        default = "homeManager";
        description = "Configuration style: homeManager (Home Manager) or copyFiles (copy files)";
      };
    };

    zed = {
      enable = lib.mkEnableOption "Enable zed configuration" // { default = false; };
      configStyle = lib.mkOption {
        type = lib.types.enum [ "homeManager" "copyFiles" ];
        default = "homeManager";
        description = "Configuration style: homeManager (Home Manager) or copyFiles (copy files)";
      };
    };

    vicinae = {
      enable = lib.mkEnableOption "Enable vicinae configuration" // { default = false; };
      configStyle = lib.mkOption {
        type = lib.types.enum [ "homeManager" "copyFiles" ];
        default = "homeManager";
        description = "Configuration style: homeManager (Home Manager) or copyFiles (copy files)";
      };
    };
  };
}
