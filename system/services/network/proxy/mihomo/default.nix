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
            default = true;
            description = "启用 TUN 模式";
        };
        extraOpts = lib.mkOption {
            type = lib.types.nullOr lib.types.str;
            default = null;
            description = "Mihomo 额外配置选项";
        };
        configFile = lib.mkOption {
            type = lib.types.nullOr lib.types.path;
            default = null;
            description = "Mihomo 配置文件路径";
        };
    };
}