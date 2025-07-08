{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.proxy.enable && config.myHome.dotfiles.proxy.method == "homemanager" && config.myHome.dotfiles.proxy.clash.enable) {
    home.file.".config/clash/config.yaml".text = ''
      # Clash 配置 - Home Manager 方式
      
      # 基础端口配置
      port: 7890
      socks-port: 7891
      allow-lan: false
      mode: rule
      log-level: info
      external-controller: 127.0.0.1:9090
      
      # DNS 配置
      dns:
        enable: true
        ipv6: false
        default-nameserver:
          - 114.114.114.114
          - 8.8.8.8
        nameserver:
          - https://doh.pub/dns-query
          - https://dns.alidns.com/dns-query
      
      # 代理组
      proxy-groups:
        - name: "PROXY"
          type: select
          proxies:
            - DIRECT
      
      # 规则
      rules:
        - DOMAIN-SUFFIX,cn,DIRECT
        - GEOIP,CN,DIRECT
        - MATCH,PROXY
    '';
    
    # 安装相关工具
    home.packages = with pkgs; [
      yq-go  # YAML 处理工具
    ];
  };
}
