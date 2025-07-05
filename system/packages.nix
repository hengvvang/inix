{ config, lib, pkgs, ... }:

{
  options.mySystem.packages.enable = lib.mkEnableOption "系统包配置" // {
    default = false;
  };

  config = lib.mkIf config.mySystem.packages.enable {
  environment.systemPackages = with pkgs; [
    # 基础工具
    wget
    vim
    git
    htop
    yazi
    fish
    nushell
    
    # 开发工具
    rustup
    vscode
    zed-editor
    
    # 网络工具
    google-chrome
    clash-verge-rev
    telegram-desktop
    discord
    
    # 多媒体
    spotify
    obs-studio
    
    # 办公软件
    wpsoffice-cn
    qq
    wechat-uos
    
    # 终端模拟器
    ghostty
    
    # 游戏
    steam
    
    # Shell 插件
    fishPlugins.pure
    nushellPlugins.gstat
  ];
  };
}
