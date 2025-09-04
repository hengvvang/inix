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
          enable = true;
          method = "copyLink";
        };
        obs-studio = {
          enable = true;
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
        xonsh = {
          enable = true;
          method = "homeManager";
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
