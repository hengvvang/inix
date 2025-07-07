{ config, lib, pkgs, ... }:

let
  cfg = config.myHome.dotfiles.proxy.clash;
in
{
  config = lib.mkIf (cfg.enable && cfg.configMethod == "direct") {
    home.file = {
      # 直接复制配置文件
      "${cfg.configDir}/config.yaml".source = ./configs/config.yaml;
      
      # 简单管理脚本
      "${cfg.configDir}/sync.sh" = {
        text = ''
          #!/usr/bin/env bash
          
          case "$1" in
            to-system)
              sudo cp ~/.config/clash/config.yaml /etc/clash/config.yaml
              sudo systemctl restart clash
              echo "配置已同步到系统"
              ;;
            from-system)
              cp /etc/clash/config.yaml ~/.config/clash/config.yaml
              echo "配置已从系统更新"
              ;;
            *)
              echo "用法: $0 {to-system|from-system}"
              ;;
          esac
        '';
        executable = true;
      };
    };
  };
}
