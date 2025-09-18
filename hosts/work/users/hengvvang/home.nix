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
          enable = false;  # 工作环境不需要
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
