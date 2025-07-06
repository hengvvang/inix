{ config, lib, pkgs, ... }:

{
  # 基础网络工具实现
  config = lib.mkMerge [
    # 经典网络工具
    (lib.mkIf (config.mySystem.services.network.tools.enable && config.mySystem.services.network.tools.basic.classic) {
      environment.systemPackages = with pkgs; [
        # 下载工具
        wget
        curl
        
        # DNS 工具
        dig
        nslookup
        
        # 网络连接
        netcat-gnu
        telnet
        
        # 路由追踪
        traceroute
        mtr
        
        # 查询工具
        whois
        
        # 文件传输
        rsync
        scp
      ];
    })
    
    # 现代网络工具
    (lib.mkIf (config.mySystem.services.network.tools.enable && config.mySystem.services.network.tools.basic.modern) {
      environment.systemPackages = with pkgs; [
        # 现代 HTTP 客户端
        httpie
        xh        # 更快的 HTTPie 替代
        
        # 现代 DNS 工具
        dog       # 现代 dig
        
        # 现代网络监控
        bandwhich # 网络带宽监控
        bottom    # 系统监控 (包含网络)
        
        # 现代文件传输
        croc      # 文件传输
      ];
    })
    
    # 网络安全工具
    (lib.mkIf (config.mySystem.services.network.tools.enable && config.mySystem.services.network.tools.basic.security) {
      environment.systemPackages = with pkgs; [
        # 端口扫描
        nmap
        masscan
        
        # 网络安全分析
        ngrep
        
        # SSL/TLS 工具
        openssl
        gnutls
      ];
    })
  ];
}
