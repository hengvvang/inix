{ config, lib, ... }:

{
  # laptop 主机特定配置 - zlritsu 轻量级配置
  config = lib.mkIf (config.host == "laptop") {
    myHome = {
      develop = {
        # 基础开发配置，不启用重型工具
        devenv = {
          enable = false;       # zlritsu 不使用 devenv
          autoSwitch = false;
          shell = "fish";
          templates = false;
          cache = false;
        };
        # 基础语言支持
        rust.enable = false;    # zlritsu 不开发 Rust
        python.enable = true;   # 基础 Python 支持
        javascript.enable = false;
        typescript.enable = false;
        cpp.enable = false;
      };
      
      dotfiles = {
        vim.enable = true;
        zsh.enable = false;     # zlritsu 只用 fish
        bash.enable = true;     # 保留基础 bash
        fish.enable = true;
        nushell.enable = false; # 轻量级配置
        yazi.enable = true;     # 文件管理器
        ghostty.enable = false; # 使用系统默认终端
        alacritty.enable = false;
        tmux.enable = false;    # 不使用 tmux
        git.enable = true;      # 基础 git
        lazygit.enable = false; # 不使用图形化 git
        starship.enable = true; # 保留美观的提示符
        qutebrowser.enable = true;  # 启用 Qutebrowser 配置
        proxy.enable = false;
      };
      
      # 包管理配置
      pkgs = {
        enable = true;                # 启用用户包管理
        # 工具包配置 - 从系统配置迁移，zlritsu 使用轻量级配置
        toolkits = {
          enable = true;              # 启用工具包模块
          files.enable = true;        # 启用文件管理工具
          text.enable = true;         # 启用文本处理工具
          network.enable = false;     # zlritsu 轻量级配置 - 禁用网络工具
          monitor.enable = false;     # zlritsu 轻量级配置 - 禁用监控工具
          develop.enable = false;     # zlritsu 轻量级配置 - 禁用开发工具
        };

        apps = {
          enable = true;              # 启用应用程序模块
          shells.enable = true;       # 启用 shell 程序
          terminals.enable = true;    # 启用终端应用
          develop.enable = false;     # zlritsu 轻量级配置 - 禁用开发工具
          browsers.enable = true;     # 启用浏览器
          communication.enable = false;  # zlritsu 轻量级配置 - 禁用通讯软件
          media.enable = true;        # 启用媒体应用
          office.enable = false;      # zlritsu 轻量级配置 - 禁用办公软件
          gaming.enable = false;      # zlritsu 轻量级配置 - 禁用游戏
          network.enable = false;     # zlritsu 轻量级配置 - 禁用网络工具
        };
      };
      
      profiles = {
        fonts = {
          preset = "zen";   # 简洁专注的字体配置
        };
        stylix = {
          enable = true;
          polarity = "dark";
          wallpapers = {
            enable = true;
            preset = "forest";  # zlritsu 使用不同的预设壁纸
          };
          fonts = {
            enable = true;
            # 轻量级字体配置
            sizes = {
              applications = 10;  # 更小的字体
              terminal = 11;
            };
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
