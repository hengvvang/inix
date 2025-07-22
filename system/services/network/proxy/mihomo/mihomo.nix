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
            
            extraOpts = cfg.extraOpts;
            tunMode = cfg.tunMode;
            configFile = cfg.configFile;
        };

        # 开启必要的防火墙端口
        networking.firewall = {
            allowedTCPPorts = [ 
                7897  # 混合代理端口 (HTTP + SOCKS5)
                7891  # HTTP 代理端口
                7892  # SOCKS5 代理端口
                9097  # Web 控制面板端口
            ];
        };

        # 添加用户到 mihomo 组
        users.groups.mihomo = {};
    };
}