{ config, pkgs, lib, inputs, outputs, ... }:

{
  myHome = {
    dotfiles = {
      enable = true;
      zsh = {
        enable = true;
        style = "nixStyle";
      };
      fish = {
        enable = true;
        style = "nixStyle";
      };
      starship = {
        enable = true;
        style = "nixStyle";
      };
      yazi = {
        enable = true;
        style = "nixStyle";
      };
      zellij = {
        enable = true;
        style = "nixStyle";
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
