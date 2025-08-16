{ config, lib, pkgs, ... }:
let
    cfg = config.mySystem.services.network.proxy.v2ray;
in
{
    config = lib.mkIf cfg.enable {
        services.v2ray = {
            enable = true;
            package = pkgs.v2ray;
            config = lib.mkIf (cfg.config != null) cfg.config;
            configFile = lib.mkIf (cfg.configFile != null) cfg.configFile;
        };

        # 开启必要的防火墙端口
        networking.firewall = {
            allowedTCPPorts = [
                1080  # SOCKS5 端口
                8080  # HTTP 端口
            ];
        };

        # 添加用户到 v2ray 组
        users.groups.v2ray = {};
    };
}
