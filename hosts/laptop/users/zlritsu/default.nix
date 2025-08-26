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
      pkgs = {
        enable = true;
        user2.enable = true;
      };

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
        qutebrowser.enable = true;
      };


      profiles = {
        enable = true;
        fonts = {
          preset = "zen";   # 简洁专注的字体配置
        };
        # 添加统一主题配置
        stylix = {
          enable = false;  # 启用用户级 stylix
          # 跟随系统配置
          colorScheme = {
            mode = "preset";
            preset = {
              name = "catppuccin-mocha";  # 与系统保持一致
            };
          };
          polarity = "dark";  # 强制深色模式
          # 启用基础应用主题
          targets = {
            gtk.enable = true;
            vim.enable = true;
            yazi.enable = true;
          };
        };
      };
    };
  };
}
