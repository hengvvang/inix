{ config, pkgs, lib, ... }:

{
  # 允许非自由软件
  nixpkgs.config.allowUnfree = true;
  
  imports = [
    # 使用新的模块化配置
    ../../home
  ];
  
  # 基础配置
  home.username = "hengvvang";
  home.homeDirectory = "/home/hengvvang";
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
      vim.enable = true;                 # Vim 配置
      zsh.enable = true;                 # Zsh 配置
      fish.enable = true;                # Fish 配置
      nushell.enable = true;             # Nushell 配置
      yazi.enable = true;                # Yazi 文件管理器
      ghostty.enable = true;             # Ghostty 终端
      alacritty.enable = true;           # Alacritty 终端 (新增)
      tmux.enable = true;                # Tmux 会话管理 (新增)
      git.enable = true;                 # Git 配置
      lazygit.enable = true;             # LazyGit 配置
      starship.enable = true;            # Starship 提示符
      
      # 代理服务用户配置
      proxy = {
        enable = false;                   # 启用代理配置模块
        clash = {
          enable = false;                # 🔴 禁用 - 需要时设为 true
          configMethod = "homemanager";  # 配置方式: "direct" | "external" | "homemanager"
        };
      };
    };
    
    # 用户配置档案
    profiles = {
      enable = true;                     # 启用配置档案模块
      fonts = {
        enable = true;                   # 启用字体配置
        fonts.enable = true;             # 字体包
      };
    };
    
    # 工具包配置
    toolkits = {
      enable = true;                     # 启用工具包模块
      system = {
        enable = true;                   # 启用系统工具包
        hardware.enable = true;          # 硬件工具
        monitor.enable = true;           # 系统监控
        network.enable = true;           # 网络工具
        utilities.enable = true;         # 系统工具
      };
      user = {
        enable = true;                   # 启用用户工具包
        utilities.enable = true;         # 用户工具
      };
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
