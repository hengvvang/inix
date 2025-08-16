{ config, lib, hosts, ... }:

{
  # host2 主机特定配置 - user2 工作环境配置
  config = lib.mkIf (config.host == hosts.host2) {
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
      };
    };
  };
}
