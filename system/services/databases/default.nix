{ config, lib, pkgs, ... }:

{
  options.mySystem.services.databases = {
    postgresql = {
      enable = lib.mkEnableOption "PostgreSQL 数据库服务";
      backup.enable = lib.mkEnableOption "PostgreSQL 自动备份";
      replication.enable = lib.mkEnableOption "PostgreSQL 主从复制";
      monitoring.enable = lib.mkEnableOption "PostgreSQL 性能监控";
      
      version = lib.mkOption {
        type = lib.types.enum [ "13" "14" "15" "16" ];
        default = "15";
        description = "PostgreSQL 版本选择";
      };
    };
    
    redis = {
      enable = lib.mkEnableOption "Redis 缓存服务";
      cluster.enable = lib.mkEnableOption "Redis 集群模式";
      sentinel.enable = lib.mkEnableOption "Redis Sentinel 高可用";
      monitoring.enable = lib.mkEnableOption "Redis 监控";
    };
    
    mysql = {
      enable = lib.mkEnableOption "MySQL/MariaDB 数据库服务";
      backup.enable = lib.mkEnableOption "MySQL 自动备份";
      replication.enable = lib.mkEnableOption "MySQL 主从复制";
    };
    
    mongodb = {
      enable = lib.mkEnableOption "MongoDB 文档数据库";
      replica.enable = lib.mkEnableOption "MongoDB 副本集";
      sharding.enable = lib.mkEnableOption "MongoDB 分片";
    };
  };

  imports = [
    ./postgresql
    ./redis
    ./mysql
    ./mongodb
  ];
}
