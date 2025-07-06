{ config, lib, pkgs, ... }:

{
  # Tailscale 安全功能实现
  config = lib.mkIf config.mySystem.services.network.tailscale.enable {
    services.tailscale = {
      # 自定义登录服务器
      loginServer = config.mySystem.services.network.tailscale.advanced.loginServer;
      
      # 密钥过期配置
      extraUpFlags = [
        "--timeout=${config.mySystem.services.network.tailscale.security.keyExpiry}"
      ] ++ lib.optionals config.mySystem.services.network.tailscale.security.acceptRoutes [
        "--accept-routes"
      ] ++ lib.optionals config.mySystem.services.network.tailscale.security.acceptDNS [
        "--accept-dns"
      ];
    };
    
    # 安全加固
    systemd.services.tailscaled = {
      # 服务安全限制
      serviceConfig = {
        # 限制文件系统访问
        ProtectSystem = "strict";
        ProtectHome = true;
        PrivateTmp = true;
        
        # 限制网络能力
        RestrictAddressFamilies = [ "AF_UNIX" "AF_INET" "AF_INET6" "AF_NETLINK" ];
        
        # 限制特权
        NoNewPrivileges = true;
        
        # 资源限制
        MemoryDenyWriteExecute = false;  # Tailscale 需要 JIT
      };
    };
    
    # 监控和审计
    environment.systemPackages = with pkgs; [
      tailscale
      # 网络监控工具
      netstat-nat
      ss
    ];
  };
}
