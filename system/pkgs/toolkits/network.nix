{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.pkgs.toolkits.network.enable {
    environment.systemPackages = with pkgs; [
      # 基础网络工具
      wget            # 文件下载
      curl            # HTTP 客户端
      httpie          # 现代 curl
      xh              # 更快的 HTTP 客户端
      
      # 网络诊断
      gping           # 现代 ping
      dog             # 现代 dig (DNS 查询)
      nmap            # 网络扫描
      tcpdump         # 网络包分析
      
      # 网络性能
      iperf3          # 网络性能测试
      bandwhich       # 网络带宽监控
    ];
  };
}
