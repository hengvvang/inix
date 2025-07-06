{ config, lib, pkgs, ... }:

{
  imports = [
    ./toolkits
    ./development
    ./profiles
    ./dotfiles
  ];

  myHome = {

    dotfiles = {
      enable = lib.mkDefault false;
      vim.enable = lib.mkDefault false;
      zsh.enable = lib.mkDefault false;
      fish.enable = lib.mkDefault false;
      nushell.enable = lib.mkDefault false;
      yazi.enable = lib.mkDefault false;
      ghostty.enable = lib.mkDefault false;
      git.enable = lib.mkDefault false;
      lazygit.enable = lib.mkDefault false;
    };
    
    development = {
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
