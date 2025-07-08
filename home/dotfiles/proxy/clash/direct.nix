{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.proxy.enable && config.myHome.dotfiles.proxy.method == "direct" && config.myHome.dotfiles.proxy.clash.enable) {
    # 方式2: 直接文件写入（演示用）
    # 特点：直接写入配置文件，灵活但需要手动维护
    
    # 基础配置文件
    home.file.".config/clash/config.yaml".text = ''
      # Clash 基础配置
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
    
    # 简单管理脚本
    home.file.".config/clash/manage.sh" = {
      text = ''
        #!/usr/bin/env bash
        
        case "$1" in
          start)
            systemctl --user start clash
            echo "Clash 已启动"
            ;;
          stop)
            systemctl --user stop clash
            echo "Clash 已停止"
            ;;
          restart)
            systemctl --user restart clash
            echo "Clash 已重启"
            ;;
          status)
            systemctl --user status clash
            ;;
          *)
            echo "用法: $0 {start|stop|restart|status}"
            ;;
        esac
      '';
      executable = true;
    };
  };
}
