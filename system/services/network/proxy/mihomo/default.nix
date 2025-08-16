{ config, lib, pkgs, ... }:

{
    imports = [
        ./mihomo.nix
    ];

    options.mySystem.services.network.proxy.mihomo = {
        enable = lib.mkEnableOption "Mihomo 代理支持";
        webui = lib.mkOption {
            type = lib.types.nullOr (lib.types.enum ["metacubexd"]);
            default = null;
            description = "选择 Mihomo Web UI (仅支持 metacubexd 本地包，其他可使用在线版本)";
        };
        tunMode = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "启用 TUN 模式";
        };
        configFile = {
            enable = lib.mkOption {
                type = lib.types.bool;
                default = true;
                description = "是否启用自定义配置文件";
            };
            path = lib.mkOption {
                type = lib.types.path;
                default = ./config.yaml;
                description = "Mihomo 配置文件路径";
            };
        };
        extraOpts = {
            enable = lib.mkOption {
                type = lib.types.bool;
                default = false;
                description = "是否启用额外配置选项";
            };
            value = lib.mkOption {
                type = lib.types.nullOr lib.types.str;
                default = null;
                description = "Mihomo 额外配置选项";
            };
        };
    };
}
