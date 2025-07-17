# 🌑 新月

{ config, lib, pkgs, ... }:

let
  cfg = config.myPkgs;
in
{
  config = lib.mkMerge [
    # Home 配置
    (lib.mkIf (cfg.enable && cfg.target == "home" && cfg.apps.newMoon.enable) {
      home.packages = with pkgs; [
        
        # 完整应用生态将在这里配置

      ];
    })
    
    # System 配置  
    (lib.mkIf (cfg.enable && cfg.target == "system" && cfg.apps.newMoon.enable) {
      environment.systemPackages = with pkgs; [
        
        # 完整应用生态将在这里配置

      ];
    })
  ];
}
