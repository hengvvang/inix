# 🌗 下弦月

{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.pkgs.apps.lastQuarter.enable {
    home.packages = with pkgs; [
      
      ghostty

      lazygit

      qutebrowser
      
      #google-chrome
      #firefox
      
      telegram-desktop
      discord
      #qq
      #wechat-uos
      
      wpsoffice-cn
      pot
      
      spotify
      vlc
      rmpc
      # clash-verge-rev   # 代理工具（主要）
      # clash-nyanpasu    # 代理工具（备用）
      # clash-meta        # Clash 内核
      
    ];
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
      ];
    };
  };
}
