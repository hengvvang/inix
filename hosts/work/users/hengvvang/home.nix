{ config, pkgs, lib, inputs, outputs, ... }:

{
  myHome = {
    desktop = {
      enable = true;
      preset = "kde";  # 工作环境使用KDE
    };

    dotfiles = {
      enable = true;
      vim = {
        enable = true;
        configStyle = "homeManager";
      };
      zsh = {
        enable = true;
        configStyle = "homeManager";
      };
      bash = {
        enable = true;
        configStyle = "homeManager";
      };
      fish = {
        enable = true;
        configStyle = "homeManager";
      };
      nushell = {
        enable = true;
        configStyle = "homeManager";
      };
      tmux = {
        enable = true;
        configStyle = "homeManager";
      };
      git = {
        enable = true;
        configStyle = "homeManager";
      };
      lazygit = {
        enable = true;
        configStyle = "homeManager";
      };
      starship = {
        enable = true;
        configStyle = "homeManager";
      };
      qutebrowser = {
        enable = false;
        configStyle = "homeManager";
      };
      alacritty = {
        enable = true;
        configStyle = "copyFiles";
      };
      obs-studio = {
        enable = false;  # 工作环境不需要
        configStyle = "homeManager";
      };
      sherlock = {
        enable = true;
        configStyle = "copyFiles";
      };
      yazi = {
        enable = true;
        configStyle = "homeManager";
      };
      zellij = {
        enable = true;
        configStyle = "homeManager";
      };
      ripgrep = {
        enable = true;
        configStyle = "homeManager";
      };
      fd = {
        enable = true;
        configStyle = "homeManager";
      };
      tealdeer = {
        enable = true;
        configStyle = "homeManager";
      };
      lsd = {
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

    profiles = {
      enable = true;
      fonts = {
        enable = true;
        preset = "tokyo";  # 专业字体配置
      };
      stylix = {
        enable = true;
        wallpaper = "${inputs.wallpapers}/wallpapers/minimal/minimal-dark.jpg";  # 专业简洁壁纸
        colorScheme = "tokyo-night";
        polarity = "dark";
      };
    };

    services = {
      proxy = {
        # 工作环境可能需要代理配置
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
  };
}
