# rmpc 外部配置文件引用方式
{ config, lib, pkgs, ... }:

let
  cfg = config.myHome.dotfiles.rmpc;
in
{
  config = lib.mkIf (config.myHome.dotfiles.enable && cfg.enable && cfg.method == "external") {
    # 安装 rmpc 及相关工具
    home.packages = with pkgs; [
      rmpc
      cava
      libnotify
    ];

    # 创建目录结构但不生成配置文件
    home.file.".cache/rmpc/.keep".text = "";
    home.file.".local/share/rmpc/lyrics/.keep".text = "";

    # 创建启动脚本，检查外部配置文件
    home.file.".local/bin/rmpc-wrapper" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        # rmpc 外部配置启动脚本
        
        CONFIG_FILE="$HOME/.config/rmpc/config.ron"
        
        # 检查配置文件是否存在
        if [ ! -f "$CONFIG_FILE" ]; then
          echo "错误: 未找到 rmpc 配置文件: $CONFIG_FILE"
          echo ""
          echo "请执行以下步骤来配置 rmpc:"
          echo "1. 创建配置目录: mkdir -p ~/.config/rmpc"
          echo "2. 生成默认配置: rmpc config > ~/.config/rmpc/config.ron"
          echo "3. 编辑配置文件: \$EDITOR ~/.config/rmpc/config.ron"
          echo ""
          read -p "是否现在创建默认配置文件? [y/N] " -n 1 -r
          echo
          if [[ $REPLY =~ ^[Yy]$ ]]; then
            mkdir -p "$(dirname "$CONFIG_FILE")"
            ${pkgs.rmpc}/bin/rmpc config > "$CONFIG_FILE"
            echo "✓ 默认配置文件已创建: $CONFIG_FILE"
            echo "你可以编辑此文件来自定义 rmpc 设置"
          else
            exit 1
          fi
        fi
        
        # 检查配置文件语法
        if ! ${pkgs.rmpc}/bin/rmpc --config "$CONFIG_FILE" --help >/dev/null 2>&1; then
          echo "警告: 配置文件可能有语法错误"
          echo "配置文件位置: $CONFIG_FILE"
          read -p "是否继续启动? [y/N] " -n 1 -r
          echo
          if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
          fi
        fi
        
        # 启动 rmpc
        exec ${pkgs.rmpc}/bin/rmpc "$@"
      '';
    };

    # 配置管理脚本
    home.file.".local/bin/rmpc-config" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        # rmpc 配置管理脚本
        
        CONFIG_DIR="$HOME/.config/rmpc"
        CONFIG_FILE="$CONFIG_DIR/config.ron"
        BACKUP_DIR="$CONFIG_DIR/backups"
        
        case "$1" in
          create)
            if [ -f "$CONFIG_FILE" ]; then
              echo "配置文件已存在: $CONFIG_FILE"
              read -p "是否覆盖现有配置? [y/N] " -n 1 -r
              echo
              if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                exit 0
              fi
            fi
            
            mkdir -p "$CONFIG_DIR"
            echo "正在生成默认配置文件..."
            ${pkgs.rmpc}/bin/rmpc config > "$CONFIG_FILE"
            echo "✓ 默认配置文件已创建: $CONFIG_FILE"
            ;;
            
          edit)
            if [ ! -f "$CONFIG_FILE" ]; then
              echo "配置文件不存在，正在创建..."
              "$0" create
            fi
            
            # 使用用户首选编辑器
            EDITOR=''${EDITOR:-nano}
            $EDITOR "$CONFIG_FILE"
            ;;
            
          backup)
            if [ ! -f "$CONFIG_FILE" ]; then
              echo "错误: 配置文件不存在"
              exit 1
            fi
            
            mkdir -p "$BACKUP_DIR"
            BACKUP_FILE="$BACKUP_DIR/config-$(date +%Y%m%d-%H%M%S).ron"
            cp "$CONFIG_FILE" "$BACKUP_FILE"
            echo "✓ 配置文件已备份: $BACKUP_FILE"
            ;;
            
          restore)
            if [ ! -d "$BACKUP_DIR" ] || [ -z "$(ls -A "$BACKUP_DIR")" ]; then
              echo "错误: 未找到备份文件"
              exit 1
            fi
            
            echo "可用的备份文件:"
            ls -la "$BACKUP_DIR"
            echo ""
            read -p "请输入要恢复的备份文件名: " backup_name
            
            if [ -f "$BACKUP_DIR/$backup_name" ]; then
              cp "$BACKUP_DIR/$backup_name" "$CONFIG_FILE"
              echo "✓ 配置文件已恢复"
            else
              echo "错误: 备份文件不存在"
              exit 1
            fi
            ;;
            
          validate)
            if [ ! -f "$CONFIG_FILE" ]; then
              echo "错误: 配置文件不存在"
              exit 1
            fi
            
            echo "正在验证配置文件..."
            if ${pkgs.rmpc}/bin/rmpc --config "$CONFIG_FILE" --help >/dev/null 2>&1; then
              echo "✓ 配置文件语法正确"
            else
              echo "✗ 配置文件有语法错误"
              exit 1
            fi
            ;;
            
          show)
            if [ ! -f "$CONFIG_FILE" ]; then
              echo "配置文件不存在"
              exit 1
            fi
            
            echo "rmpc 配置文件内容:"
            echo "文件位置: $CONFIG_FILE"
            echo "修改时间: $(date -r "$CONFIG_FILE")"
            echo ""
            cat "$CONFIG_FILE"
            ;;
            
          location)
            echo "rmpc 配置文件位置:"
            echo "  配置文件: $CONFIG_FILE"
            echo "  备份目录: $BACKUP_DIR"
            echo "  缓存目录: $HOME/.cache/rmpc"
            echo "  歌词目录: $HOME/.local/share/rmpc/lyrics"
            ;;
            
          *)
            echo "rmpc 配置管理工具"
            echo "用法: rmpc-config {create|edit|backup|restore|validate|show|location}"
            echo ""
            echo "配置管理:"
            echo "  create    - 创建默认配置文件"
            echo "  edit      - 编辑配置文件"
            echo "  backup    - 备份当前配置"
            echo "  restore   - 恢复配置备份"
            echo "  validate  - 验证配置语法"
            echo ""
            echo "信息查看:"
            echo "  show      - 显示配置内容"
            echo "  location  - 显示文件位置"
            ;;
        esac
      '';
    };

    # 桌面启动器
    home.file.".local/share/applications/rmpc.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=rmpc (外部配置)
      Comment=终端音乐播放器客户端 (外部配置方式)
      Exec=rmpc-wrapper
      Icon=multimedia-audio-player
      Categories=AudioVideo;Audio;Player;
      Terminal=true
      StartupNotify=false
      Keywords=music;audio;player;mpd;terminal;external;
    '';

    # Shell 别名
    programs.bash.shellAliases = lib.mkIf config.programs.bash.enable {
      rmpc-conf = "rmpc-config";
    };

    programs.fish.shellAliases = lib.mkIf config.programs.fish.enable {
      rmpc-conf = "rmpc-config";
    };

    programs.zsh.shellAliases = lib.mkIf config.programs.zsh.enable {
      rmpc-conf = "rmpc-config";
    };
  };
}
