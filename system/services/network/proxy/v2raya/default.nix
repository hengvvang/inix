{ config, lib, pkgs, ... }:

{
    imports = [
        ./v2raya.nix
    ];
    
    options.mySystem.services.network.proxy.v2raya = {
        enable = lib.mkEnableOption "V2rayA 代理支持";
        cliPackage = lib.mkOption {
            type = lib.types.package;
            default = pkgs.v2ray;
            description = "使用的 v2ray 包";
        };
        package = lib.mkOption {
            type = lib.types.package;
            default = pkgs.v2raya;
            description = "使用的 v2raya 包";
        };
    };
}
