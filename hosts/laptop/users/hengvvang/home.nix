{ config, pkgs, lib, inputs, outputs, ... }:

{
  myHome = {
    desktop = {
      enable = true;
      preset = "niri";
      niri = {
        packages = {
          enable = true;
          configStyle = "copyFiles";
        };
        environment = {
          enable = true;
          configStyle = "copyFiles";
        };
        niri = {
          enable = true;
          configStyle = "copyFiles";
        };
        waybar = {
          enable = true;
          configStyle = "copyFiles";
        };
        rofi = {
          enable = true;
          configStyle = "copyFiles";
        };
        vicinae = {
          enable = true;
          configStyle = "copyFiles";
        };
        fuzzel = {
          enable = true;
          configStyle = "copyFiles";
        };
        swaylock = {
          enable = true;
          configStyle = "copyFiles";
        };
        swayidle = {
          enable = true;
          configStyle = "copyFiles";
        };
        wlogout = {
          enable = true;
          configStyle = "copyFiles";
        };
        dunst = {
          enable = true;
          configStyle = "copyFiles";
        };
      };
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
      ghostty = {
        enable = true;
        configStyle = "homeManager";
      };
      yazi = {
        enable = true;
        configStyle = "copyFiles";
      };
      zellij = {
        enable = true;
        configStyle = "copyFiles";
      };
      rio = {
        enable = true;
        configStyle = "homeManager";
      };
      rmpc = {
        enable = true;
        configStyle = "copyFiles";
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

    services = {
      media = {
        # MPD 用户级音乐服务配置
        mpd = {
          enable = true;                        # 启用用户级 MPD 服务
          musicDirectory = "${config.home.homeDirectory}/Music";  # 音乐目录
          port = 6600;                          # MPD 端口
          autoStart = true;                     # 开机自动启动
          clients = {
            mpc = true;                         # 安装 mpc 命令行客户端
            rmpc = true;
          };
        };
      };
    };

    profiles = {
      enable = true;
      fonts = {
        enable = true;
        preset = "zen";
      };
      stylix = {
        enable = false;  # 启用用户级 stylix
        # 跟随系统配置，确保一致性
        colorScheme = {
          mode = "preset";
          preset = {
            name = "catppuccin-mocha";  # 与系统保持一致
          };
        };
        polarity = "dark";  # 强制深色模式
        cursor = {
          enable = true;
          name = "macOS";
          package = pkgs.apple-cursor;
          size = 24;
        };
        fonts = {
          enable = true;
          families = {
            sansSerif = {
              name = "LXGW WenKai";
              package = pkgs.lxgw-wenkai;
            };
            serif = {
              name = "LXGW WenKai";
              package = pkgs.lxgw-wenkai;
            };
            monospace = {
              name = "LXGW WenKai Mono";
              package = pkgs.lxgw-wenkai;
            };
            emoji = {
              name = "Noto Color Emoji";
              package = pkgs.noto-fonts-color-emoji;
            };
          };
        };
        # 启用更多应用主题
        targets = {
          vim.enable = true;
          gtk.enable = true;  # 启用 GTK 主题
          tmux.enable = true;
          btop.enable = true;
          alacritty.enable = true;  # 启用 Alacritty 主题
          yazi.enable = true;       # 启用 Yazi 主题
        };
      };
    };
  };
}
