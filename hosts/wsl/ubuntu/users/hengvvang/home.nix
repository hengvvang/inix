{ config, pkgs, lib, inputs, outputs, ... }:

{
  myHome = {
    desktop = {
      enable = false;  # WSL Ubuntu 通常不需要桌面环境
      preset = "none";
    };

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
      # 按语言直接配置
      rust = {
        enable = true;
        embedded.enable = false;  # WSL 中嵌入式开发较少
      };
      python.enable = true;
      javascript.enable = true;
      typescript.enable = true;
      cpp = {
        enable = true;
        embedded.enable = false;
      };
    };

    services = {
      media = {
        # MPD 用户级音乐服务配置
        mpd = {
          enable = false;  # WSL 中通常不需要音乐服务
          musicDirectory = "${config.home.homeDirectory}/Music";
          port = 6600;
          autoStart = false;
          clients = {
            mpc = false;
            rmpc = false;
          };
        };
      };
      proxy = {
        # WSL 中可能需要代理配置
        v2ray = {
          enable = false;
          configFile = "/home/hengvvang/.config/v2ray/config.json";
        };
        mihomo = {
          enable = false;
          configFile = "/home/hengvvang/.config/mihomo/config.yaml";
          webui.enable = false;
        };
      };
    };

    profiles = {
      enable = true;
      fonts = {
        enable = false;  # WSL 中字体由主机系统管理
      };
      stylix = {
        enable = false;  # WSL 中不需要系统主题
      };
    };
  };
}
