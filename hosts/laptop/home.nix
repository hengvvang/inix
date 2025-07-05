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

  # Home Manager 模块配置 - 完整的重构后配置
  # 直接选择具体功能，减少配置层级
  myHome = {
    # 应用程序 - 选择具体的应用
    apps = {
      editors = {
        vim = true;              # Vim 编辑器
        vscode = true;           # VSCode 编辑器
        # micro = true;          # Micro 编辑器 (可选)
        # zed = true;            # Zed 编辑器 (可选)
      };
      shells = {
        fish = true;             # Fish Shell
        aliases = true;          # Shell 别名
        prompts.starship = true; # Starship 提示符
        # zsh = true;            # Zsh Shell (可选)
        # nushell = true;        # Nushell (可选)
      };
      terminals = {
        # ghostty = true;        # Ghostty 终端 (可选)
      };
      # yazi = true;             # Yazi 文件管理器 (可选)
    };
    
    # 开发环境 - 选择具体的语言和工具
    development = {
      versionControl = {
        git = true;              # Git 版本控制
        lazygit = true;          # Lazygit TUI
      };
      languages = {
        rust = true;             # Rust 开发环境
        python = true;           # Python 开发环境
        javascript = true;       # JavaScript 开发环境
        typescript = true;       # TypeScript 开发环境
        # cpp = true;            # C++ 开发环境 (可选)
        # c = true;              # C 开发环境 (可选)
      };
      embedded = {
        # toolchain = true;      # 嵌入式工具链 (可选)
      };
    };
    
    # 配置文件 - 选择具体的配置
    profiles = {
      fonts = {
        fonts = true;            # 字体配置
      };
      envVar = {
        environment = true;      # 环境变量配置
      };
    };
    
    # 工具包 - 选择具体的工具
    toolkits = {
      system = {
        hardware = true;         # 硬件工具
        monitor = true;          # 系统监控
        network = true;          # 网络工具
        utilities = true;        # 系统工具
      };
      user = {
        utilities = true;        # 用户工具
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
