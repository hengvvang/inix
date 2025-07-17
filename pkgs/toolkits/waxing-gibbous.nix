# 🌔 盈凸月

{ config, lib, pkgs, ... }:

let
  cfg = config.myPkgs;
in
{
  config = lib.mkMerge [
    # Home 配置
    (lib.mkIf (cfg.enable && cfg.target == "home" && cfg.toolkits.waxingGibbous.enable) {
      home.packages = with pkgs; [
        
        # 高级工具套件将在这里配置

      ];
    })
    
    # System 配置  
    (lib.mkIf (cfg.enable && cfg.target == "system" && cfg.toolkits.waxingGibbous.enable) {
      environment.systemPackages = with pkgs; [
        
        # 高级工具套件将在这里配置

      ];
    })
  ];
}
