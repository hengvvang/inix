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
    apps = {
      editors = {
        vim.enable = true;
        vscode.enable = true;
        # micro.enable = true;
        zed.enable = true;
      };
      shells = {
        fish.enable = true;
        aliases.enable = true;
        prompts.starship.enable = true;
        zsh.enable = true;
        nushell.enable = true;
      };
      terminals = {
        ghostty.enable = true;
      };
      yazi.enable = true;
    };
    
    development = {
      versionControl = {
        git.enable = true;
        lazygit.enable = true;
      };
      languages = {
        rust.enable = true;
        python.enable = true;
        javascript.enable = true;
        typescript.enable = true;
        cpp.enable = true;
        c.enable = true;
      };
      embedded = {
        toolchain.enable = true;
      };
    };
    
    dotfiles = {
      enable = true;
      vim.enable = true;
      zsh.enable = true;
      fish.enable = true;
      nushell.enable = true;
      yazi.enable = true;
      ghostty.enable = true;
    };
    
    profiles = {
      fonts = {
        fonts.enable = true;            # 字体配置
      };
    };
    
    # 工具包 - 选择具体的工具
    toolkits = {
      system = {
        hardware.enable = true;         # 硬件工具
        monitor.enable = true;          # 系统监控
        network.enable = true;          # 网络工具
        utilities.enable = true;        # 系统工具
      };
      user = {
        utilities.enable = true;        # 用户工具
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
