{ config, lib, pkgs, ... }:

{
    imports = [
        ./mihomo.nix
    ];
    
    options.mySystem.services.network.proxy.mihomo = {
        enable = lib.mkEnableOption "Mihomo 代理支持";
        webui = lib.mkOption {
            type = lib.types.nullOr (lib.types.enum ["metacubexd" "yacd" "clash-dashboard"]);
            default = null;
            description = "选择 Mihomo Web UI (metacubexd, yacd, clash-dashboard)";
        };
        tunMode = lib.mkOption {
            type = lib.types.bool;
            default = true;
            description = "启用 TUN 模式";
        };
        extraOpts = lib.mkOption {
            type = lib.types.nullOr lib.types.str;
            default = null;
            description = "Mihomo 额外配置选项";
        };
        configFile = lib.mkOption {
            type = lib.types.path;
            default = "/etc/mihomo/config.yaml";
            description = "Mihomo 配置文件路径";
        };
    };
}