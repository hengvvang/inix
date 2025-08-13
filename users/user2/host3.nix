{ config, lib, hosts, ... }:

{
  # host3 主机特定配置 - user2 日常使用配置
  config = lib.mkIf (config.host == hosts.host3) {
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
          enable = true;  # 在 macOS 上也启用主题
          targets = {
            # macOS 上的应用主题配置
            terminals.kitty.enable = true;    # 使用 Kitty
            editors = {
              vim.enable = true;               # 使用 vim 和 neovim
              neovim.enable = true;
            };
            tools = {
              tmux.enable = true;              # 使用开发工具
              bat.enable = true;
              fzf.enable = true;
            };
            browsers.firefox.enable = true;   # Firefox 主题
          };
        };
        };
      };
    };
  };
}
