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
      
      pkgs = {
        enable = true;
        toolkits = {
          enable = true;              # 启用工具包模块
          waxingCrescent.enable = true;  # 🌒 峨眉月
          firstQuarter.enable = true;    # 🌓 上弦月
          waxingGibbous.enable = true;   # 🌔 盈凸月
          fullMoon.enable = false;       # 🌕 满月 
        };
        apps = {
          waningCrescent.enable = true;  # 🌘 残月
          lastQuarter.enable = true;     # 🌗 下弦月
          waningGibbous.enable = false;  # 🌖 亏凸月
          newMoon.enable = false;        # 🌑 新月 
        };
      };
      
      profiles = {
        enable = true;
        fonts = {
          enable = true;
          preset = "tokyo";
        };
        stylix = {
          enable = false;                      # ✅ 启用 Stylix 主题系统
          polarity = "light";                 # 🌞 切换到亮色模式（简约白色主题）
          
          # 🎨 启用自定义颜色配置
          colors = {
            enable = true;                    # ✅ 启用自定义颜色
            scheme = "catppuccin-latte";            # 🤍 使用简约白色暖色调主题
          };
          
          wallpapers = {
            enable = false;                   # ❌ 禁用壁纸（使用纯色背景）
          };
          
          fonts = {
            enable = true;
            names = {
              monospace = "JetBrainsMono Nerd Font Mono";  # ✅ 优质等宽字体
              sansSerif = "Noto Sans";                     # ✅ 现代无衬线字体
              serif = "Noto Serif";                        # ✅ 经典衬线字体
              emoji = "Noto Color Emoji";                  # ✅ 彩色表情字体
            };
            sizes = {
              terminal = 14;      # ✅ 终端字体大小（适合开发）
              applications = 12;  # ✅ 应用字体大小（舒适阅读）
              desktop = 11;       # ✅ 桌面字体大小（界面元素）
              popups = 11;        # ✅ 弹窗字体大小（提示信息）
            };
          };

          targets = {
            enable = true;
            
            # 🖥️ 终端应用主题（简约白色）
            terminals = {
              alacritty.enable = false;       # ❌ 禁用 Alacritty（使用 Ghostty）
              kitty.enable = false;            # ✅ 启用 Kitty 主题（备用终端）
            };
            
            # ✏️ 编辑器主题（简约白色）
            editors = {
              vim.enable = true;              # ✅ 启用 Vim 主题
              neovim.enable = false;           # ✅ 启用 Neovim 主题
            };
            
            # 🛠️ 工具主题（简约白色）
            tools = {
              tmux.enable = true;             # ✅ 启用 Tmux 主题
              bat.enable = true;              # ✅ 启用 Bat 主题
              fzf.enable = true;              # ✅ 启用 Fzf 主题
            };
            
            # 🖼️ 桌面环境主题（简约白色）
            desktop = {
              gtk.enable = true;              # ✅ 启用 GTK 主题（应用一致性）
            };
            
            # 🌐 浏览器主题（简约白色）
            browsers = {
              firefox.enable = false;          # ✅ 启用 Firefox 主题
            };
            
            # ⌨️ 输入法主题（简约白色）
            inputMethods = {
              fcitx5.enable = true;           # ✅ 启用 Fcitx5 主题（中文输入法）
            };
          };
        };
      };
    };
  };
}
