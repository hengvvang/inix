#!/usr/bin/env fish

# Hyprland 主题切换脚本
# 用法: ./theme-switcher.fish [theme-name]

set HYPR_CONFIG "$HOME/.config/hypr/hyprland.conf"
set THEME_DIR "$HOME/.config/hypr/themes"

# 可用主题列表
set THEMES "catppuccin" "macos-tahoe-glass"

function show_help
    echo "Hyprland 主题切换器"
    echo ""
    echo "用法: $argv[1] [主题名称]"
    echo ""
    echo "可用主题:"
    for theme in $THEMES
        if test -f "$THEME_DIR/$theme.conf"
            echo "  ✓ $theme"
        else
            echo "  ✗ $theme (未找到文件)"
        end
    end
    echo ""
    echo "示例:"
    echo "  $argv[1] catppuccin          # 切换到 Catppuccin 主题"
    echo "  $argv[1] macos-tahoe-glass   # 切换到 macOS Tahoe 玻璃主题"
    echo ""
end

function get_current_theme
    if test -f "$HYPR_CONFIG"
        set current_line (grep "source.*themes/" "$HYPR_CONFIG" | head -n 1)
        if test -n "$current_line"
            echo $current_line | sed 's/.*themes\/\([^.]*\)\.conf.*/\1/'
        else
            echo "未知"
        end
    else
        echo "配置文件不存在"
    end
end

function switch_theme
    set theme_name $argv[1]
    set theme_file "$THEME_DIR/$theme_name.conf"
    
    # 检查主题文件是否存在
    if not test -f "$theme_file"
        echo "❌ 错误: 主题文件 '$theme_file' 不存在"
        return 1
    end
    
    # 检查配置文件是否存在
    if not test -f "$HYPR_CONFIG"
        echo "❌ 错误: Hyprland 配置文件 '$HYPR_CONFIG' 不存在"
        return 1
    end
    
    # 备份原配置
    cp "$HYPR_CONFIG" "$HYPR_CONFIG.backup.$(date +%Y%m%d_%H%M%S)"
    
    # 更新主题引用
    sed -i "s|source = ~/.config/hypr/themes/.*\.conf|source = ~/.config/hypr/themes/$theme_name.conf|g" "$HYPR_CONFIG"
    
    echo "✅ 主题已切换到: $theme_name"
    echo "📄 配置文件: $theme_file"
    
    # 重新加载 Hyprland 配置
    if command -v hyprctl >/dev/null
        echo "🔄 正在重新加载 Hyprland 配置..."
        hyprctl reload
        if test $status -eq 0
            echo "✅ 配置重新加载成功"
        else
            echo "⚠️  配置重新加载失败，请手动重启 Hyprland"
        end
    else
        echo "⚠️  hyprctl 未找到，请手动重新加载配置"
    end
end

function show_current_theme
    set current (get_current_theme)
    echo "📋 当前主题: $current"
    
    if test "$current" != "未知"
        set theme_file "$THEME_DIR/$current.conf"
        if test -f "$theme_file"
            echo "📄 主题文件: $theme_file"
            echo "📅 修改时间: $(stat -c %y "$theme_file" 2>/dev/null || stat -f %Sm "$theme_file" 2>/dev/null || echo "未知")"
        end
    end
end

# 主逻辑
if test (count $argv) -eq 0
    show_current_theme
    echo ""
    show_help
    exit 0
end

set command $argv[1]

switch $command
    case "help" "-h" "--help"
        show_help
        
    case "list" "-l" "--list"
        echo "可用主题:"
        for theme in $THEMES
            if test -f "$THEME_DIR/$theme.conf"
                if test "$theme" = (get_current_theme)
                    echo "  ➤ $theme (当前)"
                else
                    echo "    $theme"
                end
            else
                echo "    $theme (未找到)"
            end
        end
        
    case "current" "-c" "--current"
        show_current_theme
        
    case "*"
        # 尝试切换到指定主题
        if contains $command $THEMES
            switch_theme $command
        else
            echo "❌ 错误: 未知主题 '$command'"
            echo ""
            show_help
            exit 1
        end
end
