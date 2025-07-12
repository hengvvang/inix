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
      
      home.username = "zlritsu";
      home.homeDirectory = "/home/zlritsu";
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
            enable = true;
            # 使用默认壁纸路径 (home/profiles/stylix/wallpapers/sea.jpg)
            polarity = "dark";
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
        pkgs = {
          enable = true;
          toolkits = {
            enable = true;
            files.enable = true;
            text.enable = true;
            network.enable = false;    # zlritsu 轻量级配置
            monitor.enable = false;    # zlritsu 轻量级配置
            develop.enable = false;    # zlritsu 轻量级配置
          };
          apps = {
            enable = true;
            shells.enable = true;
            terminals.enable = true;
            develop.enable = false;    # zlritsu 轻量级配置
            browsers.enable = true;
            communication.enable = false;  # zlritsu 轻量级配置
            media.enable = true;
            office.enable = false;     # zlritsu 轻量级配置
            gaming.enable = false;     # zlritsu 轻量级配置
            network.enable = false;    # zlritsu 轻量级配置
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
          # 轻量级开发配置
          python.enable = true;
        };
        
        dotfiles = {
          enable = true;
          vim.enable = true;
          zsh.enable = true;
          fish.enable = true;
          ghostty.enable = true;
          git.enable = true;
          starship.enable = true;
        };
        
        profiles = {
          enable = true;
          fonts = {
            enable = true;
            preset = "nordic";
          };
        };
      };
    })
    
    # daily 主机特定配置
    (lib.mkIf (config.host == "daily") {
      myHome = {
        develop = {
          enable = true;
          # 轻量级开发配置
          python.enable = true;
        };
        
        dotfiles = {
          enable = true;
          vim.enable = true;
          zsh.enable = true;
          fish.enable = true;
          ghostty.enable = true;
          git.enable = true;
          starship.enable = true;
        };
        
        profiles = {
          enable = true;
          fonts = {
            enable = true;
            preset = "forest";
          };
        };
      };
    })
    
    # work 主机特定配置
    (lib.mkIf (config.host == "work") {
      myHome = {
        develop = {
          enable = true;
          # 轻量级开发配置
          python.enable = true;
          javascript.enable = true;
        };
        
        dotfiles = {
          enable = true;
          vim.enable = true;
          zsh.enable = true;
          fish.enable = true;
          ghostty.enable = true;
          git.enable = true;
          starship.enable = true;
          proxy.enable = true;        # 工作环境可能需要代理
        };
        
        profiles = {
          enable = true;
          fonts = {
            enable = true;
            preset = "cyberPunk";
          };
        };
      };
    })
  ];
}
