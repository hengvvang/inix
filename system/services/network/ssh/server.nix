{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.network.ssh;
in
{
  # SSH 服务端实现
  config = lib.mkIf (cfg.enable && cfg.server.enable) {
    # 启用 OpenSSH 服务
    services.openssh = {
      enable = true;
      ports = [ cfg.server.port ];
      settings = {
        # 基础安全配置
        PermitRootLogin = "no";
        PermitEmptyPasswords = false;
        UsePAM = true;
        
        # 认证配置
        PasswordAuthentication = cfg.server.passwordAuth;
        PubkeyAuthentication = true;
        AuthorizedKeysFile = "/home/%u/.ssh/authorized_keys";
        
        # 高级功能控制
        X11Forwarding = cfg.features.x11Forwarding;
        AllowAgentForwarding = cfg.features.agent;
        AllowTcpForwarding = if cfg.features.tunneling then "yes" else "no";
        
        # 基础安全算法（详细安全配置在 security.nix）
        PubkeyAcceptedKeyTypes = [
          "ssh-ed25519"
          "rsa-sha2-256"
          "rsa-sha2-512"
        ];
      };
    };

    # 开放 SSH 端口
    networking.firewall.allowedTCPPorts = [ cfg.server.port ];

    # 服务端工具
    environment.systemPackages = with pkgs; [
      openssh
      ssh-audit      # SSH 配置审计
    ];
  };
}
