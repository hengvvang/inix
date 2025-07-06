{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.services.databases.postgresql.enable && config.mySystem.services.databases.postgresql.monitoring.enable) {
    # PostgreSQL 性能监控配置
    services.postgresql.settings = {
      # 监控相关设置
      shared_preload_libraries = "pg_stat_statements";
      track_activities = "on";
      track_counts = "on";
      track_io_timing = "on";
      track_functions = "all";
      
      # 慢查询日志
      log_min_duration_statement = 1000;  # 记录超过1秒的查询
      log_checkpoints = "on";
      log_connections = "on";
      log_disconnections = "on";
      log_lock_waits = "on";
      
      # 统计信息
      pg_stat_statements.max = 10000;
      pg_stat_statements.track = "all";
    };

    # PostgreSQL 监控工具
    environment.systemPackages = with pkgs; [
      (writeShellScriptBin "postgres-monitor" ''
        #!/bin/bash
        
        case "$1" in
          stats)
            echo "PostgreSQL 统计信息:"
            sudo -u postgres psql -c "
              SELECT 
                schemaname,
                tablename,
                n_tup_ins as inserts,
                n_tup_upd as updates,
                n_tup_del as deletes,
                n_live_tup as live_tuples,
                n_dead_tup as dead_tuples
              FROM pg_stat_user_tables
              ORDER BY n_live_tup DESC
              LIMIT 10;
            "
            ;;
          slow-queries)
            echo "慢查询 Top 10:"
            sudo -u postgres psql -c "
              SELECT 
                query,
                calls,
                total_time,
                mean_time,
                rows
              FROM pg_stat_statements
              ORDER BY total_time DESC
              LIMIT 10;
            "
            ;;
          connections)
            echo "当前连接状态:"
            sudo -u postgres psql -c "
              SELECT 
                datname,
                usename,
                application_name,
                client_addr,
                state,
                query_start,
                state_change
              FROM pg_stat_activity
              WHERE state != 'idle'
              ORDER BY query_start;
            "
            ;;
          locks)
            echo "当前锁状态:"
            sudo -u postgres psql -c "
              SELECT 
                l.locktype,
                l.database,
                l.relation,
                l.page,
                l.tuple,
                l.classid,
                l.granted,
                a.query
              FROM pg_locks l
              JOIN pg_stat_activity a ON l.pid = a.pid
              WHERE NOT l.granted;
            "
            ;;
          size)
            echo "数据库大小:"
            sudo -u postgres psql -c "
              SELECT 
                datname,
                pg_size_pretty(pg_database_size(datname)) as size
              FROM pg_database
              WHERE datname NOT IN ('template0', 'template1', 'postgres')
              ORDER BY pg_database_size(datname) DESC;
            "
            ;;
          *)
            echo "Usage: postgres-monitor {stats|slow-queries|connections|locks|size}"
            exit 1
            ;;
        esac
      '')
    ];

    # PostgreSQL 性能监控定时任务
    systemd.services.postgresql-stats-collector = {
      description = "PostgreSQL 性能统计收集";
      
      serviceConfig = {
        Type = "oneshot";
        User = "postgres";
      };
      
      script = ''
        LOG_FILE="/var/log/postgresql/performance.log"
        mkdir -p "$(dirname "$LOG_FILE")"
        
        echo "=== PostgreSQL Performance Report - $(date) ===" >> "$LOG_FILE"
        
        # 数据库大小
        echo "Database Sizes:" >> "$LOG_FILE"
        psql -c "
          SELECT datname, pg_size_pretty(pg_database_size(datname)) as size
          FROM pg_database 
          WHERE datname NOT IN ('template0', 'template1', 'postgres')
        " >> "$LOG_FILE"
        
        # 连接数
        echo "Connection Count:" >> "$LOG_FILE"
        psql -c "SELECT count(*) as active_connections FROM pg_stat_activity WHERE state = 'active'" >> "$LOG_FILE"
        
        echo "" >> "$LOG_FILE"
      '';
    };

    # 性能统计收集计时器
    systemd.timers.postgresql-stats-collector = {
      description = "PostgreSQL 性能统计收集计时器";
      wantedBy = [ "timers.target" ];
      
      timerConfig = {
        OnCalendar = "hourly";
        Persistent = true;
      };
    };

    # 日志目录
    systemd.tmpfiles.rules = [
      "d /var/log/postgresql 0755 postgres postgres -"
    ];
  };
}
