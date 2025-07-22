{ config, lib, pkgs, ... }:
let
    cfg = config.mySystem.services.network.proxy.shadowsocks;
in
{
    config = lib.mkIf cfg.enable {
        services.shadowsocks = {
            enable = true;
            mode = cfg.mode;
            localAddress = cfg.localAddress;
            port = cfg.port;
            password = lib.mkIf (cfg.password != null) cfg.password;
            passwordFile = lib.mkIf (cfg.passwordFile != null) cfg.passwordFile;
            encryptionMethod = cfg.encryptionMethod;
            plugin = lib.mkIf (cfg.plugin != null) cfg.plugin;
            pluginOpts = lib.mkIf (cfg.pluginOpts != null) cfg.pluginOpts;
            fastOpen = cfg.fastOpen;
            extraConfig = cfg.extraConfig;
        };

        # 开启必要的防火墙端口
        networking.firewall = {
            allowedTCPPorts = [ cfg.port ];
            allowedUDPPorts = lib.mkIf (cfg.mode != "tcp_only") [ cfg.port ];
        };

        # 添加用户到 shadowsocks 组  
        users.groups.shadowsocks = {};
    };
}
