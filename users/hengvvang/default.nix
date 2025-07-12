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
            enable = true;
            polarity = "dark";
            wallpapers = {
              enable = true;
              preset = "sea";  # 或者使用 custom = ./assets/wallpapers/my-wallpaper.jpg;
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
          enable = true;
          toolkits = {
            enable = true;
            files.enable = true;
            text.enable = true;
            network.enable = true;
            monitor.enable = true;
            develop.enable = true;
          };
          apps = {
            enable = true;
            shells.enable = true;
            terminals.enable = true;
            develop.enable = true;
            browsers.enable = true;
            communication.enable = true;
            media.enable = true;
            office.enable = true;
            gaming.enable = true;
            network.enable = true;
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
