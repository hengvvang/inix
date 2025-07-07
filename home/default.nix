{ config, lib, pkgs, ... }:

{
  imports = [
    ./toolkits
    ./development
    ./profiles
    ./dotfiles
  ];

  myHome = {
    # Dotfiles 配置管理
    dotfiles = {
      enable = lib.mkDefault false;
      vim.enable = lib.mkDefault false;
      zsh.enable = lib.mkDefault false;
      fish.enable = lib.mkDefault false;
      nushell.enable = lib.mkDefault false;
      yazi.enable = lib.mkDefault false;
      ghostty.enable = lib.mkDefault false;
      git.enable = lib.mkDefault false;
      lazygit.enable = lib.mkDefault false;
      starship.enable = lib.mkDefault false;
      proxy = {
        enable = lib.mkDefault false;
      };
    };
    
    # 开发环境配置
    development = {
      enable = lib.mkDefault false;
      languages = {
        enable = lib.mkDefault false;
        rust.enable = lib.mkDefault false;
        python.enable = lib.mkDefault false;
        javascript.enable = lib.mkDefault false;
        typescript.enable = lib.mkDefault false;
        cpp.enable = lib.mkDefault false;
        c.enable = lib.mkDefault false;
      };
      embedded = {
        enable = lib.mkDefault false;
        toolchain.enable = lib.mkDefault false;
      };
    };
    
    # 用户配置档案
    profiles = {
      enable = lib.mkDefault false;
      fonts = {
        enable = lib.mkDefault false;
        fonts.enable = lib.mkDefault false;
      };
    };
    
    # 工具包配置
    toolkits = {
      enable = lib.mkDefault false;
      system = {
        enable = lib.mkDefault false;
        hardware.enable = lib.mkDefault false;
        monitor.enable = lib.mkDefault false;
        network.enable = lib.mkDefault false;
        utilities.enable = lib.mkDefault false;
      };
      user = {
        enable = lib.mkDefault false;
        utilities.enable = lib.mkDefault false;
      };
    };
  };
}
