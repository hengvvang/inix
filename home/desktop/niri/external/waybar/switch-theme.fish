#!/usr/bin/env fish

# Waybar 主题切换脚本
# 用法: ./switch-theme.fish [rose-pine|glass]

set script_dir (dirname (realpath (status --current-filename)))
set nix_file "$script_dir/default.nix"

function show_usage
    echo "用法: $argv[0] [rose-pine|glass]"
    echo "  rose-pine  - 切换到 Rose Pine 主题"
    echo "  glass      - 切换到简约玻璃主题"
    echo "  不带参数时显示当前主题"
end

function get_current_theme
    set current_theme (grep 'waybarTheme = ' "$nix_file" | sed 's/.*waybarTheme = "\([^"]*\)".*/\1/')
    echo "$current_theme"
end

function switch_theme
    set target_theme $argv[1]
    
    if test "$target_theme" != "rose-pine" -a "$target_theme" != "glass"
        echo "错误: 不支持的主题 '$target_theme'"
        show_usage
        return 1
    end
    
    set current_theme (get_current_theme)
    
    if test "$current_theme" = "$target_theme"
        echo "当前已经是 $target_theme 主题"
        return 0
    end
    
    # 替换主题设置
    sed -i "s/waybarTheme = \"$current_theme\"/waybarTheme = \"$target_theme\"/" "$nix_file"
    
    echo "主题已切换为: $target_theme"
    echo "请运行以下命令应用更改:"
    echo "  home-manager switch"
    echo "或者如果您使用 flake:"
    echo "  nix build .#homeConfigurations.\"hengvvang@laptop\".activationPackage && ./result/activate"
end

# 主逻辑
if test (count $argv) -eq 0
    set current_theme (get_current_theme)
    echo "当前主题: $current_theme"
    echo ""
    echo "可用主题:"
    echo "  rose-pine  - Rose Pine 主题 (原有主题)"
    echo "  glass      - 简约玻璃主题 (新主题)"
else
    switch_theme $argv[1]
end
