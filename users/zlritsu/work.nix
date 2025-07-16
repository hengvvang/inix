{ config, lib, ... }:

{
  # work 主机特定配置 - zlritsu 工作环境配置
  config = lib.mkIf (config.host == "work") {
    myHome = {
      develop = {
        # 工作环境，可能需要更多开发工具
        devenv = {
          enable = false;       # zlritsu 不使用 devenv
          autoSwitch = false;
          shell = "fish";
          templates = false;
          cache = false;
        };
        # 工作可能需要的语言支持
        rust.enable = false;
        python.enable = true;   # 工作可能需要 Python
        javascript.enable = true; # 工作可能需要前端工具
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
        proxy.enable = true;    # 工作环境通常需要代理
      };
      
      pkgs = {
        enable = true;                # 启用用户包管理
        # 工具包配置 - 月相主题设计，zlritsu 使用轻量级配置
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
        fonts = {
          preset = "nordic";  # 专业工作字体
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
              kitty.enable = false;  # zlritsu 不使用高级终端
            };
            editors = {
              vim.enable = true;
              neovim.enable = false;  # zlritsu 只用基础 vim
            };
            tools = {
              tmux.enable = false;  # zlritsu 不使用 tmux
              bat.enable = false;   # 轻量级配置
              fzf.enable = false;   # 轻量级配置
            };
            desktop = {
              gtk.enable = true;    # 基础 GTK 主题
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
