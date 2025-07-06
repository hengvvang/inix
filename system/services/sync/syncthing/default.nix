{ config, lib, pkgs, ... }:

{
  # Syncthing 文件同步模块的选项定义
  options.mySystem.services.sync.syncthing = {
    enable = lib.mkEnableOption "Syncthing 文件同步基础支持";
    
    # === 服务配置选项 ===
    service = {
      openFirewall = lib.mkEnableOption "自动打开防火墙端口" // { default = true; };
      user = lib.mkOption {
        type = lib.types.str;
        default = "syncthing";
        description = "运行 Syncthing 的用户";
      };
      dataDir = lib.mkOption {
        type = lib.types.path;
        default = "/var/lib/syncthing";
        description = "Syncthing 数据目录";
      };
    };
    
    # === 网络配置选项 ===
    network = {
      gui = {
        enable = lib.mkEnableOption "Web GUI 界面" // { default = true; };
        port = lib.mkOption {
          type = lib.types.port;
          default = 8384;
          description = "Web GUI 端口";
        };
        address = lib.mkOption {
          type = lib.types.str;
          default = "127.0.0.1";
          description = "Web GUI 绑定地址";
        };
      };
      listen = {
        tcp = lib.mkOption {
          type = lib.types.port;
          default = 22000;
          description = "TCP 监听端口";
        };
        udp = lib.mkOption {
          type = lib.types.port;
          default = 21027;
          description = "UDP 发现端口";
        };
      };
    };
    
    # === 同步配置选项 ===
    sync = {
      relaysEnabled = lib.mkEnableOption "启用中继服务器" // { default = true; };
      localAnnounceEnabled = lib.mkEnableOption "本地发现" // { default = true; };
      globalAnnounceEnabled = lib.mkEnableOption "全局发现" // { default = true; };
      natEnabled = lib.mkEnableOption "NAT 穿透" // { default = true; };
    };
    
    # === 安全选项 ===
    security = {
      insecureAdminAccess = lib.mkEnableOption "允许不安全的管理访问";
      apiKey = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "API 密钥";
      };
    };
  };

  imports = [
    # === 模块化导入：每个功能独立文件 ===
    ./service.nix     # 服务配置
    ./network.nix     # 网络配置
    ./folders.nix     # 文件夹同步配置
    ./security.nix    # 安全配置
  ];
}
