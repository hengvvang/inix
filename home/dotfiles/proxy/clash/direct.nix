{ config, lib, pkgs, ... }:

# Direct 方式：直接复制配置文件到用户目录
# 用户可以直接编辑 ~/.config/clash/config.yaml

let
  cfg = config.myHome.dotfiles.proxy.clash;
in
{
  config = lib.mkIf (cfg.enable && cfg.configMethod == "direct") {
    home.file = {
      # 直接复制配置文件
      "${cfg.configDir}/config.yaml".source = ./configs/config.yaml;
      
      # 提供配置管理脚本
      "${cfg.configDir}/manage.sh" = {
        text = ''
          #!/usr/bin/env bash
          
          USER_CONFIG="${cfg.configDir}/config.yaml"
          SYSTEM_CONFIG="${cfg.systemConfigPath}"
          
          case "$1" in
            sync-to-system)
              echo "同步用户配置到系统..."
              sudo cp "$USER_CONFIG" "$SYSTEM_CONFIG"
              sudo systemctl restart clash
              ;;
            update-from-system)
              echo "从系统更新用户配置..."
              cp "$SYSTEM_CONFIG" "$USER_CONFIG"
              ;;
            edit)
              ''${EDITOR:-vim} "$USER_CONFIG"
              ;;
            *)
              echo "用法: $0 {sync-to-system|update-from-system|edit}"
              ;;
          esac
        '';
        executable = true;
      };
    };
  };
}
