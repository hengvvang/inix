{ config, lib, pkgs, ... }:
let
    cfg = config.mySystem.services.network.proxy.mihomo;
in
{
    config = lib.mkIf cfg.enable {
        services.mihomo = {
            enable = true;
            package = pkgs.mihomo;

            # Web UI 根据用户选择的枚举值映射到对应的包
            # 支持的选项：
            # - metacubexd: pkgs.metacubexd
            # - yacd: 暂无包，可以使用在线版本
            # - clash-dashboard: 暂无包，可以使用在线版本
            webui = lib.mkIf (cfg.webui == "metacubexd") pkgs.metacubexd;

            tunMode = cfg.tunMode;

            configFile = lib.mkIf cfg.configFile.enable cfg.configFile.path;

            extraOpts = lib.mkIf cfg.extraOpts.enable cfg.extraOpts.value;
        };

        # 开启必要的防火墙端口
        networking.firewall = {
            allowedTCPPorts = [
                7890
                7891
                7892
                7893
                7894
                7895
                7896
                7897
                7898
                7899
                9090
            ];
        };
    };
}
