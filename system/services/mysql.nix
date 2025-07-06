{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.mysql.enable {
    # MySQL 数据库配置
    services.mysql = {
      enable = true;
      package = pkgs.mariadb;
      
      # 数据库初始配置
      ensureDatabases = [ "hengvvang" ];
      ensureUsers = [
        {
          name = "hengvvang";
          ensurePermissions = {
            "hengvvang.*" = "ALL PRIVILEGES";
          };
        }
      ];
      
      # 性能优化设置
      settings = {
        mysqld = {
          innodb_buffer_pool_size = "256M";
          innodb_log_file_size = "64M";
          max_connections = 100;
          query_cache_size = "32M";
          query_cache_type = 1;
          tmp_table_size = "32M";
          max_heap_table_size = "32M";
        };
      };
    };

    # 防火墙配置（如果需要远程访问）
    # networking.firewall.allowedTCPPorts = [ 3306 ];
  };
}
