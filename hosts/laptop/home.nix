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
    development = {
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
      git.enable = true;
      lazygit.enable = true;
      starship.enable = true;
      
      # 代理服务用户配置 - 预设所有选项，默认禁用，按需启用
      proxy = {
        # Clash 用户配置
        clash = {
          enable = false;                    # 🔴 禁用 - 需要时设为 true
          configMethod = "homemanager";      # 配置方式: "direct" | "external" | "homemanager"
        };
        
        # 注意：其他代理服务（V2Ray, Xray, Shadowsocks）目前只有系统服务配置
        # 如需要用户端配置文件管理，可以后续扩展 dotfiles 模块
      };
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
