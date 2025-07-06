{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.network.ssh.enable {
    # SSH 服务配置
    services.openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = config.mySystem.services.network.ssh.passwordAuth;
        # 安全配置
        X11Forwarding = false;
        PermitEmptyPasswords = false;
        UsePAM = true;
      };
    };

    # 开放 SSH 端口
    networking.firewall.allowedTCPPorts = [ 22 ];

    # 确保 SSH 包可用
    environment.systemPackages = with pkgs; [
      openssh
    ];
  };
}
