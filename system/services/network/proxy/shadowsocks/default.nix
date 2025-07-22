{ config, lib, pkgs, ... }:

{
    imports = [
        ./shadowsocks.nix
    ];
    
    options.mySystem.services.network.proxy.shadowsocks = {
        enable = lib.mkEnableOption "Shadowsocks 代理支持";
        
        # 基础配置
        mode = lib.mkOption {
            type = lib.types.enum ["tcp_only" "tcp_and_udp" "udp_only"];
            default = "tcp_and_udp";
            description = "中继协议模式";
        };
        
        localAddress = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = ["127.0.0.1"];
            description = "本地绑定地址";
        };
        
        port = lib.mkOption {
            type = lib.types.int;
            default = 8388;
            description = "服务端口";
        };
        
        password = lib.mkOption {
            type = lib.types.nullOr lib.types.str;
            default = null;
            description = "连接密码";
        };
        
        passwordFile = lib.mkOption {
            type = lib.types.nullOr lib.types.path;
            default = null;
            description = "密码文件路径";
        };
        
        encryptionMethod = lib.mkOption {
            type = lib.types.str;
            default = "chacha20-ietf-poly1305";
            description = "加密方法";
        };
        
        plugin = lib.mkOption {
            type = lib.types.nullOr lib.types.str;
            default = null;
            description = "SIP003 插件";
        };
        
        pluginOpts = lib.mkOption {
            type = lib.types.nullOr lib.types.str;
            default = null;
            description = "插件选项";
        };
        
        fastOpen = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "启用 TCP Fast Open";
        };
        
        extraConfig = lib.mkOption {
            type = lib.types.attrs;
            default = {};
            description = "额外配置选项";
        };
    };
}
