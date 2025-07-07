{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.network.ssh;
in
{
  # SSH 服务模块 - 简化版
  options.mySystem.services.network.ssh = {
    enable = lib.mkEnableOption "SSH 服务支持";
    
    # 服务端配置
    server = {
      enable = lib.mkEnableOption "SSH 服务端" // { default = true; };
      port = lib.mkOption {
        type = lib.types.int;
        default = 22;
        description = "SSH 服务端口";
      };
      passwordAuth = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "是否允许密码认证（建议使用密钥认证）";
      };
    };
    
    # 客户端工具
    client = {
      enable = lib.mkEnableOption "SSH 客户端工具" // { default = true; };
    };
  };

  # SSH 服务端实现
  config = lib.mkIf cfg.enable {
    # SSH 服务端
    services.openssh = lib.mkIf cfg.server.enable {
      enable = true;
      ports = [ cfg.server.port ];
      settings = {
        # 安全配置
        PermitRootLogin = "no";
        PermitEmptyPasswords = false;
        PasswordAuthentication = cfg.server.passwordAuth;
        PubkeyAuthentication = true;
        
        # 基础功能
        X11Forwarding = false;
        AllowAgentForwarding = true;
        AllowTcpForwarding = "yes";
      };
    };

    # 防火墙配置
    networking.firewall.allowedTCPPorts = lib.mkIf cfg.server.enable [ cfg.server.port ];

    # 客户端工具
    environment.systemPackages = lib.mkIf cfg.client.enable (with pkgs; [
      openssh
    ]);
  };
}
