{ config, pkgs, lib, inputs, outputs, ... }:

{
  myHome = {
    desktop = {
      enable = true;
      preset = "niri";
      niri = {
        packages = {
          enable = true;
          style = "copyStyle";
        };
        environment = {
          enable = true;
          style = "copyStyle";
        };
        niri = {
          enable = true;
          style = "copyStyle";
        };
        waybar = {
          enable = true;
          style = "copyStyle";
        };
        rofi = {
          enable = true;
          style = "copyStyle";
        };
        vicinae = {
          enable = true;
          style = "copyStyle";
        };
        fuzzel = {
          enable = true;
          style = "copyStyle";
        };
        swaylock = {
          enable = true;
          style = "copyStyle";
        };
        swayidle = {
          enable = true;
          style = "copyStyle";
        };
        wlogout = {
          enable = true;
          style = "copyStyle";
        };
        dunst = {
          enable = true;
          style = "copyStyle";
        };
      };
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
      ghostty = {
        enable = true;
        style = "nixStyle";
      };
      yazi = {
        enable = true;
        style = "copyStyle";
      };
      zellij = {
        enable = true;
        style = "copyStyle";
      };
      rio = {
        enable = true;
        style = "nixStyle";
      };
      rmpc = {
        enable = true;
        style = "copyStyle";
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
