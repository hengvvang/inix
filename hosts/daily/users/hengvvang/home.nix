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
          enable = true;
          style = "nixStyle";
        };
        zsh = {
          enable = true;
          style = "nixStyle";
        };
        bash = {
          enable = true;
          style = "nixStyle";
        };
        fish = {
          enable = true;
          style = "nixStyle";
        };
        nushell = {
          enable = true;
          style = "nixStyle";
        };
        tmux = {
          enable = true;
          style = "nixStyle";
        };
        git = {
          enable = true;
          style = "nixStyle";
        };
        lazygit = {
          enable = true;
          style = "nixStyle";
        };
        starship = {
          enable = true;
          style = "nixStyle";
        };
        qutebrowser = {
          enable = false;
          style = "nixStyle";
        };
        alacritty = {
          enable = true;
          style = "copyStyle";
        };
        obs-studio = {
          enable = true;
          style = "nixStyle";
        };
        sherlock = {
          enable = true;
          style = "copyStyle";
        };
        yazi = {
          enable = true;
          style = "nixStyle";
        };
        zellij = {
          enable = true;
          style = "nixStyle";
        };
        ripgrep = {
          enable = true;
          style = "nixStyle";
        };
        fd = {
          enable = true;
          style = "nixStyle";
        };
        tealdeer = {
          enable = true;
          style = "nixStyle";
        };
        lsd = {
          enable = true;
          style = "nixStyle";
        };
        xonsh = {
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
