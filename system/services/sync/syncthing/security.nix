{ config, lib, pkgs, ... }:

{
  # Syncthing 安全配置实现
  config = lib.mkIf config.mySystem.services.sync.syncthing.enable {
    # 服务安全加固
    systemd.services.syncthing = {
      serviceConfig = {
        # 限制文件系统访问
        ProtectSystem = "strict";
        ProtectHome = true;
        PrivateTmp = true;
        PrivateDevices = true;
        
        # 限制网络
        RestrictAddressFamilies = [ "AF_UNIX" "AF_INET" "AF_INET6" ];
        
        # 限制权限
        NoNewPrivileges = true;
        
        # 资源限制
        MemoryDenyWriteExecute = false;  # Syncthing 需要
        
        # 可写目录
        ReadWritePaths = [
          config.mySystem.services.sync.syncthing.service.dataDir
          "/tmp"
        ];
      };
    };
    
    # 日志配置
    services.syncthing.settings.options = {
      # 审计日志
      auditEnabled = true;
      
      # 详细日志
      verboseReceive = false;  # 可根据需要启用
    };
    
    # 备份脚本
    environment.systemPackages = [
      (pkgs.writeShellScriptBin "syncthing-backup-config" ''
        #!/bin/bash
        BACKUP_DIR="/var/backups/syncthing"
        CONFIG_DIR="${config.mySystem.services.sync.syncthing.service.dataDir}/.config/syncthing"
        
        mkdir -p "$BACKUP_DIR"
        
        echo "备份 Syncthing 配置..."
        tar -czf "$BACKUP_DIR/config-$(date +%Y%m%d-%H%M%S).tar.gz" \
          -C "$(dirname "$CONFIG_DIR")" \
          "$(basename "$CONFIG_DIR")"
        
        echo "备份完成: $BACKUP_DIR"
        
        # 保留最近 10 个备份
        ls -t "$BACKUP_DIR"/config-*.tar.gz | tail -n +11 | xargs -r rm
      '')
    ];
    
    # 定期配置备份
    systemd.timers.syncthing-backup = {
      description = "Syncthing 配置备份定时器";
      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
      };
    };
    
    systemd.services.syncthing-backup = {
      description = "Syncthing 配置备份服务";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash -c 'syncthing-backup-config'";
        User = "root";  # 需要访问备份目录
      };
    };
  };
}
