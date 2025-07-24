{ config, lib, ... }:

{
  # laptop 主机特定配置 - zlritsu 轻量级配置
  config = lib.mkIf (config.host == "laptop") {
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
        qutebrowser.enable = true;
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
          preset = "zen";   # 简洁专注的字体配置
        };
        stylix = {
          enable = true;
          polarity = "dark";
          wallpapers = {
            enable = true;
            preset = "sea";  # zlritsu 使用不同的预设壁纸
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
