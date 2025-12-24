{ lib, ... }:

{
  options.myHome.dotfiles = {
    enable = lib.mkEnableOption "Enable dotfiles management" // { default = false; };

    bash = {
      enable = lib.mkEnableOption "Enable bash configuration" // { default = false; };
      style = lib.mkOption {
        type = lib.types.enum [ "nixStyle" "copyStyle" ];
        default = "nixStyle";
        description = "Configuration style: nixStyle (Home Manager) or copyStyle (copy files)";
      };
    };

    zsh = {
      enable = lib.mkEnableOption "Enable zsh configuration" // { default = false; };
      style = lib.mkOption {
        type = lib.types.enum [ "nixStyle" "copyStyle" ];
        default = "nixStyle";
        description = "Configuration style: nixStyle (Home Manager) or copyStyle (copy files)";
      };
    };

    vim = {
      enable = lib.mkEnableOption "Enable vim configuration" // { default = false; };
      style = lib.mkOption {
        type = lib.types.enum [ "nixStyle" "copyStyle" ];
        default = "nixStyle";
        description = "Configuration style: nixStyle (Home Manager) or copyStyle (copy files)";
      };
    };

    fish = {
      enable = lib.mkEnableOption "Enable fish configuration" // { default = false; };
      style = lib.mkOption {
        type = lib.types.enum [ "nixStyle" "copyStyle" ];
        default = "nixStyle";
        description = "Configuration style: nixStyle (Home Manager) or copyStyle (copy files)";
      };
    };

    nushell = {
      enable = lib.mkEnableOption "Enable nushell configuration" // { default = false; };
      style = lib.mkOption {
        type = lib.types.enum [ "nixStyle" "copyStyle" ];
        default = "nixStyle";
        description = "Configuration style: nixStyle (Home Manager) or copyStyle (copy files)";
      };
    };

    starship = {
      enable = lib.mkEnableOption "Enable starship configuration" // { default = false; };
      style = lib.mkOption {
        type = lib.types.enum [ "nixStyle" "copyStyle" ];
        default = "nixStyle";
        description = "Configuration style: nixStyle (Home Manager) or copyStyle (copy files)";
      };
    };

    alacritty = {
      enable = lib.mkEnableOption "Enable alacritty configuration" // { default = false; };
      style = lib.mkOption {
        type = lib.types.enum [ "nixStyle" "copyStyle" ];
        default = "nixStyle";
        description = "Configuration style: nixStyle (Home Manager) or copyStyle (copy files)";
      };
    };

    ghostty = {
      enable = lib.mkEnableOption "Enable ghostty configuration" // { default = false; };
      style = lib.mkOption {
        type = lib.types.enum [ "nixStyle" "copyStyle" ];
        default = "nixStyle";
        description = "Configuration style: nixStyle (Home Manager) or copyStyle (copy files)";
      };
    };

    rio = {
      enable = lib.mkEnableOption "Enable rio configuration" // { default = false; };
      style = lib.mkOption {
        type = lib.types.enum [ "nixStyle" "copyStyle" ];
        default = "nixStyle";
        description = "Configuration style: nixStyle (Home Manager) or copyStyle (copy files)";
      };
    };

    git = {
      enable = lib.mkEnableOption "Enable git configuration" // { default = false; };
      style = lib.mkOption {
        type = lib.types.enum [ "nixStyle" "copyStyle" ];
        default = "nixStyle";
        description = "Configuration style: nixStyle (Home Manager) or copyStyle (copy files)";
      };
    };

    lazygit = {
      enable = lib.mkEnableOption "Enable lazygit configuration" // { default = false; };
      style = lib.mkOption {
        type = lib.types.enum [ "nixStyle" "copyStyle" ];
        default = "nixStyle";
        description = "Configuration style: nixStyle (Home Manager) or copyStyle (copy files)";
      };
    };

    tmux = {
      enable = lib.mkEnableOption "Enable tmux configuration" // { default = false; };
      style = lib.mkOption {
        type = lib.types.enum [ "nixStyle" "copyStyle" ];
        default = "nixStyle";
        description = "Configuration style: nixStyle (Home Manager) or copyStyle (copy files)";
      };
    };

    zellij = {
      enable = lib.mkEnableOption "Enable zellij configuration" // { default = false; };
      style = lib.mkOption {
        type = lib.types.enum [ "nixStyle" "copyStyle" ];
        default = "nixStyle";
        description = "Configuration style: nixStyle (Home Manager) or copyStyle (copy files)";
      };
    };

    rofi = {
      enable = lib.mkEnableOption "Enable rofi configuration" // { default = false; };
      style = lib.mkOption {
        type = lib.types.enum [ "nixStyle" "copyStyle" ];
        default = "nixStyle";
        description = "Configuration style: nixStyle (Home Manager) or copyStyle (copy files)";
      };
    };

    sherlock = {
      enable = lib.mkEnableOption "Enable sherlock configuration" // { default = false; };
      style = lib.mkOption {
        type = lib.types.enum [ "nixStyle" "copyStyle" ];
        default = "nixStyle";
        description = "Configuration style: nixStyle (Home Manager) or copyStyle (copy files)";
      };
    };

    rmpc = {
      enable = lib.mkEnableOption "Enable rmpc configuration" // { default = false; };
      style = lib.mkOption {
        type = lib.types.enum [ "nixStyle" "copyStyle" ];
        default = "nixStyle";
        description = "Configuration style: nixStyle (Home Manager) or copyStyle (copy files)";
      };
    };

    yazi = {
      enable = lib.mkEnableOption "Enable yazi configuration" // { default = false; };
      style = lib.mkOption {
        type = lib.types.enum [ "nixStyle" "copyStyle" ];
        default = "nixStyle";
        description = "Configuration style: nixStyle (Home Manager) or copyStyle (copy files)";
      };
    };

    qutebrowser = {
      enable = lib.mkEnableOption "Enable qutebrowser configuration" // { default = false; };
      style = lib.mkOption {
        type = lib.types.enum [ "nixStyle" "copyStyle" ];
        default = "nixStyle";
        description = "Configuration style: nixStyle (Home Manager) or copyStyle (copy files)";
      };
    };

    obs-studio = {
      enable = lib.mkEnableOption "Enable obs-studio configuration" // { default = false; };
      style = lib.mkOption {
        type = lib.types.enum [ "nixStyle" "copyStyle" ];
        default = "nixStyle";
        description = "Configuration style: nixStyle (Home Manager) or copyStyle (copy files)";
      };
    };

    vscode = {
      enable = lib.mkEnableOption "Enable vscode configuration" // { default = false; };
      style = lib.mkOption {
        type = lib.types.enum [ "nixStyle" "copyStyle" ];
        default = "nixStyle";
        description = "Configuration style: nixStyle (Home Manager) or copyStyle (copy files)";
      };
    };

    zed = {
      enable = lib.mkEnableOption "Enable zed configuration" // { default = false; };
      style = lib.mkOption {
        type = lib.types.enum [ "nixStyle" "copyStyle" ];
        default = "nixStyle";
        description = "Configuration style: nixStyle (Home Manager) or copyStyle (copy files)";
      };
    };
  };
}
