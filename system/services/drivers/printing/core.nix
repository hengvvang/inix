{ config, lib, pkgs, ... }:

{
  # 打印核心服务实现
  config = lib.mkMerge [
    # CUPS 打印服务
    (lib.mkIf (config.mySystem.services.drivers.printing.enable && config.mySystem.services.drivers.printing.service.cups) {
      services.printing = {
        enable = true;
        startWhenNeeded = true;
        webInterface = true;
        allowFrom = [ "localhost" "192.168.0.0/16" ];
        defaultShared = config.mySystem.services.drivers.printing.service.sharing;
      };
      
      # 基础工具
      environment.systemPackages = with pkgs; [
        cups
        cups-filters
      ];
    })
    
    # 网络打印机发现
    (lib.mkIf (config.mySystem.services.drivers.printing.enable && config.mySystem.services.drivers.printing.service.discovery) {
      services.avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
      
      # 网络发现工具
      environment.systemPackages = with pkgs; [
        avahi
        nss-mdns
      ];
    })
    
    # 打印机共享
    (lib.mkIf (config.mySystem.services.drivers.printing.enable && config.mySystem.services.drivers.printing.service.sharing) {
      services.printing = {
        browsing = true;
        listenAddresses = [ "*:631" ];
        extraConf = ''
          # 允许远程管理
          <Location />
            Order allow,deny
            Allow localhost
            Allow from 192.168.0.0/16
          </Location>
        '';
      };
      
      networking.firewall.allowedTCPPorts = [ 631 ];
    })
  ];
}
