{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.mongodb.enable {
    # MongoDB 数据库配置
    services.mongodb = {
      enable = true;
      
      # 数据库配置
      bind_ip = "127.0.0.1";
      quiet = true;
      
      # 存储配置
      dbpath = "/var/lib/mongodb";
      
      # 日志配置
      logpath = "/var/log/mongodb/mongodb.log";
      logappend = true;
      
      # 性能配置
      extraConfig = ''
        # 存储引擎
        storage.engine: wiredTiger
        
        # 网络配置
        net.maxIncomingConnections: 100
        
        # 操作分析配置
        operationProfiling.mode: slowOp
        operationProfiling.slowOpThresholdMs: 100
      '';
    };

    # 防火墙配置（如果需要远程访问）
    # networking.firewall.allowedTCPPorts = [ 27017 ];
  };
}
