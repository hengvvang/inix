# 🌓 上弦月

{ config, lib, pkgs, ... }:

let
  cfg = config.myPkgs;
in
{
  config = lib.mkMerge [
    # Home 配置
    (lib.mkIf (cfg.enable && cfg.target == "home" && cfg.toolkits.firstQuarter.enable) {
      home.packages = with pkgs; [
        
        # 开发和终端工具将在这里配置

      ];
    })
    
    # System 配置  
    (lib.mkIf (cfg.enable && cfg.target == "system" && cfg.toolkits.firstQuarter.enable) {
      environment.systemPackages = with pkgs; [
        
        # 开发和终端工具将在这里配置

      ];
    })
  ];
}
