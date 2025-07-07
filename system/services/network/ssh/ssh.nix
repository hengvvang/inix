{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.network.ssh;
in
{
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
