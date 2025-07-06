{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.services.databases.postgresql.enable && config.mySystem.services.databases.postgresql.backup.enable) {
    # PostgreSQL 自动备份配置
    services.postgresqlBackup = {
      enable = true;
      databases = [ "hengvvang" ];
      startAt = "*-*-* 02:00:00";  # 每天凌晨2点备份
      location = "/var/backups/postgresql";
      compression = "gzip";
    };

    # 备份清理任务
    systemd.services.postgresql-backup-cleanup = {
      description = "PostgreSQL 备份清理";
      
      serviceConfig = {
        Type = "oneshot";
        User = "postgres";
      };
      
      script = ''
        # 保留最近30天的备份
        find /var/backups/postgresql -name "*.sql.gz" -mtime +30 -delete
        echo "PostgreSQL 备份清理完成: $(date)"
      '';
    };

    # 备份清理计时器
    systemd.timers.postgresql-backup-cleanup = {
      description = "PostgreSQL 备份清理计时器";
      wantedBy = [ "timers.target" ];
      
      timerConfig = {
        OnCalendar = "weekly";
        Persistent = true;
      };
    };
  };
}
