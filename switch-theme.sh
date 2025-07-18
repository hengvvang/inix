#!/usr/bin/env bash

# 🎨 Stylix 主题快速切换脚本
# 使用方法: ./switch-theme.sh [主题名称]

set -euo pipefail

LAPTOP_CONFIG="users/hengvvang/laptop.nix"
BACKUP_CONFIG="users/hengvvang/laptop.nix.backup"

# 可用主题列表
declare -A THEMES=(
    ["1"]="warm-white:🤍 简约白色暖色调"
    ["2"]="cool-blue:🩵 冷静蓝色主题"
    ["3"]="forest-green:🌿 森林绿色主题"
    ["4"]="sunset-orange:🧡 日落橙色主题"
    ["5"]="lavender-purple:💜 薰衣草紫色主题"
    ["6"]="dark-elegant:🖤 优雅深色主题"
    ["7"]="gruvbox-light:🔥 Gruvbox 亮色"
    ["8"]="gruvbox-dark-hard:🔥 Gruvbox 深色"
    ["9"]="solarized-light:☀️ Solarized 亮色"
    ["10"]="solarized-dark:🌙 Solarized 深色"
    ["11"]="nord:❄️ Nord 北欧风"
    ["12"]="dracula:🧛 Dracula 吸血鬼"
    ["13"]="tokyo-night:🌃 东京夜色"
    ["14"]="catppuccin-latte:☕ Catppuccin 亮色"
    ["15"]="catppuccin-mocha:🍫 Catppuccin 深色"
    ["16"]="one-light:💡 Atom One 亮色"
    ["17"]="one-dark:🌑 Atom One 深色"
    ["18"]="auto:🔄 从壁纸自动生成"
)

# 亮色主题列表（需要设置 polarity = "light"）
LIGHT_THEMES=(
    "warm-white" "cool-blue" "forest-green" "sunset-orange" 
    "lavender-purple" "gruvbox-light" "solarized-light" 
    "catppuccin-latte" "one-light"
)

# 显示主题选择菜单
show_menu() {
    echo "🎨 Stylix 主题切换器"
    echo "===================="
    for key in $(echo "${!THEMES[@]}" | tr ' ' '\n' | sort -n); do
        IFS=':' read -r theme_name theme_desc <<< "${THEMES[$key]}"
        echo "[$key] $theme_desc"
    done
    echo ""
}

# 检查主题是否为亮色主题
is_light_theme() {
    local theme=$1
    for light_theme in "${LIGHT_THEMES[@]}"; do
        if [[ "$theme" == "$light_theme" ]]; then
            return 0
        fi
    done
    return 1
}

# 切换主题
switch_theme() {
    local theme_name=$1
    local polarity
    
    # 确定极性
    if is_light_theme "$theme_name"; then
        polarity="light"
    else
        polarity="dark"
    fi
    
    echo "🔄 切换到主题: $theme_name (极性: $polarity)"
    
    # 备份当前配置
    cp "$LAPTOP_CONFIG" "$BACKUP_CONFIG"
    
    # 更新配置文件
    sed -i "s/scheme = \"[^\"]*\"/scheme = \"$theme_name\"/" "$LAPTOP_CONFIG"
    sed -i "s/polarity = \"[^\"]*\"/polarity = \"$polarity\"/" "$LAPTOP_CONFIG"
    
    echo "✅ 配置文件已更新"
    
    # 构建配置
    echo "🔨 构建新配置..."
    if nix build .#homeConfigurations."hengvvang@laptop".activationPackage; then
        echo "✅ 构建成功"
        
        # 询问是否立即激活
        read -p "🚀 是否立即激活新主题? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo "🎯 激活新主题..."
            ./result/activate
            echo "✨ 主题切换完成！"
        else
            echo "📝 配置已准备就绪，运行 './result/activate' 来应用主题"
        fi
    else
        echo "❌ 构建失败，恢复备份配置"
        mv "$BACKUP_CONFIG" "$LAPTOP_CONFIG"
        exit 1
    fi
}

# 主程序
main() {
    if [[ $# -eq 1 ]]; then
        # 直接指定主题名称
        theme_name=$1
        if is_light_theme "$theme_name"; then
            echo "🌞 检测到亮色主题: $theme_name"
        else
            echo "🌙 检测到深色主题: $theme_name"
        fi
        switch_theme "$theme_name"
    else
        # 显示交互式菜单
        show_menu
        read -p "请选择主题编号 (1-18): " choice
        
        if [[ -n "${THEMES[$choice]:-}" ]]; then
            IFS=':' read -r theme_name theme_desc <<< "${THEMES[$choice]}"
            echo "🎯 选择了: $theme_desc"
            switch_theme "$theme_name"
        else
            echo "❌ 无效选择: $choice"
            exit 1
        fi
    fi
}

# 运行主程序
main "$@"
