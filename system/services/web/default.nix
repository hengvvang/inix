{ config, lib, pkgs, ... }:

{
  options.mySystem.services.web = {
    nginx = {
      enable = lib.mkEnableOption "Nginx Web 服务器";
      ssl.enable = lib.mkEnableOption "Nginx SSL/TLS 支持";
      cache.enable = lib.mkEnableOption "Nginx 缓存配置";
      security.enable = lib.mkEnableOption "Nginx 安全增强";
    };
  };

  imports = [
    ./nginx
  ];
}
