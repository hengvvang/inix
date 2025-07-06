{ config, lib, pkgs, ... }:

{
  # SSH 监控功能实现
  config = lib.mkMerge [
    # 详细日志记录
    (lib.mkIf (config.mySystem.services.network.ssh.enable && config.mySystem.services.network.ssh.monitoring.logging) {
      services.openssh.settings = {
        LogLevel = "VERBOSE";
        SyslogFacility = "AUTHPRIV";
      };
      
      # 日志分析工具
      environment.systemPackages = with pkgs; [
        logwatch
        goaccess  # 日志分析工具
      ];
    })
    
    # 性能指标收集
    (lib.mkIf (config.mySystem.services.network.ssh.enable && config.mySystem.services.network.ssh.monitoring.metrics) {
      # SSH 连接监控
      environment.systemPackages = with pkgs; [
        iftop     # 网络流量监控
        nethogs   # 进程网络使用监控
        ss        # 网络连接状态
      ];
      
      # 可选：集成 Prometheus 监控
      # services.prometheus.exporters.node.enable = true;
    })
  ];
}
