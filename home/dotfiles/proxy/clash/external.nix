{ config, lib, pkgs, ... }:

let
  cfg = config.myHome.dotfiles.proxy.clash;
in
{
  config = lib.mkIf (cfg.enable && cfg.configMethod == "external") {
    home.file = {
      # 创建到系统配置的软链接
      "${cfg.configDir}/config.yaml" = {
        source = config.lib.file.mkOutOfStoreSymlink "/etc/clash/config.yaml";
      };
      
      # 简单说明
      "${cfg.configDir}/README.md".text = ''
        # Clash 外部配置模式
        
        配置文件链接到: /etc/clash/config.yaml
        
        编辑配置: sudo vim /etc/clash/config.yaml
        重启服务: clash-ctl restart
      '';
    };
  };
}
