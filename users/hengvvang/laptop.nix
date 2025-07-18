{ config, lib, ... }:

{
  # laptop 主机特定配置
  config = lib.mkIf (config.host == "laptop") {
    myHome = {
      develop = {
        # devenv 项目环境管理配置
        devenv = {
          enable = true;        # 启用 devenv
          autoSwitch = true;    # 启用自动环境切换（direnv）
          shell = "fish";       # 使用 fish shell
          templates = true;     # 安装项目模板工具（完整功能）
          cache = true;         # 启用构建缓存优化
        };
        # 按语言直接配置
        rust = {
          enable = true;
          embedded.enable = true;   # 启用 Rust 嵌入式开发
        };
        python.enable = true;
        javascript.enable = true;
        typescript.enable = true;
        cpp = {
          enable = true;
          embedded.enable = true;   # 启用 C/C++ 嵌入式开发
        };
      };
      
      dotfiles = {
        vim.enable = true;
        zsh.enable = true;
        bash.enable = true;
        fish.enable = true;
        nushell.enable = true;
        yazi.enable = true;
        ghostty.enable = true;
        alacritty.enable = false;
        tmux.enable = true;
        git.enable = true;
        lazygit.enable = true;
        starship.enable = true;
        qutebrowser.enable = false;  # 启用 Qutebrowser 配置
        obs-studio.enable = false;   # 启用 OBS Studio 配置
        mpd.enable = true;            # 🟢 启用 MPD 音乐播放器配置
        proxy.enable = false;
      };
      
      # 包管理配置
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
          waningGibbous.enable = false;  # 🌖 亏凸月 - 桌面生产力套件
          newMoon.enable = false;        # 🌑 新月 - 完整应用生态
        };
      };
      
      profiles = {
        fonts = {
          preset = "bauhaus";
        };
        stylix = {
          enable = false;
          # polarity = "dark";  # ❌ 注释掉，沿用系统配置 (dark)
          # 或者覆盖: polarity = "light";  # ✅ 用户偏好覆盖系统配置
          
          wallpapers = {
            enable = true;
            # preset = "maori";  # ❌ 注释掉，使用自定义壁纸
            custom = ./../../home/profiles/stylix/wallpapers/swirl-loop.jpeg;  # ✅ 覆盖系统壁纸
          };
          
          fonts = {
            enable = true;
            # 📝 可以选择性覆盖系统字体配置
            # names.monospace = "Fira Code Nerd Font Mono";  # 覆盖系统字体
            sizes = {
              # terminal = 14;  # 覆盖系统终端字体大小 (系统默认: 12)
              # applications = 12;  # 覆盖系统应用字体大小 (系统默认: 11)
            };
          };
          
          targets = {
            enable = true;
            
            terminals = {
              alacritty.enable = false;  # ✅ 覆盖系统默认 (true -> false)，避免冲突
              kitty.enable = false;      # ❌ 保持系统默认 (false)
            };
            
            editors = {
              vim.enable = false;        # ✅ 覆盖系统默认 (true -> false)
              neovim.enable = true;      # ❌ 保持系统默认 (true)
            };
            
            tools = {
              tmux.enable = true;        # ✅ 用户启用
              bat.enable = true;         # ✅ 用户启用
              fzf.enable = true;         # ✅ 用户启用
            };
            
            desktop = {
              gtk.enable = true;         # ❌ 沿用系统配置，通常不需要用户级覆盖
            };
            
            browsers = {
              firefox.enable = true;     # ❌ 保持系统默认 (true)
            };
            
            inputMethods = {
              fcitx5.enable = true;      # ✅ 用户启用输入法主题
            };
          };
        };
      };
    };
  };
}
