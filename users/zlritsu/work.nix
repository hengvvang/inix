{ config, lib, ... }:

{
  # work 主机特定配置 - zlritsu 工作环境配置
  config = lib.mkIf (config.host == "work") {
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
        javascript.enable = true;
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
          preset = "nordic";
        };
        stylix = {
          enable = true;
          polarity = "dark";
          wallpapers = {
            enable = true;
            preset = "sea";
          };
          fonts = {
            enable = true;
            sizes = {
              applications = 10;
              terminal = 11;
            };
          };
          targets = {
            enable = true;
            terminals = {
              alacritty.enable = false;
              kitty.enable = false;
            };
            editors = {
              vim.enable = true;
              neovim.enable = false;
            };
            tools = {
              tmux.enable = false;
              bat.enable = false;
              fzf.enable = false;
            };
            desktop = {
              gtk.enable = true;
            };
            browsers = {
              firefox.enable = true;
            };
          };
        };
      };
    };
  };
}
