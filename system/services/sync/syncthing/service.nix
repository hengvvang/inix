{ config, lib, pkgs, ... }:

{
  # Syncthing 服务配置实现
  config = lib.mkIf config.mySystem.services.sync.syncthing.enable {
    # 启用 Syncthing 服务
    services.syncthing = {
      enable = true;
      user = config.mySystem.services.sync.syncthing.service.user;
      dataDir = config.mySystem.services.sync.syncthing.service.dataDir;
      
      # 基础配置
      openDefaultPorts = config.mySystem.services.sync.syncthing.service.openFirewall;
      
      # GUI 配置
      guiAddress = "${config.mySystem.services.sync.syncthing.network.gui.address}:${toString config.mySystem.services.sync.syncthing.network.gui.port}";
      
      # 同步设置
      settings = {
        # 选项配置
        options = {
          relaysEnabled = config.mySystem.services.sync.syncthing.sync.relaysEnabled;
          localAnnounceEnabled = config.mySystem.services.sync.syncthing.sync.localAnnounceEnabled;
          globalAnnounceEnabled = config.mySystem.services.sync.syncthing.sync.globalAnnounceEnabled;
          natEnabled = config.mySystem.services.sync.syncthing.sync.natEnabled;
          
          # 监听地址
          listenAddresses = [
            "tcp://:${toString config.mySystem.services.sync.syncthing.network.listen.tcp}"
            "quic://:${toString config.mySystem.services.sync.syncthing.network.listen.tcp}"
          ];
        };
        
        # GUI 设置
        gui = {
          enabled = config.mySystem.services.sync.syncthing.network.gui.enable;
          address = config.mySystem.services.sync.syncthing.network.gui.address;
          port = config.mySystem.services.sync.syncthing.network.gui.port;
          insecureAdminAccess = config.mySystem.services.sync.syncthing.security.insecureAdminAccess;
        } // lib.optionalAttrs (config.mySystem.services.sync.syncthing.security.apiKey != null) {
          apikey = config.mySystem.services.sync.syncthing.security.apiKey;
        };
      };
    };
    
    # 创建 Syncthing 用户
    users.users.syncthing = lib.mkIf (config.mySystem.services.sync.syncthing.service.user == "syncthing") {
      description = "Syncthing service user";
      home = config.mySystem.services.sync.syncthing.service.dataDir;
      createHome = true;
      isSystemUser = true;
      group = "syncthing";
    };
    
    users.groups.syncthing = lib.mkIf (config.mySystem.services.sync.syncthing.service.user == "syncthing") {};
    
    # 基础工具包
    environment.systemPackages = with pkgs; [
      syncthing
      syncthing-cli  # 命令行工具
    ];
  };
}
