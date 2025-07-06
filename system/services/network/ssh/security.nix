{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.network.ssh;
in
{
  # SSH 安全加固实现
  config = lib.mkMerge [
    # SSH 安全加固
    (lib.mkIf (cfg.enable && cfg.server.enable && cfg.security.hardening) {
      services.openssh.settings = {
        # 强化加密算法
        Ciphers = [
          "chacha20-poly1305@openssh.com"
          "aes256-gcm@openssh.com"
          "aes128-gcm@openssh.com"
        ];
        
        # 强化MAC算法
        Macs = [
          "hmac-sha2-256-etm@openssh.com"
          "hmac-sha2-512-etm@openssh.com"
        ];
        
        # 强化密钥交换算法
        KexAlgorithms = [
          "curve25519-sha256"
          "curve25519-sha256@libssh.org"
          "diffie-hellman-group16-sha512"
        ];
        
        # 连接限制
        MaxAuthTries = 3;
        MaxSessions = 5;
        LoginGraceTime = 60;
        
        # 禁用不安全功能
        PermitUserEnvironment = false;
        StrictModes = true;
      };
    })
    
    # Fail2Ban 暴力破解防护
    (lib.mkIf (cfg.enable && cfg.security.fail2ban) {
      services.fail2ban = {
        enable = true;
        jails = {
          sshd = ''
            enabled = true
            port = ${toString cfg.server.port}
            filter = sshd
            logpath = /var/log/auth.log
            maxretry = 3
            bantime = 3600
            findtime = 600
          '';
        };
      };
      
      # Fail2Ban 需要的工具
      environment.systemPackages = with pkgs; [
        fail2ban
      ];
    })
  ];
}
