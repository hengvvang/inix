# 🌖 亏凸月

{ config, lib, pkgs, ... }:

let
  cfg = config.myPkgs;
in
{
  config = lib.mkMerge [
    # Home 配置
    (lib.mkIf (cfg.enable && cfg.target == "home" && cfg.apps.waningGibbous.enable) {
      home.packages = with pkgs; [

        fish   
        nushell

        tmux
        
        git

        nano
        vim  
        vscode
        zed-editor
        
        yazi

        
      ];
    })
    
    # System 配置  
    (lib.mkIf (cfg.enable && cfg.target == "system" && cfg.apps.waningGibbous.enable) {
      environment.systemPackages = with pkgs; [

        fish   
        nushell

        tmux
        
        git

        nano
        vim  
        vscode
        zed-editor
        
        yazi

        
      ];
    })
  ];
}
