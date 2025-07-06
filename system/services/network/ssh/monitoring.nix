{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.network.ssh;
in
{
  # SSH 监控功能实现
  config = lib.mkMerge [
    # 基础连接监控
    (lib.mkIf (cfg.enable && cfg.monitoring.enable) {
      # SSH 连接监控工具
      environment.systemPackages = with pkgs; [
        ss         # 网络连接状态
        netstat    # 网络统计
      ];
    })
    
    # 详细日志记录
    (lib.mkIf (cfg.enable && cfg.server.enable && cfg.monitoring.verboseLogging) {
      services.openssh.settings = {
        LogLevel = "VERBOSE";
        SyslogFacility = "AUTHPRIV";
      };
      
      # 日志分析工具
      environment.systemPackages = with pkgs; [
        logwatch   # 日志监控
      ];
    })
  ];
}
