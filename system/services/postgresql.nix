{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.postgresql.enable {
    # PostgreSQL 数据库配置
    services.postgresql = {
      enable = true;
      package = pkgs.postgresql_15;
      
      # 数据库初始配置
      ensureDatabases = [ "hengvvang" ];
      ensureUsers = [
        {
          name = "hengvvang";
          ensureDBOwnership = true;
        }
      ];
      
      # 性能优化设置
      settings = {
        shared_buffers = "256MB";
        effective_cache_size = "1GB";
        maintenance_work_mem = "64MB";
        checkpoint_completion_target = 0.9;
        wal_buffers = "16MB";
        default_statistics_target = 100;
      };
      
      # 认证配置
      authentication = pkgs.lib.mkOverride 10 ''
        local all all trust
        host all all 127.0.0.1/32 trust
        host all all ::1/128 trust
      '';
    };

    # 防火墙配置（如果需要远程访问）
    # networking.firewall.allowedTCPPorts = [ 5432 ];
  };
}
