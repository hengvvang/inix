{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.network.ssh;
in
{
  # SSH 客户端实现
  config = lib.mkIf (cfg.enable && cfg.client.enable) {
    # 基础客户端工具
    environment.systemPackages = with pkgs; [
      openssh
      ssh-copy-id    # 密钥复制工具
      ssh-keyscan    # 密钥扫描工具
      rsync          # 远程同步
    ] ++ lib.optionals cfg.client.mosh [
      mosh           # 移动Shell
    ];

    # SSH 客户端配置
    programs.ssh = {
      startAgent = cfg.features.agent;
      extraConfig = ''
        Host *
          ServerAliveInterval 60
          ServerAliveCountMax 3
          TCPKeepAlive yes
          
        # 安全优先算法
        Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com
        MACs hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com
        KexAlgorithms curve25519-sha256,curve25519-sha256@libssh.org
      '';
    };
  };
}
