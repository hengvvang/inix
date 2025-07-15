{ config, lib, ... }:

{
  # daily 主机特定配置
  config = lib.mkIf (config.host == "daily") {
    myHome = {
      develop = {
        # devenv 项目环境管理配置 - daily 主机
        devenv = {
          enable = true;        # 启用 devenv
          autoSwitch = true;    # 启用自动环境切换（direnv）
          shell = "fish";       # 使用 fish shell
          templates = false;    # 轻量级配置，不安装额外模板工具
          cache = true;         # 启用构建缓存优化
        };
        rust.enable = true;
        python.enable = true;
        javascript.enable = true;
        typescript.enable = true;
        cpp.enable = true;
      };
      
      dotfiles = {
        vim.enable = true;
        zsh.enable = true;
        bash.enable = true;
        fish.enable = true;
        nushell.enable = true;
        yazi.enable = true;
        ghostty.enable = true;
        alacritty.enable = true;
        tmux.enable = true;
        git.enable = true;
        lazygit.enable = true;
        starship.enable = true;
        proxy.enable = true;
      };


      pkgs = {
        enable = true;                # 启用用户包管理
        # 工具包配置 - 从系统配置迁移
        toolkits = {
          enable = true;              # 启用工具包模块
          files.enable = true;        # 启用文件管理工具 (ranger, nnn, etc.)
          text.enable = true;         # 启用文本处理工具 (grep, sed, awk, etc.)
          network.enable = true;      # 启用网络工具包 (curl, wget, etc.)
          monitor.enable = true;      # 启用系统监控工具 (htop, btop, etc.)
          develop.enable = true;      # 启用开发工具包 (git, make, etc.)
        };
        # 应用程序配置 - 从系统配置迁移，启用所有应用
        apps = {
          enable = true;              # 启用应用程序模块
          shells.enable = true;       # 启用 shell 程序 (zsh, fish, etc.)
          terminals.enable = true;    # 启用终端应用 (alacritty, kitty, etc.)
          develop.enable = true;      # 启用开发工具 (编辑器, IDE, etc.)
          browsers.enable = true;     # 启用浏览器 (firefox, chromium, etc.)
          communication.enable = true; # 启用通讯软件 (telegram, discord, etc.)
          media.enable = true;        # 启用媒体应用 (mpv, vlc, spotify, etc.)
          office.enable = true;       # 启用办公软件 (libreoffice, etc.)
          gaming.enable = true;       # 启用游戏相关 (steam, lutris, etc.)
          network.enable = true;      # 启用网络工具 (wireshark, nmap, etc.)
        };
      };

      
      profiles = {
        fonts = {
          preset = "bauhaus";
        };
        stylix = {
          enable = true;
          polarity = "dark";
          wallpapers = {
            enable = true;
            #preset = "maori";
            custom = ./../../home/profiles/stylix/wallpapers/swirl-loop.jpeg;
          };
          fonts = {
            enable = true;
            # 使用默认字体配置，也可以自定义
          };
          targets = {
            enable = true;
            terminals = {
              alacritty.enable = false;
              kitty.enable = false;
            };
            editors = {
              vim.enable = false;
              neovim.enable = false;
            };
            tools = {
              tmux.enable = false;
              bat.enable = false;
              fzf.enable = false;
            };
            desktop = {
              gtk.enable = false;
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
