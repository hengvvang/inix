{ config, lib, pkgs, ... }:

{
  imports = [
    ./apps
    ./toolkits
    ./development
    ./profiles
  ];

  myHome = {
    apps = {
      editors = {
        vim.enable = lib.mkDefault false;
        vscode.enable = lib.mkDefault false;
        micro.enable = lib.mkDefault false;
        zed.enable = lib.mkDefault false;
      };
      shells = {
        fish.enable = lib.mkDefault false;
        aliases.enable = lib.mkDefault false;
        prompts.starship.enable = lib.mkDefault false;
        zsh.enable = lib.mkDefault false;
        nushell.enable = lib.mkDefault false;
      };
      terminals = {
        ghostty.enable = lib.mkDefault false;
      };
      yazi.enable = lib.mkDefault false;
    };
    
    development = {
      versionControl = {
        git.enable = lib.mkDefault false;
        lazygit.enable = lib.mkDefault false;
      };
      languages = {
        rust.enable = lib.mkDefault false;
        python.enable = lib.mkDefault false;
        javascript.enable = lib.mkDefault false;
        typescript.enable = lib.mkDefault false;
        cpp.enable = lib.mkDefault false;
        c.enable = lib.mkDefault false;
      };
      embedded = {
        toolchain.enable = lib.mkDefault false;
      };
    };
    
    profiles = {
      fonts = {
        fonts.enable = lib.mkDefault false;
      };
      envVar = {
        environment.enable = lib.mkDefault false;
      };
    };
    toolkits = {
      system = {
        hardware.enable = lib.mkDefault false;
        monitor.enable = lib.mkDefault false;
        network.enable = lib.mkDefault false;
        utilities.enable = lib.mkDefault false;
      };
      user = {
        utilities.enable = lib.mkDefault false;
      };
    };
  };
}
