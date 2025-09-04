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
        enable = true;
        method = "copyLink";
      };
      obs-studio = {
        enable = true;
        method = "homeManager";
      };
      sherlock = {
          enable = true;
          method = "copyLink";
      };
      zed = {
        enable = false;
        method = "copyLink";
      };
      vscode = {
        enable = false;
        method = "copyLink";
      };
      rofi = {
        enable = false;
        method = "copyLink";
      };
      ghostty = {
        enable = true;
        method = "homeManager";
      };
      yazi = {
        enable = true;
        method = "copyLink";
      };
      zellij = {
        enable = true;
        method = "copyLink";
      };
      rio = {
        enable = true;
        method = "homeManager";
      };
      rmpc = {
        enable = true;
        method = "copyLink";
      };
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
