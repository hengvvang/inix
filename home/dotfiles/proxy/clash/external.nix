{ config, lib, pkgs, ... }:

# External 方式：使用外部配置文件
# 用户配置目录中的文件链接到系统配置

let
  cfg = config.myHome.dotfiles.proxy.clash;
in
{
  config = lib.mkIf (cfg.enable && cfg.configMethod == "external") {
    home.file = {
      # 创建到系统配置的软链接
      "${cfg.configDir}/config.yaml" = {
        source = config.lib.file.mkOutOfStoreSymlink cfg.systemConfigPath;
      };
      
      # 提供配置说明
      "${cfg.configDir}/README.md".text = ''
        # Clash External 配置模式
        
        当前配置文件链接到系统配置：${cfg.systemConfigPath}
        
        ## 编辑配置
        
        ```bash
        # 编辑配置文件 (需要 sudo)
        sudo vim ${cfg.systemConfigPath}
        
        # 重启服务使配置生效
        clash-ctl restart
        ```
      '';
    };
  };
}
