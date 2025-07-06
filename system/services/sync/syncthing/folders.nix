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
    
    # Syncthing CLI 工具
    environment.systemPackages = with pkgs; [
      syncthing
    ];
    
    # 预创建常用目录
    systemd.tmpfiles.rules = [
      "d /var/lib/syncthing 0755 syncthing syncthing -"
      "d /var/lib/syncthing/.config 0755 syncthing syncthing -"
      "d /var/lib/syncthing/.config/syncthing 0755 syncthing syncthing -"
    ];
  };
}
