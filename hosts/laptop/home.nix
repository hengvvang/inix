{ config, pkgs, lib, ... }:

{
  imports = [
    # 使用新的模块化配置
    ../../home
    ../../pkgs/home.nix
  ];
  
  # 用户类型选项
  options.user = lib.mkOption {
    type = lib.types.enum [ "hengvvang" "zlritsu" ];
    default = "hengvvang";
    description = "User profile type";
  };
  
  # 所有配置都必须放在 config 属性下
  config = lib.mkMerge [
    # 基础配置
    {
      # 允许非自由软件
      nixpkgs.config.allowUnfree = true;
      
      home.username = lib.mkDefault "hengvvang";
      home.homeDirectory = lib.mkDefault "/home/${config.home.username}";
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
        toolkits = {
          enable = true;
          files.enable = true;
          text.enable = true;
          network.enable = true;
          monitor.enable = true;
          develop.enable = true;
        };
      };
      
      programs.home-manager.enable = true;
    }
    
    # hengvvang 特定配置
    (lib.mkIf (config.user == "hengvvang") {
      home.username = "hengvvang";
      home.homeDirectory = "/home/hengvvang";
      
      myHome = {
        develop = {
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
          bash.enable = true;         # 启用 Bash 配置
          fish.enable = true;         # 启用 Fish 配置
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
          fonts = {
            enable = true;
            preset = "bauhaus";
          };
        };
      };
      
      home.sessionVariables = {
        EDITOR = lib.mkDefault "vim";
        USER_TYPE = "hengvvang";
      };
    })
    
    # zlritsu 特定配置
    (lib.mkIf (config.user == "zlritsu") {
      home.username = "zlritsu";
      home.homeDirectory = "/home/zlritsu";
      
      myHome = {
        develop = {
          # 按语言直接配置
          rust = {
            enable = true;
            embedded.enable = false;    # 不需要嵌入式开发
          };
          python.enable = true;
          javascript.enable = true;
          typescript.enable = false;    # 不需要 TypeScript
          cpp.enable = false;           # 不需要 C/C++
        };
        
        dotfiles = {
          vim.enable = true;
          zsh.enable = false;             # 不使用 zsh
          fish.enable = true;             # 使用 fish
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
          fonts = {
            enable = true;
            preset = "nordic";            # 使用不同的字体主题
          };
        };
      };
      
      home.sessionVariables = {
        EDITOR = lib.mkDefault "nano";    # 使用不同的编辑器
        USER_TYPE = "zlritsu";
      };
    })
  ];
}
