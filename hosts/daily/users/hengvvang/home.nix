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
          enable = true;
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
        xonsh = {
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
