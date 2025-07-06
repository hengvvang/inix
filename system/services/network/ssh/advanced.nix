{ config, lib, pkgs, ... }:

{
  # SSH 高级功能实现
  config = lib.mkMerge [
    # SSH 隧道功能
    (lib.mkIf (config.mySystem.services.network.ssh.enable && config.mySystem.services.network.ssh.advanced.tunneling) {
      services.openssh.settings = {
        PermitTunnel = "yes";
        GatewayPorts = "clientspecified";
      };
      
      environment.systemPackages = with pkgs; [
        autossh  # 自动重连SSH隧道
        sshuttle # VPN over SSH
      ];
    })
    
    # X11 转发功能
    (lib.mkIf (config.mySystem.services.network.ssh.enable && config.mySystem.services.network.ssh.advanced.x11Forwarding) {
      services.openssh.settings = {
        X11Forwarding = true;
        X11DisplayOffset = 10;
        X11UseLocalhost = true;
      };
      
      environment.systemPackages = with pkgs; [
        xorg.xauth
      ];
    })
    
    # SSH 代理功能
    (lib.mkIf (config.mySystem.services.network.ssh.enable && config.mySystem.services.network.ssh.advanced.agent) {
      services.openssh.settings = {
        AllowAgentForwarding = true;
      };
      
      # SSH 代理相关工具
      environment.systemPackages = with pkgs; [
        keychain  # SSH 密钥管理
        ssh-agents
      ];
      
      programs.ssh.startAgent = true;
    })
  ];
}
