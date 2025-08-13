{ config, lib, hosts, ... }:

{
  # host1 主机特定配置 - user2 轻量级配置
  config = lib.mkIf (config.host == hosts.host1) {
    myHome = {

      pkgs = {
        enable = true;
        apps.enable = true;
        toolkits.enable = true;
        workflows.enable = true;
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
      };
    };
  };
}
