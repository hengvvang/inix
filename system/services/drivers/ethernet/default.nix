{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.drivers.ethernet.enable {
    # 以太网配置
    networking.useDHCP = false;
    networking.interfaces = {
      # 自动配置以太网接口
      # 具体接口名称需要根据实际硬件调整
    };
    
    # 以太网工具
    environment.systemPackages = with pkgs; [
      ethtool
      iperf3
      tcpdump
    ];
    
    # 网络优化
    boot.kernel.sysctl = {
      "net.core.rmem_max" = 134217728;
      "net.core.wmem_max" = 134217728;
      "net.ipv4.tcp_rmem" = "4096 65536 134217728";
      "net.ipv4.tcp_wmem" = "4096 65536 134217728";
    };
  };
}
