{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.services.web.nginx.enable && config.mySystem.services.web.nginx.cache.enable) {
    # 占位文件 - 缓存配置功能
    # 这里可以添加 Nginx 缓存相关配置
    services.nginx.virtualHosts."localhost".locations."/cache-status" = {
      extraConfig = ''
        return 200 "Cache module available but not configured";
        add_header Content-Type text/plain;
      '';
    };
  };
}
