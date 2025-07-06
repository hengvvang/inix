{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.web.nginx.enable {
    # Nginx 核心配置
    services.nginx = {
      enable = true;
      
      # 基础优化配置
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      
      # 性能配置
      eventsConfig = ''
        worker_connections 1024;
        use epoll;
      '';
      
      httpConfig = ''
        # 基础性能配置
        sendfile on;
        tcp_nopush on;
        tcp_nodelay on;
        keepalive_timeout 65;
        types_hash_max_size 2048;
        
        # 文件上传限制
        client_max_body_size 100M;
        
        # 缓冲区配置
        client_body_buffer_size 128k;
        client_header_buffer_size 1k;
        large_client_header_buffers 4 4k;
        output_buffers 1 32k;
        postpone_output 1460;
        
        # 日志格式
        log_format main '$remote_addr - $remote_user [$time_local] "$request" '
                        '$status $body_bytes_sent "$http_referer" '
                        '"$http_user_agent" "$http_x_forwarded_for"';
        
        access_log /var/log/nginx/access.log main;
        error_log /var/log/nginx/error.log warn;
        
        # MIME 类型
        include ${pkgs.nginx}/conf/mime.types;
        default_type application/octet-stream;
      '';
      
      # 默认虚拟主机
      virtualHosts = {
        "localhost" = {
          locations."/" = {
            root = "/var/www/html";
            index = "index.html index.htm";
          };
          
          # 状态页面
          locations."/nginx_status" = {
            extraConfig = ''
              stub_status on;
              access_log off;
              allow 127.0.0.1;
              deny all;
            '';
          };
        };
        
        "_" = {
          default = true;
          locations."/" = {
            return = "444";
          };
        };
      };
    };

    # 创建网站根目录
    systemd.tmpfiles.rules = [
      "d /var/www 0755 nginx nginx -"
      "d /var/www/html 0755 nginx nginx -"
      "d /var/log/nginx 0755 nginx nginx -"
    ];

    # 默认首页
    environment.etc."nginx/html/index.html".text = ''
      <!DOCTYPE html>
      <html>
      <head>
          <title>NixOS Nginx Server</title>
          <style>
              body { font-family: Arial, sans-serif; margin: 40px; }
              .container { max-width: 800px; margin: 0 auto; }
              h1 { color: #333; }
              .status { background: #f0f0f0; padding: 10px; border-radius: 5px; }
          </style>
      </head>
      <body>
          <div class="container">
              <h1>Welcome to NixOS Nginx Server</h1>
              <p>If you can see this page, the Nginx web server is successfully installed and working.</p>
              <div class="status">
                  <strong>Server Status:</strong> Running<br>
                  <strong>Configuration:</strong> NixOS + Flakes<br>
                  <strong>Time:</strong> <script>document.write(new Date().toLocaleString());</script>
              </div>
              <p>For online documentation and support please refer to <a href="https://nginx.org/">nginx.org</a>.</p>
          </div>
      </body>
      </html>
    '';

    # 防火墙配置
    networking.firewall.allowedTCPPorts = [ 80 443 ];

    # Nginx 管理工具
    environment.systemPackages = with pkgs; [
      nginx
      (writeShellScriptBin "nginx-manager" ''
        #!/bin/bash
        
        case "$1" in
          reload)
            echo "重新加载 Nginx 配置..."
            systemctl reload nginx
            ;;
          test)
            echo "测试 Nginx 配置..."
            nginx -t
            ;;
          status)
            echo "Nginx 服务状态:"
            systemctl status nginx
            ;;
          logs)
            echo "Nginx 访问日志:"
            tail -f /var/log/nginx/access.log
            ;;
          error-logs)
            echo "Nginx 错误日志:"
            tail -f /var/log/nginx/error.log
            ;;
          stats)
            echo "Nginx 统计信息:"
            curl -s http://localhost/nginx_status
            ;;
          *)
            echo "Usage: nginx-manager {reload|test|status|logs|error-logs|stats}"
            exit 1
            ;;
        esac
      '')
    ];
  };
}
