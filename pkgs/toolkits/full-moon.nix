# 🌕 满月

{ config, lib, pkgs, ... }:

let
  cfg = config.myPkgs;
in
{
  config = lib.mkMerge [
    # Home 配置
    (lib.mkIf (cfg.enable && cfg.target == "home" && cfg.toolkits.fullMoon.enable) {
      home.packages = with pkgs; [
        
        # 完整工具生态将在这里配置

      ];
    })
    
    # System 配置  
    (lib.mkIf (cfg.enable && cfg.target == "system" && cfg.toolkits.fullMoon.enable) {
      environment.systemPackages = with pkgs; [
        
        # 完整工具生态将在这里配置

      ];
    })
  ];
}
