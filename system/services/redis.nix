{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.redis.enable {
    # Redis 缓存服务配置
    services.redis.servers.main = {
      enable = true;
      port = 6379;
      
      # 性能和安全配置
      settings = {
        # 内存管理
        maxmemory = "256mb";
        maxmemory-policy = "allkeys-lru";
        
        # 持久化配置
        save = [ "900 1" "300 10" "60 10000" ];
        
        # 安全配置
        requirepass = ""; # 本地开发可以为空，生产环境应设置密码
        
        # 性能优化
        tcp-keepalive = 300;
        timeout = 0;
      };
    };

    # 防火墙配置（如果需要远程访问）
    # networking.firewall.allowedTCPPorts = [ 6379 ];
  };
}
