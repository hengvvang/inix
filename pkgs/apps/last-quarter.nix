# 🌗 下弦月

{ config, lib, pkgs, ... }:

let
  cfg = config.myPkgs;
in
{
  config = lib.mkMerge [
    # Home 配置
    (lib.mkIf (cfg.enable && cfg.target == "home" && cfg.apps.lastQuarter.enable) {
      home.packages = with pkgs; [
        
        ghostty

        lazygit

        qutebrowser
        
        google-chrome
        #firefox
        
        telegram-desktop
        discord
        qq
        wechat-uos
        
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
    })
    
    # System 配置  
    (lib.mkIf (cfg.enable && cfg.target == "system" && cfg.apps.lastQuarter.enable) {
      environment.systemPackages = with pkgs; [
        
        ghostty

        lazygit

        qutebrowser
        
        google-chrome
        #firefox
        
        telegram-desktop
        discord
        qq
        wechat-uos
        
        wpsoffice-cn
        pot
        
        spotify
        vlc
        rmpc
        # clash-verge-rev   # 代理工具（主要）
        # clash-nyanpasu    # 代理工具（备用）
        # clash-meta        # Clash 内核
        
      ];
    })
  ];
}
