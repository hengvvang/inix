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
          enable = true;
        };
      };
      obs-studio = {
        homeManager = {
          enable = true;
        };
      };
      sherlock = {
        copyLink = {
          enable = true;
        };
      };
      zed = {
        copyLink = {
          enable = false;
        };
      };
      vscode = {
        copyLink = {
          enable = false;
        };
      };
      rofi = {
        copyLink = {
          enable = false;
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
        };
      };
      zellij = {
        copyLink = {
          enable = true;
        };
      };
      rio = {
        homeManager = {
          enable = true;
        };
      };
      rmpc = {
        copyLink = {
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
