{ config, lib, pkgs, ... }:

{
  # Syncthing 文件夹同步配置实现
  config = lib.mkIf config.mySystem.services.sync.syncthing.enable {
    # 示例文件夹配置 (用户需要自定义)
    services.syncthing.settings.folders = {
      # 示例文件夹
      # "Documents" = {
      #   path = "/home/user/Documents";
      #   devices = [ "device1" "device2" ];
      # };
    };
    
    # 示例设备配置 (用户需要自定义)
    services.syncthing.settings.devices = {
      # 示例设备
      # "device1" = {
      #   id = "设备ID";
      #   addresses = [ "tcp://192.168.1.100:22000" ];
      # };
    };
    
    # 文件夹管理脚本
    environment.systemPackages = [
      (pkgs.writeShellScriptBin "syncthing-add-folder" ''
        #!/bin/bash
        if [ $# -lt 2 ]; then
          echo "用法: syncthing-add-folder <文件夹ID> <路径> [设备ID...]"
          exit 1
        fi
        
        FOLDER_ID="$1"
        FOLDER_PATH="$2"
        shift 2
        
        echo "添加同步文件夹: $FOLDER_ID -> $FOLDER_PATH"
        echo "设备: $@"
        echo "请手动编辑 NixOS 配置文件添加此文件夹"
      '')
      
      (pkgs.writeShellScriptBin "syncthing-status" ''
        #!/bin/bash
        echo "Syncthing 状态:"
        systemctl status syncthing
        echo
        echo "同步状态:"
        ${pkgs.syncthing}/bin/syncthing cli show system
      '')
    ];
    
    # 预创建常用目录
    systemd.tmpfiles.rules = [
      "d /var/lib/syncthing 0755 syncthing syncthing -"
      "d /var/lib/syncthing/.config 0755 syncthing syncthing -"
      "d /var/lib/syncthing/.config/syncthing 0755 syncthing syncthing -"
    ];
  };
}
