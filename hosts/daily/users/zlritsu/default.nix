{ config, pkgs, lib, inputs, outputs, ... }:

{
  imports = [
    outputs.home
  ];

  config = {
    nixpkgs.config.allowUnfree = true;
    home.username = "zlritsu";
    home.homeDirectory = "/home/zlritsu";
    home.stateVersion = "25.05";
    programs.home-manager.enable = true;

    myHome = {
      develop = {
        enable = true;
        devenv = {
          enable = false;
          autoSwitch = false;
          shell = "fish";
          templates = false;
          cache = false;
        };
        rust.enable = false;
        python.enable = true;
        javascript.enable = false;
        typescript.enable = false;
        cpp.enable = false;
      };

      dotfiles = {
        enable = true;
        vim.enable = true;
        zsh.enable = false;
        bash.enable = true;
        fish.enable = true;
        nushell.enable = false;
        yazi.enable = true;
        ghostty.enable = false;
        alacritty.enable = false;
        tmux.enable = false;
        git.enable = true;
        lazygit.enable = false;
        starship.enable = true;
      };

      profiles = {
        enable = true;
        fonts = {
          preset = "ocean";   # 日常使用舒适字体
        };
      };
    };
  };
}
