{ config, lib, ... }:

{
  # daily 主机特定配置 - zlritsu 日常使用配置
  config = lib.mkIf (config.host == "daily") {
    myHome = {
      develop = {
        enable = true;
        devenv = {
          enable = false;
          autoSwitch = false;
          shell = "fish";
          templates = false;
          cache = false;
        };
        rust.enable = false;
        python.enable = true;
        javascript.enable = false;
        typescript.enable = false;
        cpp.enable = false;
      };
      
      dotfiles = {
        enable = true;

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
      };
      

      pkgs = {
        enable = true;

        toolkits = {
          enable = true;              # 启用工具包模块
          waxingCrescent.enable = true;  # 🌒 峨眉月 - 基础家庭工具
          firstQuarter.enable = false;   # 🌓 上弦月 - 开发和终端工具 (轻量级禁用)
          waxingGibbous.enable = false;  # 🌔 盈凸月 - 高级工具套件 (轻量级禁用)
          fullMoon.enable = false;       # 🌕 满月 - 完整工具生态 (轻量级禁用)
        };
        # 应用程序配置 - 月相主题设计，zlritsu 使用轻量级配置
        apps = {
          enable = true;              # 启用应用程序模块
          waningCrescent.enable = true;  # 🌘 残月 - 基础应用核心
          lastQuarter.enable = false;    # 🌗 下弦月 - 开发和终端应用 (轻量级禁用)
          waningGibbous.enable = false;  # 🌖 亏凸月 - 桌面生产力套件 (轻量级禁用)
          newMoon.enable = false;        # 🌑 新月 - 完整应用生态 (轻量级禁用)
        };
      };

      profiles = {
        enable = true;

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
