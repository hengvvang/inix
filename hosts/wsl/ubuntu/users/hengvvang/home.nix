{ config, pkgs, lib, inputs, outputs, ... }:

{
  myHome = {
    dotfiles = {
      enable = true;
      zsh = {
        homeManager = {
          enable = true;
        };
      };
      fish = {
        homeManager = {
          enable = true;
        };
      };
      git = {
        homeManager = {
          enable = true;
        };
      };
      starship = {
        homeManager = {
          enable = true;
        };
      };
      yazi = {
        homeManager = {
          enable = true;
        };
      };
      zellij = {
        homeManager = {
          enable = true;
        };
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
