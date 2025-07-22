{ config, lib, pkgs, ... }:
let
    cfg = config.mySystem.services.network.proxy.xray;
in
{
    config = lib.mkIf cfg.enable {
        services.xray = {
            enable = true;
            package = cfg.package;
            settings = lib.mkIf (cfg.settings != null) cfg.settings;
            settingsFile = lib.mkIf (cfg.settingsFile != null) cfg.settingsFile;
        };

        # 开启必要的防火墙端口
        networking.firewall = {
            allowedTCPPorts = [ 
                1080  # SOCKS5 端口
                8080  # HTTP 端口
            ];
        };

        # 添加用户到 xray 组
        users.groups.xray = {};
    };
}
