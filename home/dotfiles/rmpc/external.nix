# ==============================================================================
# rmpc (Rust MPD Client) External Configuration 外部配置模块
# ==============================================================================
#
# rmpc 外部配置方式 - 使用用户手动管理的配置文件
# 
# 🎯 配置理念:
#   • 用户完全控制配置文件内容
#   • 支持配置文件的备份和版本管理
#   • 提供便捷的配置管理工具
#   • 灵活的配置文件编辑和验证
#
# 📁 文件结构:
#   • ~/.config/rmpc/config.ron    - 主配置文件（用户维护）
#   • ~/.config/rmpc/backups/      - 配置备份目录
#   • ~/.cache/rmpc/               - 缓存目录
#   • ~/.local/share/rmpc/lyrics/  - 歌词存储目录
#
# 🔧 管理工具:
#   • rmpc-wrapper                 - 智能启动脚本
#   • rmpc-config                  - 配置管理命令行工具
#
# 配置示例:
#   myHome.dotfiles.rmpc = {
#     enable = true;
#     method = "external";
#   };
#
# ==============================================================================
{ config, lib, pkgs, ... }:

let
  cfg = config.myHome.dotfiles.rmpc;
in
{
  config = lib.mkIf (config.myHome.dotfiles.enable && cfg.enable && cfg.method == "external") {
    # ==================================================
    # 软件包安装配置
    # ==================================================
    home.packages = with pkgs; [
      rmpc          # 现代 Rust MPD 客户端 - 主程序
      cava          # 终端音频可视化器 - 增强体验
      libnotify     # 桌面通知支持 - 歌曲切换提醒
    ];

    # ==================================================
    # 目录结构初始化
    # ==================================================
    # 创建必要的目录结构，但不生成配置内容
    home.file.".cache/rmpc/.keep".text = "";                    # 缓存目录标记
    home.file.".local/share/rmpc/lyrics/.keep".text = "";       # 歌词目录标记
    home.file.".config/rmpc/backups/.keep".text = "";           # 备份目录标记

    # ==================================================
    # rmpc 智能启动脚本
    # ==================================================
    home.file.".local/bin/rmpc-wrapper" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        # ==============================================================================
        # rmpc 外部配置智能启动脚本
        # ==============================================================================
        # 
        # 功能特性:
        #   • 自动检查配置文件存在性
        #   • 配置文件语法验证
        #   • 交互式配置文件创建
        #   • MPD 连接状态检查
        #   • 友好的错误信息和建议
        #
        # 用法: rmpc-wrapper [rmpc选项...]
        #
        # ==============================================================================
        
        CONFIG_FILE="$HOME/.config/rmpc/config.ron"
        
        # ===== 配置文件存在性检查 =====
        if [ ! -f "$CONFIG_FILE" ]; then
            echo "⚠️  未找到 rmpc 配置文件: $CONFIG_FILE"
            echo ""
            echo "📋 配置文件创建步骤:"
            echo "   1️⃣  创建配置目录: mkdir -p ~/.config/rmpc"
            echo "   2️⃣  生成默认配置: rmpc config > ~/.config/rmpc/config.ron"
            echo "   3️⃣  编辑配置文件: \$EDITOR ~/.config/rmpc/config.ron"
            echo "   4️⃣  或使用管理工具: rmpc-config create"
            echo ""
            echo "🔧 快速开始:"
            read -p "   是否现在创建默认配置文件? [y/N] " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                echo "📁 创建配置目录..."
                mkdir -p "$(dirname "$CONFIG_FILE")"
                mkdir -p "$HOME/.cache/rmpc"
                mkdir -p "$HOME/.local/share/rmpc/lyrics"
                
                echo "⚙️  生成默认配置..."
                if ${pkgs.rmpc}/bin/rmpc config > "$CONFIG_FILE"; then
                    echo "✅ 默认配置文件已创建: $CONFIG_FILE"
                    echo ""
                    echo "💡 提示:"
                    echo "   • 使用 rmpc-config edit 编辑配置"
                    echo "   • 使用 rmpc-config backup 备份配置"
                    echo "   • 使用 rmpc-config validate 验证配置"
                else
                    echo "❌ 配置文件创建失败"
                    exit 1
                fi
            else
                echo "❌ 需要配置文件才能运行 rmpc"
                exit 1
            fi
        fi
        
        # ===== 配置文件语法验证 =====
        echo "🔍 验证配置文件语法..."
        if ! ${pkgs.rmpc}/bin/rmpc --config "$CONFIG_FILE" --help >/dev/null 2>&1; then
            echo "⚠️  警告: 配置文件可能存在语法错误"
            echo "📄 配置文件位置: $CONFIG_FILE"
            echo ""
            echo "🛠️  建议操作:"
            echo "   • 使用 rmpc-config validate 详细检查"
            echo "   • 使用 rmpc-config edit 修复错误"
            echo "   • 使用 rmpc-config restore 恢复备份"
            echo ""
            read -p "   是否继续启动? [y/N] " -n 1 -r
            echo
            if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                exit 1
            fi
        fi
        
        # ===== MPD 服务连接检查 =====
        echo "🔗 检查 MPD 服务连接状态..."
        if command -v mpc >/dev/null 2>&1; then
            if mpc status >/dev/null 2>&1; then
                echo "✅ MPD 服务连接正常"
            else
                echo "⚠️  警告: 无法连接到 MPD 服务"
                echo "💡 故障排除提示:"
                echo "   • 检查 MPD 服务状态: systemctl status mpd"
                echo "   • 检查服务是否运行: systemctl start mpd"
                echo "   • 检查配置中的连接地址和端口"
                echo ""
            fi
        else
            echo "ℹ️  信息: 未安装 mpc 工具，跳过连接检查"
        fi
        
        # ===== 启动 rmpc =====
        echo "🎵 启动 rmpc..."
        exec ${pkgs.rmpc}/bin/rmpc "$@"
      '';
    };

    # ==================================================
    # rmpc 配置管理工具
    # ==================================================
    home.file.".local/bin/rmpc-config" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        # ==============================================================================
        # rmpc 外部配置管理工具
        # ==============================================================================
        # 
        # 完整的 rmpc 配置文件管理解决方案，提供:
        #   • 配置文件创建和编辑
        #   • 自动化备份和恢复
        #   • 配置语法验证
        #   • 配置信息查看
        #
        # 用法: rmpc-config <command> [options]
        #
        # ==============================================================================
        
        CONFIG_DIR="$HOME/.config/rmpc"
        CONFIG_FILE="$CONFIG_DIR/config.ron"
        BACKUP_DIR="$CONFIG_DIR/backups"
        
        # ===== 帮助信息函数 =====
        show_help() {
            echo "🎵 rmpc 配置管理工具"
            echo ""
            echo "📋 用法: rmpc-config <command> [options]"
            echo ""
            echo "🔧 配置管理命令:"
            echo "   create     - 创建默认配置文件"
            echo "   edit       - 编辑配置文件（自动选择编辑器）"
            echo "   backup     - 备份当前配置（带时间戳）"
            echo "   restore    - 从备份恢复配置（交互式选择）"
            echo "   validate   - 验证配置文件语法正确性"
            echo ""
            echo "ℹ️  信息查看命令:"
            echo "   show       - 显示当前配置文件内容"
            echo "   location   - 显示配置文件和目录位置"
            echo "   help       - 显示此帮助信息"
            echo ""
            echo "📁 配置文件位置:"
            echo "   主配置: $CONFIG_FILE"
            echo "   备份目录: $BACKUP_DIR"
        }
        
        case "$1" in
            # ===== 创建配置文件 =====
            create)
                if [ -f "$CONFIG_FILE" ]; then
                    echo "⚠️  配置文件已存在: $CONFIG_FILE"
                    echo "📅 修改时间: $(date -r "$CONFIG_FILE")"
                    echo ""
                    read -p "🔄 是否覆盖现有配置? [y/N] " -n 1 -r
                    echo
                    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                        echo "❌ 操作已取消"
                        exit 0
                    fi
                    
                    # 自动备份现有配置
                    echo "💾 自动备份现有配置..."
                    "$0" backup
                fi
                
                echo "📁 创建配置目录..."
                mkdir -p "$CONFIG_DIR"
                mkdir -p "$BACKUP_DIR"
                
                echo "⚙️  生成默认配置文件..."
                if ${pkgs.rmpc}/bin/rmpc config > "$CONFIG_FILE"; then
                    echo "✅ 默认配置文件已创建: $CONFIG_FILE"
                    echo ""
                    echo "📝 下一步建议:"
                    echo "   • 使用 rmpc-config edit 编辑配置"
                    echo "   • 使用 rmpc-config validate 验证配置"
                    echo "   • 使用 rmpc-wrapper 启动程序"
                else
                    echo "❌ 配置文件创建失败"
                    exit 1
                fi
                ;;
                
            # ===== 编辑配置文件 =====
            edit)
                if [ ! -f "$CONFIG_FILE" ]; then
                    echo "❓ 配置文件不存在，是否创建?"
                    read -p "   创建默认配置文件? [Y/n] " -n 1 -r
                    echo
                    if [[ ! $REPLY =~ ^[Nn]$ ]]; then
                        "$0" create
                        if [ $? -ne 0 ]; then
                            echo "❌ 配置文件创建失败"
                            exit 1
                        fi
                    else
                        echo "❌ 需要配置文件才能进行编辑"
                        exit 1
                    fi
                fi
                
                # 自动备份
                echo "💾 自动备份当前配置..."
                "$0" backup
                
                # 检测并使用合适的编辑器
                if command -v code >/dev/null 2>&1; then
                    EDITOR="code"
                elif command -v vim >/dev/null 2>&1; then
                    EDITOR="vim"
                elif command -v nano >/dev/null 2>&1; then
                    EDITOR="nano"
                else
                    EDITOR="''${EDITOR:-nano}"
                fi
                
                echo "📝 使用 $EDITOR 编辑配置文件..."
                $EDITOR "$CONFIG_FILE"
                
                # 编辑后验证
                echo "🔍 验证配置文件..."
                "$0" validate
                ;;
                
            # ===== 备份配置文件 =====
            backup)
                if [ ! -f "$CONFIG_FILE" ]; then
                    echo "❌ 错误: 配置文件不存在，无法备份"
                    exit 1
                fi
                
                mkdir -p "$BACKUP_DIR"
                TIMESTAMP=$(date +%Y%m%d-%H%M%S)
                BACKUP_FILE="$BACKUP_DIR/config-$TIMESTAMP.ron"
                
                if cp "$CONFIG_FILE" "$BACKUP_FILE"; then
                    echo "✅ 配置文件已备份: $BACKUP_FILE"
                    echo "📊 备份文件大小: $(du -h "$BACKUP_FILE" | cut -f1)"
                    
                    # 显示备份数量
                    BACKUP_COUNT=$(ls -1 "$BACKUP_DIR"/*.ron 2>/dev/null | wc -l)
                    echo "📁 当前备份总数: $BACKUP_COUNT 个"
                else
                    echo "❌ 备份失败"
                    exit 1
                fi
                ;;
                
            # ===== 恢复配置备份 =====
            restore)
                if [ ! -d "$BACKUP_DIR" ] || [ -z "$(ls -A "$BACKUP_DIR"/*.ron 2>/dev/null)" ]; then
                    echo "❌ 错误: 未找到任何备份文件"
                    echo "📁 备份目录: $BACKUP_DIR"
                    exit 1
                fi
                
                echo "📋 可用的配置备份文件:"
                echo "----------------------------------------"
                ls -la "$BACKUP_DIR"/*.ron | awk '{print $9 "  [" $5 " bytes, " $6 " " $7 " " $8 "]"}' | sed 's|.*/||'
                echo "----------------------------------------"
                echo ""
                
                read -p "📄 请输入要恢复的备份文件名 (不含路径): " backup_name
                
                if [ -z "$backup_name" ]; then
                    echo "❌ 未指定备份文件名"
                    exit 1
                fi
                
                BACKUP_PATH="$BACKUP_DIR/$backup_name"
                
                if [ -f "$BACKUP_PATH" ]; then
                    # 备份当前配置
                    if [ -f "$CONFIG_FILE" ]; then
                        echo "💾 备份当前配置..."
                        "$0" backup
                    fi
                    
                    echo "🔄 恢复配置文件..."
                    if cp "$BACKUP_PATH" "$CONFIG_FILE"; then
                        echo "✅ 配置文件已恢复从: $backup_name"
                        echo "🔍 验证恢复的配置..."
                        "$0" validate
                    else
                        echo "❌ 配置文件恢复失败"
                        exit 1
                    fi
                else
                    echo "❌ 错误: 备份文件不存在: $backup_name"
                    exit 1
                fi
                ;;
                
            # ===== 验证配置语法 =====
            validate)
                if [ ! -f "$CONFIG_FILE" ]; then
                    echo "❌ 错误: 配置文件不存在"
                    echo "💡 提示: 使用 'rmpc-config create' 创建配置文件"
                    exit 1
                fi
                
                echo "🔍 验证配置文件语法..."
                echo "📄 配置文件: $CONFIG_FILE"
                
                if ${pkgs.rmpc}/bin/rmpc --config "$CONFIG_FILE" --help >/dev/null 2>&1; then
                    echo "✅ 配置文件语法正确"
                    echo "📊 文件大小: $(du -h "$CONFIG_FILE" | cut -f1)"
                    echo "📅 修改时间: $(date -r "$CONFIG_FILE")"
                else
                    echo "❌ 配置文件存在语法错误"
                    echo ""
                    echo "🛠️  建议修复步骤:"
                    echo "   1. 使用 rmpc-config edit 编辑配置"
                    echo "   2. 检查 RON 格式语法"
                    echo "   3. 或使用 rmpc-config restore 恢复备份"
                    exit 1
                fi
                ;;
                
            # ===== 显示配置内容 =====
            show)
                if [ ! -f "$CONFIG_FILE" ]; then
                    echo "❌ 配置文件不存在"
                    echo "💡 提示: 使用 'rmpc-config create' 创建配置文件"
                    exit 1
                fi
                
                echo "📄 rmpc 配置文件内容:"
                echo "=========================================="
                echo "📁 文件位置: $CONFIG_FILE"
                echo "📊 文件大小: $(du -h "$CONFIG_FILE" | cut -f1)"
                echo "📅 修改时间: $(date -r "$CONFIG_FILE")"
                echo "=========================================="
                echo ""
                
                # 使用语法高亮显示（如果可用）
                if command -v bat >/dev/null 2>&1; then
                    bat --style=numbers,header "$CONFIG_FILE"
                elif command -v less >/dev/null 2>&1; then
                    less "$CONFIG_FILE"
                else
                    cat "$CONFIG_FILE"
                fi
                ;;
                
            # ===== 显示文件位置信息 =====
            location)
                echo "📁 rmpc 配置文件和目录位置:"
                echo "============================================="
                echo "🔧 主配置文件: $CONFIG_FILE"
                [ -f "$CONFIG_FILE" ] && echo "   ✅ 存在 ($(du -h "$CONFIG_FILE" | cut -f1))" || echo "   ❌ 不存在"
                echo ""
                echo "💾 备份目录: $BACKUP_DIR"
                if [ -d "$BACKUP_DIR" ]; then
                    BACKUP_COUNT=$(ls -1 "$BACKUP_DIR"/*.ron 2>/dev/null | wc -l)
                    echo "   ✅ 存在 ($BACKUP_COUNT 个备份文件)"
                else
                    echo "   ❌ 不存在"
                fi
                echo ""
                echo "📁 缓存目录: $HOME/.cache/rmpc"
                [ -d "$HOME/.cache/rmpc" ] && echo "   ✅ 存在" || echo "   ❌ 不存在"
                echo ""
                echo "🎵 歌词目录: $HOME/.local/share/rmpc/lyrics"
                [ -d "$HOME/.local/share/rmpc/lyrics" ] && echo "   ✅ 存在" || echo "   ❌ 不存在"
                ;;
                
            # ===== 帮助信息 =====
            help)
                show_help
                ;;
                
            # ===== 无效命令处理 =====
            *)
                if [ -n "$1" ]; then
                    echo "❌ 未知命令: $1"
                    echo ""
                fi
                show_help
                exit 1
                ;;
        esac
      '';
    };

    # ==================================================
    # 桌面环境集成
    # ==================================================
    # 桌面启动器 - 支持应用菜单中的快速访问
    home.file.".local/share/applications/rmpc.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=rmpc
      Comment=现代化终端 MPD 客户端 (外部配置)
      Exec=${pkgs.writeShellScript "rmpc-launcher" ''
        # 启动器脚本 - 确保使用包装器启动
        if [ -x "$HOME/.local/bin/rmpc-wrapper" ]; then
          exec "$HOME/.local/bin/rmpc-wrapper" "$@"
        else
          exec ${pkgs.rmpc}/bin/rmpc "$@"
        fi
      ''}
      Icon=multimedia-audio-player
      Categories=AudioVideo;Audio;Player;
      Terminal=true
      StartupNotify=false
      Keywords=music;audio;player;mpd;terminal;rust;external;config;
    '';

    # ==================================================
    # Shell 环境集成
    # ==================================================
    # 为各种 Shell 添加便捷别名
    programs.bash.shellAliases = lib.mkIf config.programs.bash.enable {
      rmpc-conf = "rmpc-config";              # 配置管理快捷方式
      rmpc-edit = "rmpc-config edit";         # 快速编辑配置
      rmpc-backup = "rmpc-config backup";     # 快速备份配置
      rmpc-validate = "rmpc-config validate"; # 快速验证配置
    };

    programs.fish.shellAliases = lib.mkIf config.programs.fish.enable {
      rmpc-conf = "rmpc-config";              # 配置管理快捷方式
      rmpc-edit = "rmpc-config edit";         # 快速编辑配置
      rmpc-backup = "rmpc-config backup";     # 快速备份配置
      rmpc-validate = "rmpc-config validate"; # 快速验证配置
    };

    programs.zsh.shellAliases = lib.mkIf config.programs.zsh.enable {
      rmpc-conf = "rmpc-config";              # 配置管理快捷方式
      rmpc-edit = "rmpc-config edit";         # 快速编辑配置
      rmpc-backup = "rmpc-config backup";     # 快速备份配置
      rmpc-validate = "rmpc-config validate"; # 快速验证配置
    };

    programs.nushell.shellAliases = lib.mkIf config.programs.nushell.enable {
      rmpc-conf = "rmpc-config";              # 配置管理快捷方式
      rmpc-edit = "rmpc-config edit";         # 快速编辑配置
      rmpc-backup = "rmpc-config backup";     # 快速备份配置
      rmpc-validate = "rmpc-config validate"; # 快速验证配置
    };
  };
}
