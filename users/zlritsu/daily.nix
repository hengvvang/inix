{ config, lib, ... }:

{
  # daily 主机特定配置 - zlritsu 日常使用配置
  config = lib.mkIf (config.host == "daily") {
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
        stylix = {
          enable = false;
          polarity = "dark";
          wallpapers = {
            enable = true;
            preset = "sea";
          };
          fonts = {
            enable = true;
            # 使用默认字体配置，也可以自定义
          };
          targets = {
            enable = true;
            terminals = {
              alacritty.enable = false;  # 避免与现有 alacritty 配置冲突
              kitty.enable = true;
            };
            editors = {
              vim.enable = true;
              neovim.enable = true;
            };
            tools = {
              tmux.enable = true;
              bat.enable = true;
              fzf.enable = true;
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
