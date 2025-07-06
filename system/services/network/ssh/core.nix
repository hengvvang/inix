{ config, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    # 基础 SSH 服务
    (lib.mkIf config.mySystem.services.network.ssh.enable {
      services.openssh = {
        enable = true;
        settings = {
          PermitRootLogin = "no";
          PasswordAuthentication = config.mySystem.services.network.ssh.passwordAuth;
          X11Forwarding = false;
          PermitEmptyPasswords = false;
          UsePAM = true;
        };
      };

      # 开放 SSH 端口
      networking.firewall.allowedTCPPorts = [ 22 ];

      # 基础工具包
      environment.systemPackages = with pkgs; [
        openssh
      ];
    })

    # 密钥认证增强
    (lib.mkIf (config.mySystem.services.network.ssh.enable && config.mySystem.services.network.ssh.keyAuth) {
      services.openssh.settings = {
        PubkeyAuthentication = true;
        AuthorizedKeysFile = "/home/%u/.ssh/authorized_keys";
        ChallengeResponseAuthentication = false;
      };
      
      # 密钥管理工具
      environment.systemPackages = with pkgs; [
        ssh-copy-id
        ssh-audit  # SSH 配置审计
      ];
    })

    # SSH 安全加固
    (lib.mkIf (config.mySystem.services.network.ssh.enable && config.mySystem.services.network.ssh.hardening) {
      services.openssh.settings = {
        # 加密算法限制
        Ciphers = [
          "chacha20-poly1305@openssh.com"
          "aes256-gcm@openssh.com"
          "aes128-gcm@openssh.com"
          "aes256-ctr"
          "aes192-ctr"
          "aes128-ctr"
        ];
        
        # MAC 算法限制
        Macs = [
          "hmac-sha2-256-etm@openssh.com"
          "hmac-sha2-512-etm@openssh.com"
          "hmac-sha2-256"
          "hmac-sha2-512"
        ];
        
        # 密钥交换算法
        KexAlgorithms = [
          "curve25519-sha256"
          "curve25519-sha256@libssh.org"
          "diffie-hellman-group16-sha512"
          "diffie-hellman-group18-sha512"
        ];
        
        # 安全设置
        ClientAliveInterval = 300;
        ClientAliveCountMax = 2;
        MaxAuthTries = 3;
        MaxSessions = 2;
        TCPKeepAlive = false;
        UseDNS = false;
        AllowAgentForwarding = false;
        AllowTcpForwarding = false;
        GatewayPorts = false;
      };
      
      # 额外安全工具
      environment.systemPackages = with pkgs; [
        fail2ban  # 防暴力破解
      ];
      
      # 启用 fail2ban
      services.fail2ban = {
        enable = true;
        jails = {
          ssh = ''
            enabled = true
            port = 22
            filter = sshd
            logpath = /var/log/auth.log
            maxretry = 3
            bantime = 3600
          '';
        };
      };
    })
  ];
}
