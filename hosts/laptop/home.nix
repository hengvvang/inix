{ config, pkgs, lib, ... }:

{
  # 允许非自由软件
  nixpkgs.config.allowUnfree = true;
  
  imports = [
    # 使用新的模块化配置
    ../../home
    ../../pkgs/home.nix
  ];
  
  # 基础配置
  home.username = lib.mkDefault "hengvvang";
  home.homeDirectory = lib.mkDefault "/home/${config.home.username}";
  home.stateVersion = "25.05";

  myHome = {
    # 开发环境配置
    develop = {
      enable = true;                     # 启用开发环境模块
      languages = {
        enable = true;                   # 启用编程语言支持
        rust.enable = true;              # Rust 开发环境
        python.enable = true;            # Python 开发环境
        javascript.enable = true;        # JavaScript 开发环境
        typescript.enable = true;        # TypeScript 开发环境
        cpp.enable = true;               # C++ 开发环境
        c.enable = true;                 # C 开发环境
      };
      embedded = {
        enable = true;                   # 启用嵌入式开发
        toolchain.enable = true;         # 嵌入式工具链
      };
    };
    
    # Dotfiles 配置管理
    dotfiles = {
      enable = true;                     # 启用 dotfiles 模块
      
      vim = {
        enable = true;                   # Vim 配置
        # method = "homemanager";        # 可省略，因为是默认值
      };
      
      zsh = {
        enable = true;                   # Zsh 配置
        # method = "homemanager";        # 可省略，因为是默认值
      };
      
      fish = {
        enable = true;                   # Fish 配置
        # method = "homemanager";        # 可省略，因为是默认值
      };
      
      nushell = {
        enable = true;                   # Nushell 配置
        # method = "homemanager";        # 可省略，因为是默认值
      };
      
      yazi = {
        enable = true;                   # Yazi 文件管理器
        # method = "homemanager";        # 可省略，因为是默认值
      };
      
      ghostty = {
        enable = true;                   # Ghostty 终端
        # method = "homemanager";        # 可省略，因为是默认值
      };
      
      alacritty = {
        enable = true;                   # Alacritty 终端 (新增)
        # method = "homemanager";        # 可省略，因为是默认值
      };
      
      tmux = {
        enable = true;                   # Tmux 会话管理 (新增)
        # method = "homemanager";        # 可省略，因为是默认值
      };
      
      git = {
        enable = true;                   # Git 配置
        # method = "homemanager";        # 可省略，因为是默认值
      };
      
      lazygit = {
        enable = true;                   # LazyGit 配置
        # method = "homemanager";        # 可省略，因为是默认值
      };
      
      starship = {
        enable = true;                   # Starship 提示符
        # method = "homemanager";        # 可省略，因为是默认值
      };
      
      # 代理服务用户配置
      proxy = {
        enable = false;                   # 启用代理配置模块
        method = "homemanager";          # 配置方式: "direct" | "external" | "homemanager"
        clash = {
          enable = false;                # 🔴 禁用 - 需要时设为 true
        };
      };
    };
    
    # 用户配置档案
    profiles = {
      enable = true;                     # 启用配置档案模块
      fonts = {
        enable = true;                   # 启用字体配置
        preset = "bauhaus";              # 选择字体风格
      };
    };
  };

  # 包管理配置
  myPkgs = {
    enable = true;                       # 启用包管理模块
    
    # 命令行工具包配置
    toolkits = {
      enable = true;                     # 启用工具包模块
      files.enable = true;               # 文件管理工具
      text.enable = true;                # 文本处理工具
      network.enable = true;             # 网络工具
      monitor.enable = true;             # 系统监控工具
      develop.enable = true;         # 开发辅助工具
    };
  };

  # 核心环境变量
  home.sessionVariables = {
    EDITOR = lib.mkDefault "vim";
    #TERMINAL = "alacritty";
  };

  # 启用 Home Manager
  programs.home-manager.enable = true;
}
