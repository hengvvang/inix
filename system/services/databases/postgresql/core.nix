{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.databases.postgresql.enable {
    # PostgreSQL 核心服务配置
    services.postgresql = {
      enable = true;
      package = pkgs."postgresql_${config.mySystem.services.databases.postgresql.version}";
      
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
        random_page_cost = 1.1;
        effective_io_concurrency = 200;
      };
      
      # 认证配置
      authentication = pkgs.lib.mkOverride 10 ''
        local all all trust
        host all all 127.0.0.1/32 trust
        host all all ::1/128 trust
      '';
    };

    # PostgreSQL 管理工具
    environment.systemPackages = with pkgs; [
      postgresql
      pgcli
      
      (writeShellScriptBin "postgres-manager" ''
        #!/bin/bash
        
        case "$1" in
          status)
            echo "PostgreSQL 服务状态:"
            systemctl status postgresql
            ;;
          logs)
            echo "PostgreSQL 日志:"
            journalctl -u postgresql -f
            ;;
          connect)
            echo "连接到 PostgreSQL..."
            sudo -u postgres psql
            ;;
          createdb)
            if [ -z "$2" ]; then
              echo "Usage: postgres-manager createdb <database-name>"
              exit 1
            fi
            sudo -u postgres createdb "$2"
            echo "数据库 $2 创建成功"
            ;;
          dropdb)
            if [ -z "$2" ]; then
              echo "Usage: postgres-manager dropdb <database-name>"
              exit 1
            fi
            sudo -u postgres dropdb "$2"
            echo "数据库 $2 删除成功"
            ;;
          backup)
            if [ -z "$2" ]; then
              echo "Usage: postgres-manager backup <database-name>"
              exit 1
            fi
            BACKUP_DIR="/var/backups/postgresql"
            mkdir -p "$BACKUP_DIR"
            sudo -u postgres pg_dump "$2" > "$BACKUP_DIR/$2-$(date +%Y%m%d_%H%M%S).sql"
            echo "数据库 $2 备份完成"
            ;;
          *)
            echo "Usage: postgres-manager {status|logs|connect|createdb|dropdb|backup}"
            exit 1
            ;;
        esac
      '')
    ];

    # 备份目录
    systemd.tmpfiles.rules = [
      "d /var/backups/postgresql 0700 postgres postgres -"
    ];
  };
}
