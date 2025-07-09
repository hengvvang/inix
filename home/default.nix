{ config, lib, pkgs, ... }:

{
  imports = [
    ./develop
    ./profiles
    ./dotfiles
  ];

  myHome = {
    # Dotfiles 配置管理
    dotfiles = {
      enable = lib.mkDefault false;
      vim.enable = lib.mkDefault false;
      zsh.enable = lib.mkDefault false;
      bash.enable = lib.mkDefault false;
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
    develop = {
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
      };
    };
  };
  
}
