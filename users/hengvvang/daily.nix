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
        # 工具包配置 - 月相主题设计
        toolkits = {
          enable = true;              # 启用工具包模块
          waxingCrescent.enable = true;  # 🌒 峨眉月 - 基础家庭工具
          firstQuarter.enable = true;    # 🌓 上弦月 - 开发和终端工具
          waxingGibbous.enable = true;   # 🌔 盈凸月 - 高级工具套件
          fullMoon.enable = false;       # 🌕 满月 - 完整工具生态
        };
        # 应用程序配置 - 月相主题设计
        apps = {
          enable = true;              # 启用应用程序模块
          waningCrescent.enable = true;  # 🌘 残月 - 基础应用核心
          lastQuarter.enable = true;     # 🌗 下弦月 - 开发和终端应用
          waningGibbous.enable = true;   # 🌖 亏凸月 - 桌面生产力套件 (日常需要)
          newMoon.enable = false;        # 🌑 新月 - 完整应用生态
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
