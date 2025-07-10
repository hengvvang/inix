{ config, pkgs, lib, ... }:

{
  imports = [
    # 使用新的模块化配置
    ../../home
    ../../pkgs/home.nix
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
        profiles.enable = true;
      };
      
      myPkgs = {
        enable = true;
        apps = {
          enable = true;
          terminals.enable = true;
          shells.enable = true;
          browsers.enable = true;
        };
        toolkits = {
          enable = true;
          files.enable = true;
          text.enable = true;
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
            preset = "minimal";
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
            preset = "minimal";
          };
        };
      };
      
      myPkgs.apps = {
        media.enable = true;         # 日常主机启用媒体软件
        gaming.enable = true;        # 日常主机启用游戏
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
            preset = "minimal";
          };
        };
      };
      
      myPkgs.apps = {
        office.enable = true;        # 工作主机启用办公软件
        media.enable = false;        # 工作环境不需要媒体软件
        gaming.enable = false;       # 工作环境不启用游戏
      };
    })
  ];
}
