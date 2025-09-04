{ config, pkgs, lib, inputs, outputs, ... }:

{
  myHome = {
    dotfiles = {
      enable = true;
      vim = {
        enable = true;
        method = "homeManager";
      };
      zsh = {
        enable = true;
        method = "homeManager";
      };
      bash = {
        enable = true;
        method = "homeManager";
      };
      fish = {
        enable = true;
        method = "homeManager";
      };
      nushell = {
        enable = true;
        method = "homeManager";
      };
      tmux.enable = true;
      git.enable = true;
      lazygit.enable = true;
      starship = {
        enable = true;
        method = "homeManager";
      };
      qutebrowser.enable = false;
      alacritty = {
        enable = false;  # WSL 中通常不需要
        method = "copyLink";
      };
      obs-studio = {
        enable = false;
        method = "homeManager";
      };
      sherlock = {
          enable = true;
          method = "copyLink";
      };
      yazi = {
        enable = true;
        method = "homeManager";
      };
      zellij = {
        enable = true;
        method = "homeManager";
      };
      ripgrep.enable = true;
      fd.enable = true;
      tealdeer.enable = true;
      lsd.enable = true;
    };

    develop = {
      enable = true;
      devenv = {
        enable = true;
        autoSwitch = true;    # 启用自动环境切换（direnv）
        shell = "fish";
        templates = true;     # 安装项目模板工具（完整功能）
        cache = true;         # 启用构建缓存优化
      };
    };
  };
}
