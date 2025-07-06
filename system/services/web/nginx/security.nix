{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.services.web.nginx.enable && config.mySystem.services.web.nginx.security.enable) {
    # 占位文件 - 安全配置功能
    # 这里可以添加 Nginx 安全增强配置
    services.nginx.virtualHosts."localhost".locations."/security-status" = {
      extraConfig = ''
        return 200 "Security module available but not configured";
        add_header Content-Type text/plain;
      '';
    };
  };
}
