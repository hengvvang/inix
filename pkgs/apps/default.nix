{ config, lib, pkgs, ... }:

{
  options.myPkgs.apps = {
    enable = lib.mkEnableOption "系统应用支持";
    
    # Shell 工具
    shells = {
      enable = lib.mkEnableOption "Shell 工具";
    };
    
    # 终端工具
    terminals = {
      enable = lib.mkEnableOption "终端工具";
    };
    
    # 开发工具
    develop = {
      enable = lib.mkEnableOption "开发工具";
    };
    
    # 浏览器
    browsers = {
      enable = lib.mkEnableOption "浏览器";
    };
    
    # 通讯工具
    communication = {
      enable = lib.mkEnableOption "通讯工具";
    };
    
    # 媒体工具
    media = {
      enable = lib.mkEnableOption "媒体工具";
    };
    
    # 办公工具
    office = {
      enable = lib.mkEnableOption "办公工具";
    };
    
    # 游戏娱乐
    gaming = {
      enable = lib.mkEnableOption "游戏娱乐";
    };
    
    # 网络工具
    network = {
      enable = lib.mkEnableOption "网络工具";
    };
  };

  imports = [
    ./shells.nix
    ./terminals.nix
    ./development.nix
    ./browsers.nix
    ./communication.nix
    ./media.nix
    ./office.nix
    ./gaming.nix
    ./network.nix
  ];
}
