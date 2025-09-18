{ config, pkgs, lib, inputs, outputs, ... }:

{
    myHome = {
      desktop = {
        enable = true;
        preset = "gnome";
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
            enable = true;
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
        xonsh = {
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
        fonts.enable = true;
        stylix = {
          enable = true;
          wallpaper = "${inputs.wallpapers}/wallpapers/ghibli/ghibli-kiki-6.jpg";
          colorScheme = "gruvbox-dark-hard";
          polarity = "dark";
        };
      };

      services = {
        media = {
          mpd = {
            enable = true;
            musicDirectory = "/home/hengvvang/Music";
          };
        };
        proxy = {
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
