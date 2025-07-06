{ config, lib, pkgs, ... }:

{
  # 基础 SSH 服务实现
  config = lib.mkIf config.mySystem.services.network.ssh.enable {
    # 启用 OpenSSH 服务
    services.openssh = {
      enable = true;
      settings = {
        # 基础安全配置
        PermitRootLogin = "no";
        PermitEmptyPasswords = false;
        UsePAM = true;
        
        # 认证方式（在 auth.nix 中进一步配置）
        PasswordAuthentication = config.mySystem.services.network.ssh.auth.passwordAuth;
        PubkeyAuthentication = true;
        
        # 禁用不安全的功能
        X11Forwarding = config.mySystem.services.network.ssh.advanced.x11Forwarding;
        AllowAgentForwarding = config.mySystem.services.network.ssh.advanced.agent;
        AllowTcpForwarding = if config.mySystem.services.network.ssh.advanced.portForwarding then "yes" else "no";
      };
    };

    # 开放 SSH 端口
    networking.firewall.allowedTCPPorts = [ 22 ];

    # 基础 SSH 工具包
    environment.systemPackages = with pkgs; [
      openssh
    ];
    
    # 基础用户配置
    users.users.root.openssh.authorizedKeys.keys = [];
  };
}
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
