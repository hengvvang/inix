{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.toolkits.system.network.enable {
    home.packages = with pkgs; [
    wget               # 文件下载
    curl               # HTTP 客户端
    nmap               # 网络扫描
    iperf3             # 网络性能测试
    tcpdump            # 网络包分析
    dog                # 现代 dig (DNS 查询)
    bandwhich          # 网络使用监控
    ];
  };
}
