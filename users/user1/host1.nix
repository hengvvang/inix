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
      };
    };
  };
}
