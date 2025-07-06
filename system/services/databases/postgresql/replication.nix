{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.services.databases.postgresql.enable && config.mySystem.services.databases.postgresql.replication.enable) {
    # PostgreSQL 主从复制配置（主服务器端配置）
    services.postgresql.settings = {
      # 复制相关配置
      wal_level = "replica";
      max_wal_senders = 3;
      max_replication_slots = 3;
      wal_keep_segments = 8;
      hot_standby = "on";
      
      # 归档配置
      archive_mode = "on";
      archive_command = "test ! -f /var/lib/postgresql/archive/%f && cp %p /var/lib/postgresql/archive/%f";
    };

    # 创建归档目录
    systemd.tmpfiles.rules = [
      "d /var/lib/postgresql/archive 0700 postgres postgres -"
    ];

    # 复制用户配置
    services.postgresql.ensureUsers = [
      {
        name = "replicator";
        ensurePermissions = {
          "ALL TABLES IN SCHEMA public" = "SELECT";
        };
      }
    ];

    # pg_hba.conf 复制配置
    services.postgresql.authentication = lib.mkForce ''
      # 本地连接
      local all all trust
      host all all 127.0.0.1/32 trust
      host all all ::1/128 trust
      
      # 复制连接（需要配置从服务器IP）
      host replication replicator 192.168.1.0/24 trust
    '';
  };
}
