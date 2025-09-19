{ config, pkgs, lib, inputs, outputs, ... }:

{
  myHome = {
    desktop = {
      enable = true;
      preset = "gnome";
    };

    dotfiles = {
      enable = false;
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
      starship = {
        homeManager = {
          enable = true;
        };
      };
      ghostty = {
        homeManager = {
          enable = true;
        };
      };
      yazi = {
        copyLink = {
          enable = true;
          packageSource = "nixpkgs";
        };
      };
      zellij = {
        copyLink = {
          enable = true;
          packageSource = "nixpkgs";
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

    profiles = {
      enable = true;
      fonts = {
        enable = true;
        preset = "zen";
      };
    };
  };
}
