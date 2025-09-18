{ config, pkgs, lib, inputs, outputs, ... }:

{
  myHome = {
    dotfiles = {
      enable = true;
      vim = {
        homeManager = {
          enable = true;
        };
      };
      zsh = {
        homeManager = {
          enable = true;
        };
      };
      bash = {
        homeManager = {
          enable = true;
        };
      };
      fish = {
        homeManager = {
          enable = true;
        };
      };
      nushell = {
        homeManager = {
          enable = true;
        };
      };
      tmux = {
        homeManager = {
          enable = true;
        };
      };
      git = {
        homeManager = {
          enable = true;
        };
      };
      lazygit = {
        homeManager = {
          enable = true;
        };
      };
      starship = {
        homeManager = {
          enable = true;
        };
      };
      qutebrowser = {
        homeManager = {
          enable = false;
        };
      };
      alacritty = {
        copyLink = {
          enable = false;  # WSL 中通常不需要
        };
      };
      obs-studio = {
        homeManager = {
          enable = false;
        };
      };
      sherlock = {
        copyLink = {
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
      ripgrep = {
        homeManager = {
          enable = true;
        };
      };
      fd = {
        homeManager = {
          enable = true;
        };
      };
      tealdeer = {
        homeManager = {
          enable = true;
        };
      };
      lsd = {
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
