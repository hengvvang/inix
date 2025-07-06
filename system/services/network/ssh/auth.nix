{ config, lib, pkgs, ... }:

{
  # SSH 认证功能实现
  config = lib.mkMerge [
    # 密钥认证增强
    (lib.mkIf (config.mySystem.services.network.ssh.enable && config.mySystem.services.network.ssh.auth.keyAuth) {
      services.openssh.settings = {
        AuthorizedKeysFile = "/home/%u/.ssh/authorized_keys";
        ChallengeResponseAuthentication = false;
        PubkeyAcceptedKeyTypes = [
          "ssh-ed25519"
          "ssh-ed25519-cert-v01@openssh.com" 
          "sk-ssh-ed25519@openssh.com"
          "rsa-sha2-256"
          "rsa-sha2-512"
        ];
      };
      
      # 密钥管理工具
      environment.systemPackages = with pkgs; [
        ssh-copy-id
        ssh-audit
        ssh-keyscan
      ];
    })
    
    # 多因素认证支持
    (lib.mkIf (config.mySystem.services.network.ssh.enable && config.mySystem.services.network.ssh.auth.mfa) {
      # 需要 Google Authenticator PAM 模块
      security.pam.services.sshd.googleAuthenticator.enable = true;
      
      environment.systemPackages = with pkgs; [
        google-authenticator
      ];
      
      services.openssh.settings = {
        AuthenticationMethods = "publickey,keyboard-interactive";
        KbdInteractiveAuthentication = true;
      };
    })
  ];
}
