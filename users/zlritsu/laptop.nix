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
        # MPD 用户级音乐服务配置 - zlritsu 用户
        mpd = {
          enable = true;                        # 启用用户级 MPD 服务
          musicDirectory = "${config.home.homeDirectory}/Music";  # 音乐目录
          port = 6601;                          # 使用不同端口避免冲突
          autoStart = true;                     # 开机自动启动
          clients = {
            mpc = true;                         # 安装 mpc 命令行客户端
            ncmpcpp = false;                    # zlritsu 轻量级配置，不安装终端客户端
          };
        };
        proxy.enable = false;
      };
      
      # 包管理配置
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
