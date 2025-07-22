{ config, lib, pkgs, ... }:
let
    cfg = config.mySystem.services.network.proxy.v2raya;
in
{
    config = lib.mkIf cfg.enable {
        services.v2raya = {
            enable = true;
            cliPackage = cfg.cliPackage;
            package = cfg.package;
        };

        # 开启必要的防火墙端口
        networking.firewall = {
            allowedTCPPorts = [ 2017 ]; # v2raya Web 界面端口
        };

        # 添加用户到 v2raya 组
        users.groups.v2raya = {};
    };
}
