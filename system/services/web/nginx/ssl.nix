{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.services.web.nginx.enable && config.mySystem.services.web.nginx.ssl.enable) {
    # 占位文件 - SSL 配置功能
    # 这里可以添加 SSL/TLS 相关配置
    services.nginx.virtualHosts."localhost".locations."/ssl-status" = {
      extraConfig = ''
        return 200 "SSL module available but not configured";
        add_header Content-Type text/plain;
      '';
    };
  };
}
