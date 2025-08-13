{ config, lib, hosts, ... }:

{
  # host1 主机特定配置
  config = lib.mkIf (config.host == hosts.host1) {
    myHome = {

      desktop = {
        enable = true;
        preset = "niri";
      };

      pkgs = {
        enable = true;
        apps.enable = true;
        toolkits.enable = true;
        workflows.enable = true;
      };

      dotfiles = {
        enable = true;

        vim.enable = true;
        zsh.enable = true;
        bash.enable = true;
        fish.enable = true;
        nushell.enable = true;
        alacritty.enable = true;
        tmux.enable = true;
        git.enable = true;
        lazygit.enable = true;
        starship.enable = true;
        qutebrowser.enable = false;
        obs-studio.enable = false;
        sherlock = {
            enable = true;
            method = "external";
        };
        zed = {
          enable = false;
          method = "external";
        };
        vscode = {
          enable = false;
          method = "external";
        };
        rofi = {
          enable = false;
          method = "external";
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
          enable = true;
          autoSwitch = true;    # 启用自动环境切换（direnv）
          shell = "fish";
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

          # 用户级覆盖配置（可选）
          polarity = "dark";

          # 指定特定颜色方案（覆盖系统配置）
          colorScheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

          # 用户特定的字体大小调整
          fontSize = {
            terminal = 16;
            applications = 12;
            desktop = 12;
            popups = 12;
          };

          # 目标应用配置 - 基于您实际使用的应用
          targets = {
            terminals = {
              alacritty.enable = true;  # 您启用了 alacritty
              kitty.enable = false;
            };

            editors = {
              vim.enable = true;        # 您启用了 vim
              neovim.enable = false;
            };

            tools = {
              tmux.enable = true;       # 您启用了 tmux
              bat.enable = true;
              fzf.enable = true;
              zellij.enable = true;     # 您启用了 zellij
            };

            desktop = {
              gtk.enable = true;
              qt.enable = true;
            };

            browsers = {
              firefox.enable = false;   # 您禁用了 qutebrowser
              qutebrowser.enable = false;
            };

            others = {
              rofi.enable = false;      # 您禁用了 rofi
              mako.enable = false;
              dunst.enable = false;
              waybar.enable = false;
            };
          };
        };
      };
    };
  };
}
