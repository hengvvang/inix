{ config, pkgs, lib, inputs, outputs, ... }:

{
  myHome = {
    desktop = {
      enable = true;
      preset = "gnome";
    };

    dotfiles = {
      enable = true;
      zsh = {
        enable = true;
        configStyle = "homeManager";
      };
      fish = {
        enable = true;
        configStyle = "homeManager";
      };
      starship = {
        enable = true;
        configStyle = "homeManager";
      };
      ghostty = {
        enable = true;
        configStyle = "homeManager";
      };
      yazi = {
        enable = true;
        configStyle = "copyFiles";
      };
      zellij = {
        enable = true;
        configStyle = "copyFiles";
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

    profiles = {
      enable = true;
      fonts = {
        enable = true;
        preset = "zen";
      };
    };
  };
}
