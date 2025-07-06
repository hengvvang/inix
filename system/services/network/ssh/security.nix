{ config, lib, pkgs, ... }:

{
  # SSH 安全加固实现
  config = lib.mkMerge [
    # SSH 安全加固
    (lib.mkIf (config.mySystem.services.network.ssh.enable && config.mySystem.services.network.ssh.security.hardening) {
      services.openssh.settings = {
        # 加密算法限制
        Ciphers = [
          "chacha20-poly1305@openssh.com"
          "aes256-gcm@openssh.com"
          "aes128-gcm@openssh.com"
          "aes256-ctr"
        ];
        
        # MAC 算法限制
        Macs = [
          "hmac-sha2-256-etm@openssh.com"
          "hmac-sha2-512-etm@openssh.com"
          "umac-128-etm@openssh.com"
        ];
        
        # 密钥交换算法限制
        KexAlgorithms = [
          "curve25519-sha256"
          "curve25519-sha256@libssh.org"
          "diffie-hellman-group16-sha512"
          "diffie-hellman-group18-sha512"
        ];
        
        # 协议版本限制
        Protocol = 2;
        
        # 连接限制
        MaxAuthTries = 3;
        MaxSessions = 5;
        LoginGraceTime = 60;
        
        # 禁用危险功能
        GatewayPorts = "no";
        PermitTunnel = "no";
        PermitUserEnvironment = "no";
        StrictModes = "yes";
      };
    })
    
    # Fail2Ban 暴力破解防护
    (lib.mkIf (config.mySystem.services.network.ssh.enable && config.mySystem.services.network.ssh.security.failBan) {
      services.fail2ban = {
        enable = true;
        jails = {
          ssh = ''
            enabled = true
            port = ssh
            filter = sshd
            logpath = /var/log/auth.log
            maxretry = 3
            bantime = 3600
          '';
        };
      };
    })
    
    # 端口敲门保护 (简化版配置)
    (lib.mkIf (config.mySystem.services.network.ssh.enable && config.mySystem.services.network.ssh.security.portKnocking) {
      # 这里可以配置 knockd 或类似工具
      environment.systemPackages = with pkgs; [
        knockd
      ];
    })
  ];
}
