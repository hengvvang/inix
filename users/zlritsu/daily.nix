{ config, lib, ... }:

{
  # daily 主机特定配置 - zlritsu 日常使用配置
  config = lib.mkIf (config.host == "daily") {
    myHome = {
      develop = {
        # 日常使用，基础开发配置
        devenv = {
          enable = false;       # zlritsu 不使用 devenv
          autoSwitch = false;
          shell = "fish";
          templates = false;
          cache = false;
        };
        # 基础语言支持
        rust.enable = false;
        python.enable = true;   # 日常可能需要 Python 脚本
        javascript.enable = false;
        typescript.enable = false;
        cpp.enable = false;
      };
      
      dotfiles = {
        vim.enable = true;
        zsh.enable = false;
        bash.enable = true;
        fish.enable = true;
        nushell.enable = false;
        yazi.enable = true;
        ghostty.enable = false;
        alacritty.enable = false;
        tmux.enable = false;
        git.enable = true;
        lazygit.enable = false;
        starship.enable = true;
        proxy.enable = true;    # 日常使用可能需要代理
      };
      

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
        # 应用程序配置 - 从系统配置迁移，zlritsu 使用轻量级配置
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
          preset = "ocean";   # 日常使用舒适字体
        };
        stylix = {
          enable = false;
          polarity = "dark";
          wallpapers = {
            enable = true;
            preset = "sea";
          };
          fonts = {
            enable = true;
            # 使用默认字体配置，也可以自定义
          };
          targets = {
            enable = true;
            terminals = {
              alacritty.enable = false;  # 避免与现有 alacritty 配置冲突
              kitty.enable = true;
            };
            editors = {
              vim.enable = true;
              neovim.enable = true;
            };
            tools = {
              tmux.enable = true;
              bat.enable = true;
              fzf.enable = true;
            };
            desktop = {
              gtk.enable = true;
            };
            browsers = {
              firefox.enable = true;
            };
          };
        };
      };
    };
  };
}
