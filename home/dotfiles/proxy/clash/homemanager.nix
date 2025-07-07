{ config, lib, pkgs, ... }:

let
  cfg = config.myHome.dotfiles.proxy.clash;
in
{
  options.myHome.dotfiles.proxy.clash = {
    enable = lib.mkEnableOption "Clash 用户配置文件管理";
    
    # 三种配置方式
    configMethod = lib.mkOption {
      type = lib.types.enum [ "direct" "external" "homemanager" ];
      default = "homemanager";
      description = ''
        配置文件管理方式:
        - direct: 直接复制到用户配置目录
        - external: 使用外部配置文件
        - homemanager: 通过 Home Manager 管理
      '';
    };
    
    configDir = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/.config/clash";
      description = "Clash 用户配置目录";
    };
    
    systemConfigPath = lib.mkOption {
      type = lib.types.str;
      default = "/etc/clash/config.yaml";
      description = "系统 Clash 配置文件路径";
    };
  };

  config = lib.mkIf cfg.enable {
    # 方式1: Direct - 直接复制配置文件到用户目录
    home.file = lib.mkIf (cfg.configMethod == "direct") {
      # 复制基础配置文件
      "${cfg.configDir}/config.yaml".source = ./configs/config.yaml;
      
      # 复制管理脚本
      "${cfg.configDir}/update-config.sh" = {
        text = ''
          #!/usr/bin/env bash
          
          SYSTEM_CONFIG="${cfg.systemConfigPath}"
          USER_CONFIG="${cfg.configDir}/config.yaml"
          
          if [ -f "$SYSTEM_CONFIG" ]; then
            echo "复制系统配置到用户目录..."
            cp "$SYSTEM_CONFIG" "$USER_CONFIG"
            echo "配置已更新: $USER_CONFIG"
          else
            echo "系统配置文件不存在: $SYSTEM_CONFIG"
          fi
        '';
        executable = true;
      };
      
      # 复制同步脚本
      "${cfg.configDir}/sync-to-system.sh" = {
        text = ''
          #!/usr/bin/env bash
          
          USER_CONFIG="${cfg.configDir}/config.yaml"
          SYSTEM_CONFIG="${cfg.systemConfigPath}"
          
          if [ -f "$USER_CONFIG" ]; then
            echo "同步用户配置到系统..."
            sudo cp "$USER_CONFIG" "$SYSTEM_CONFIG"
            echo "配置已同步到系统: $SYSTEM_CONFIG"
            
            # 重启服务
            if systemctl is-active --quiet clash; then
              echo "重启 Clash 服务..."
              sudo systemctl restart clash
            fi
          else
            echo "用户配置文件不存在: $USER_CONFIG"
          fi
        '';
        executable = true;
      };
    };

    # 方式2: External - 使用外部配置文件链接
    home.file = lib.mkIf (cfg.configMethod == "external") {
      # 创建软链接到系统配置
      "${cfg.configDir}/config.yaml" = {
        source = config.lib.file.mkOutOfStoreSymlink cfg.systemConfigPath;
      };
      
      # 外部配置说明
      "${cfg.configDir}/README.md".text = ''
        # Clash 外部配置模式
        
        当前使用外部配置模式，配置文件链接到系统配置：
        - 系统配置: ${cfg.systemConfigPath}
        - 用户配置: ${cfg.configDir}/config.yaml (软链接)
        
        ## 配置修改
        
        修改系统配置文件后，用户配置会自动同步。
        
        ## 管理命令
        
        ```bash
        # 查看配置
        cat ${cfg.configDir}/config.yaml
        
        # 编辑配置 (需要 sudo)
        sudo vim ${cfg.systemConfigPath}
        
        # 重启服务
        clash-ctl restart
        ```
      '';
    };

    # 方式3: Home Manager - 通过 Home Manager 管理配置
    home.file = lib.mkIf (cfg.configMethod == "homemanager") {
      # Home Manager 管理的配置文件
      "${cfg.configDir}/config.yaml".source = ./configs/config.yaml;
      
      # 配置模板
      "${cfg.configDir}/config-template.yaml".source = ./configs/config.yaml;
      
      # Home Manager 配置说明
      "${cfg.configDir}/README.md".text = ''
        # Clash Home Manager 配置模式
        
        当前使用 Home Manager 管理配置文件。
        
        ## 配置文件位置
        
        - 用户配置: ${cfg.configDir}/config.yaml
        - 配置模板: ${cfg.configDir}/config-template.yaml
        - 系统配置: ${cfg.systemConfigPath}
        
        ## 配置修改流程
        
        1. 修改 Nix 配置文件
        2. 运行 `home-manager switch`
        3. 同步到系统配置 (如需要)
        
        ## 管理脚本
        
        ```bash
        # 同步到系统配置
        ./sync-to-system.sh
        
        # 从系统更新用户配置
        ./update-from-system.sh
        ```
      '';
      
      # 同步脚本
      "${cfg.configDir}/sync-to-system.sh" = {
        text = ''
          #!/usr/bin/env bash
          
          USER_CONFIG="${cfg.configDir}/config.yaml"
          SYSTEM_CONFIG="${cfg.systemConfigPath}"
          
          if [ -f "$USER_CONFIG" ]; then
            echo "同步 Home Manager 配置到系统..."
            sudo cp "$USER_CONFIG" "$SYSTEM_CONFIG"
            echo "配置已同步: $SYSTEM_CONFIG"
            
            if systemctl is-active --quiet clash; then
              echo "重启 Clash 服务..."
              sudo systemctl restart clash
            fi
          else
            echo "用户配置文件不存在: $USER_CONFIG"
          fi
        '';
        executable = true;
      };
      
      "${cfg.configDir}/update-from-system.sh" = {
        text = ''
          #!/usr/bin/env bash
          
          SYSTEM_CONFIG="${cfg.systemConfigPath}"
          USER_CONFIG="${cfg.configDir}/config.yaml"
          
          if [ -f "$SYSTEM_CONFIG" ]; then
            echo "从系统配置更新用户配置..."
            cp "$SYSTEM_CONFIG" "$USER_CONFIG"
            echo "配置已更新: $USER_CONFIG"
            echo "注意: 下次 home-manager switch 时会覆盖此更改"
          else
            echo "系统配置文件不存在: $SYSTEM_CONFIG"
          fi
        '';
        executable = true;
      };
    };

    # 通用工具脚本
    home.file."${cfg.configDir}/clash-tools.sh" = {
      text = ''
        #!/usr/bin/env bash
        
        CONFIG_DIR="${cfg.configDir}"
        SYSTEM_CONFIG="${cfg.systemConfigPath}"
        
        show_help() {
          echo "Clash 用户配置工具"
          echo ""
          echo "用法: $0 <命令>"
          echo ""
          echo "命令:"
          echo "  status      - 显示配置状态"
          echo "  diff        - 比较用户配置和系统配置"
          echo "  backup      - 备份当前配置"
          echo "  restore     - 恢复备份配置"
          echo "  validate    - 验证配置文件"
          echo "  help        - 显示此帮助"
        }
        
        case "$1" in
          status)
            echo "=== Clash 配置状态 ==="
            echo "配置方式: ${cfg.configMethod}"
            echo "用户配置目录: $CONFIG_DIR"
            echo "系统配置文件: $SYSTEM_CONFIG"
            echo ""
            echo "文件状态:"
            [ -f "$CONFIG_DIR/config.yaml" ] && echo "✓ 用户配置存在" || echo "✗ 用户配置不存在"
            [ -f "$SYSTEM_CONFIG" ] && echo "✓ 系统配置存在" || echo "✗ 系统配置不存在"
            ;;
          diff)
            if [ -f "$CONFIG_DIR/config.yaml" ] && [ -f "$SYSTEM_CONFIG" ]; then
              echo "比较用户配置和系统配置..."
              diff -u "$CONFIG_DIR/config.yaml" "$SYSTEM_CONFIG" || true
            else
              echo "配置文件不完整，无法比较"
            fi
            ;;
          backup)
            if [ -f "$CONFIG_DIR/config.yaml" ]; then
              BACKUP_FILE="$CONFIG_DIR/config.yaml.backup.$(date +%Y%m%d_%H%M%S)"
              cp "$CONFIG_DIR/config.yaml" "$BACKUP_FILE"
              echo "配置已备份到: $BACKUP_FILE"
            else
              echo "用户配置文件不存在"
            fi
            ;;
          restore)
            LATEST_BACKUP=$(ls -t "$CONFIG_DIR"/config.yaml.backup.* 2>/dev/null | head -n1)
            if [ -n "$LATEST_BACKUP" ]; then
              cp "$LATEST_BACKUP" "$CONFIG_DIR/config.yaml"
              echo "已恢复备份: $LATEST_BACKUP"
            else
              echo "没有找到备份文件"
            fi
            ;;
          validate)
            if [ -f "$CONFIG_DIR/config.yaml" ]; then
              echo "验证用户配置文件..."
              if command -v clash-meta >/dev/null; then
                clash-meta -t -f "$CONFIG_DIR/config.yaml"
              else
                echo "clash-meta 未安装，无法验证"
              fi
            else
              echo "用户配置文件不存在"
            fi
            ;;
          help|*)
            show_help
            ;;
        esac
      '';
      executable = true;
    };

    # 安装用户工具
    home.packages = with pkgs; [
      # YAML 处理工具
      yq-go
    ];
  };
}
