{ config, lib, pkgs, ... }:
let
    cfg = config.mySystem.services.network.proxy.mihomo;
    
    # Web UI URL 映射
    webuiUrls = {
        metacubexd = "https://d.metacubex.one";
        yacd = "https://yacd.haishan.me";
        clash-dashboard = "https://clash.razord.top";
    };
in
{
    config = lib.mkIf cfg.enable {
        services.mihomo = {
            enable = true;

            package = pkgs.mihomo;

            # Web UI 根据用户选择的枚举值映射到对应的 URL
            # 支持的选项：
            # - metacubexd: https://d.metacubex.one
            # - yacd: https://yacd.haishan.me  
            # - clash-dashboard: https://clash.razord.top
            webui = lib.mkIf (cfg.enable && cfg.webui != null) webuiUrls.${cfg.webui};

            extraOpts = lib.mkIf (cfg.extraOpts != null) cfg.extraOpts;

            tunMode = lib.mkIf (cfg.enable && cfg.tunMode) {
                enable = true;
            };

            configFile = lib.mkIf (cfg.enable && cfg.configFile != null) cfg.configFile;
        };
    }
}