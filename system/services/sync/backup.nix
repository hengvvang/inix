{ config, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    # 基础备份工具
    (lib.mkIf config.mySystem.services.sync.backup.enable {
      environment.systemPackages = with pkgs; [
        rsync
        duplicity    # 加密备份
        borgbackup   # 去重备份
      ];
    })

    # Rsync 增量备份
    (lib.mkIf config.mySystem.services.sync.backup.rsync.enable {
      environment.systemPackages = with pkgs; [
        rsync
        grsync  # 图形界面
      ];
      
      # 创建备份脚本
      environment.systemPackages = [
        (pkgs.writeShellScriptBin "backup-home" ''
          #!/usr/bin/env bash
          
          # 配置
          SOURCE="/home/hengvvang/"
          DEST="/media/backup/$(date +%Y-%m-%d)"
          EXCLUDE_FILE="/etc/nixos/backup-exclude.txt"
          
          # 创建目标目录
          mkdir -p "$DEST"
          
          # 执行备份
          rsync -av --delete \
            --exclude-from="$EXCLUDE_FILE" \
            "$SOURCE" "$DEST"
          
          echo "Backup completed to $DEST"
        '')
      ];
      
      # 创建排除文件
      environment.etc."nixos/backup-exclude.txt".text = ''
        .cache/
        .local/share/Trash/
        .thumbnails/
        .npm/
        .docker/
        Downloads/
        .mozilla/firefox/*/Cache/
        .config/google-chrome/*/Cache/
      '';
      
      # 定时备份服务
      systemd.user.services.backup-home = {
        description = "Home Directory Backup";
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${pkgs.bash}/bin/bash -c 'backup-home'";
        };
      };
      
      systemd.user.timers.backup-home = {
        description = "Daily Home Backup";
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnCalendar = "daily";
          Persistent = true;
        };
      };
    })

    # Timeshift 系统快照
    (lib.mkIf config.mySystem.services.sync.backup.timeshift.enable {
      environment.systemPackages = with pkgs; [
        timeshift
      ];
      
      # Timeshift 配置目录
      systemd.tmpfiles.rules = [
        "d /etc/timeshift 0755 root root -"
      ];
      
      # 基础 Timeshift 配置
      environment.etc."timeshift/timeshift.json".text = builtins.toJSON {
        backup_device_uuid = "";
        parent_device_uuid = "";
        do_first_run = false;
        btrfs_mode = false;
        include_btrfs_home_for_backup = false;
        include_btrfs_home_for_restore = false;
        stop_cron_emails = true;
        schedule_monthly = true;
        schedule_weekly = true;
        schedule_daily = false;
        schedule_hourly = false;
        schedule_boot = false;
        count_monthly = 2;
        count_weekly = 3;
        count_daily = 5;
        count_hourly = 6;
        count_boot = 5;
        snapshot_size = 0;
        snapshot_count = 0;
      };
    })
  ];
}
