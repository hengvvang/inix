{ config, pkgs, lib, ... }:

{
  imports = [
    # 使用新的模块化配置
    ../../home
  ];
  
  # 主机选项
  options.host = lib.mkOption {
    type = lib.types.enum [ "laptop" "daily" "work" ];
    default = "laptop";
    description = "Host type";
  };
  
  # 所有配置都必须放在 config 属性下
  config = lib.mkMerge [
    # 基础配置
    {
      # 允许非自由软件
      nixpkgs.config.allowUnfree = true;
      
      home.username = "hengvvang";
      home.homeDirectory = "/home/hengvvang";
      home.stateVersion = "25.05";
    }
    
    # 通用配置
    {
      myHome = {
        develop.enable = true;
        dotfiles.enable = true;
        profiles = {
          enable = true;
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
      };
      
      programs.home-manager.enable = true;
    }
    
    # laptop 主机特定配置
    (lib.mkIf (config.host == "laptop") {
      myHome = {
        develop = {
          enable = true;
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
          enable = true;
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
          proxy.enable = false;
        };
        
        profiles = {
          enable = true;
          fonts = {
            enable = true;
            preset = "bauhaus";
          };
        };
      };
    })
    
    # daily 主机特定配置
    (lib.mkIf (config.host == "daily") {
      myHome = {
        develop = {
          enable = true;
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
          enable = true;
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
        
        profiles = {
          enable = true;
          fonts = {
            enable = true;
            preset = "bauhaus";
          };
        };
      };
    })
    
    # work 主机特定配置
    (lib.mkIf (config.host == "work") {
      myHome = {
        develop = {
          enable = true;
          # devenv 项目环境管理配置 - work 主机
          devenv = {
            enable = true;        # 启用 devenv
            autoSwitch = true;    # 启用自动环境切换（direnv）
            shell = "fish";       # 使用 fish shell
            templates = false;    # 工作环境轻量级配置
            cache = true;         # 启用构建缓存优化
          };
          # 工作环境的开发配置
          rust.enable = true;
          python.enable = true;
          javascript.enable = true;
          typescript.enable = true;
          cpp.enable = true;
        };
        
        dotfiles = {
          enable = true;
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
          proxy.enable = true;        # 工作环境可能需要代理
        };
        
        profiles = {
          enable = true;
          fonts = {
            enable = true;
            preset = "tokyo";  # 专业字体配置
          };
        };
      };
    })
  ];
}
