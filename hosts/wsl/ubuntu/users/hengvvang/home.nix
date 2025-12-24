{ config, pkgs, lib, inputs, outputs, ... }:

{
  myHome = {
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
      git = {
        enable = true;
        configStyle = "homeManager";
      };
      starship = {
        enable = true;
        configStyle = "homeManager";
      };
      yazi = {
        enable = true;
        configStyle = "homeManager";
      };
      zellij = {
        enable = true;
        configStyle = "homeManager";
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
