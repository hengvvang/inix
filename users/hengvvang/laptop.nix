{ config, lib, ... }:

{
  # laptop 主机特定配置
  config = lib.mkIf (config.host == "laptop") {
    myHome = {

      pkgs = {
        enable = true;
        apps.enable = true;
        toolkits.enable = true;
        workflows.enable = true;
      };

      dotfiles = {
        enable = true;  # 启用 dotfiles 模块

        vim.enable = true;
        zsh.enable = true;
        bash.enable = true;
        fish.enable = true;
        nushell.enable = true;
        alacritty.enable = false;
        tmux.enable = true;
        git.enable = true;
        lazygit.enable = true;
        starship.enable = true;
        qutebrowser.enable = false;
        obs-studio.enable = false;
        zed.enable = false;
        vscode.enable = false;
        rofi = {
          enable = false;
          method = "homemanager";
        };
        ghostty = {
          enable = true;
          method = "homemanager";
        };
        yazi = {
          enable = true;
          method = "external";
        };
        zellij = {
          enable = true;
          method = "external";
        };
        rio = {
          enable = true;
          method = "homemanager";
        };
        rmpc = {
          enable = true;
          method = "external";
        };
      };

      develop = {
        enable = true;
        devenv = {
          enable = true;        # 启用 devenv
          autoSwitch = true;    # 启用自动环境切换（direnv）
          shell = "fish";       # 使用 fish shell
          templates = true;     # 安装项目模板工具（完整功能）
          cache = true;         # 启用构建缓存优化
        };
        # 按语言直接配置
        rust = {
          enable = true;
          embedded.enable = true;
        };
        python.enable = true;
        javascript.enable = true;
        typescript.enable = true;
        cpp = {
          enable = true;
          embedded.enable = true;
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
          preset = "tokyo";
        };
        stylix = {
          enable = true;
          polarity = "dark";

          # 🎨 启用自定义颜色配置
          colors = {
            enable = true;
            scheme = "dark-elegant";
          };

          wallpapers = {
            enable = false;
            # preset = "tokyo";
            # custom = {
            #   url = "https://example.com/path/to/your/wallpaper.jpg";  # ✅ 自定义壁纸 URL
            #   position = "center";  # ✅ 壁纸位置（center, fill, stretch 等）
            # };
          };

          fonts = {
            enable = false;
            names = {
              monospace = "JetBrainsMono Nerd Font Mono";
              sansSerif = "Noto Sans";
              serif = "Noto Serif";
              emoji = "Noto Color Emoji";
            };
            sizes = {
              terminal = 16;
              applications = 12;
              desktop = 12;
              popups = 12;
            };
          };

          targets = {
            enable = true;

            terminals = {
              alacritty.enable = false;
              kitty.enable = false;
            };

            editors = {
              vim.enable = true;
              neovim.enable = false;
            };

            tools = {
              tmux.enable = true;
              bat.enable = true;
              fzf.enable = true;
            };

            desktop = {
              gtk.enable = true;              # ✅ 启用 GTK 主题（应用一致性）
            };

            browsers = {
              firefox.enable = false;
            };

            inputMethods = {
              fcitx5.enable = true;
            };
          };
        };
      };
    };
  };
}
