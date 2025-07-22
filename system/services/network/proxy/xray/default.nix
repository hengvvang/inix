{ config, lib, pkgs, ... }:

{
    imports = [
        ./xray.nix
    ];
    
    options.mySystem.services.network.proxy.xray = {
        enable = lib.mkEnableOption "Xray 代理支持";
        package = lib.mkOption {
            type = lib.types.package;
            default = pkgs.xray;
            description = "使用的 xray 包";
        };
        settings = lib.mkOption {
            type = lib.types.nullOr lib.types.attrs;
            default = null;
            description = "Xray 配置对象";
        };
        settingsFile = lib.mkOption {
            type = lib.types.nullOr lib.types.path;
            default = null;
            description = "Xray 配置文件路径";
        };
    };
}
