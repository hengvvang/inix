{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.samba.enable {
    # Samba 文件共享服务配置
    services.samba = {
      enable = true;
      openFirewall = true;
      
      # 全局配置
      settings = {
        global = {
          workgroup = "WORKGROUP";
          "server string" = "NixOS Samba Server";
          "netbios name" = "nixos";
          security = "user";
          "hosts allow" = "192.168.0. 127.0.0.1 localhost";
          "hosts deny" = "0.0.0.0/0";
          "guest account" = "nobody";
          "map to guest" = "bad user";
        };
        
        # 共享目录配置
        public = {
          path = "/var/lib/samba/public";
          browseable = "yes";
          "read only" = "no";
          "guest ok" = "yes";
          "create mask" = "0644";
          "directory mask" = "0755";
          "force user" = "samba";
          "force group" = "samba";
        };
        
        homes = {
          browseable = "no";
          "read only" = "no";
          "create mask" = "0644";
          "directory mask" = "0755";
        };
      };
    };

    # 创建 samba 用户和组
    users.users.samba = {
      isSystemUser = true;
      group = "samba";
      home = "/var/lib/samba";
      createHome = true;
    };
    
    users.groups.samba = {};

    # 确保共享目录存在
    systemd.tmpfiles.rules = [
      "d /var/lib/samba/public 0755 samba samba -"
    ];
  };
}
