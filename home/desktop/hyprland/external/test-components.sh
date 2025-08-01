#!/usr/bin/env bash

# ========================================
# Hyprland 组件测试脚本
# ========================================

echo "🧪 测试 Hyprland 配置组件..."

# 测试 Hyprland
echo "🖥️  测试 Hyprland..."
if hyprctl version >/dev/null 2>&1; then
    echo "✅ Hyprland 正常运行"
else
    echo "❌ Hyprland 未运行"
fi

# 测试 Waybar
echo "📊 测试 Waybar..."
if pgrep waybar >/dev/null; then
    echo "✅ Waybar 正在运行"
else
    echo "❌ Waybar 未运行"
fi

# 测试 Dunst
echo "🔔 测试 Dunst..."
if pgrep dunst >/dev/null; then
    echo "✅ Dunst 正在运行"
else
    echo "❌ Dunst 未运行"
fi

# 测试 Rofi
echo "🚀 测试 Rofi..."
if command -v rofi >/dev/null 2>&1; then
    echo "✅ Rofi 已安装"
else
    echo "❌ Rofi 未安装"
fi

# 测试快捷键工具
echo "🔧 测试系统工具..."
tools=("grimblast" "wl-clipboard" "pamixer" "brightnessctl" "playerctl")
for tool in "${tools[@]}"; do
    if command -v "$tool" >/dev/null 2>&1; then
        echo "✅ $tool 可用"
    else
        echo "❌ $tool 不可用"
    fi
done

# 测试配置文件
echo "📝 检查配置文件..."
configs=(
    "~/.config/hypr/hyprland.conf"
    "~/.config/waybar/config"
    "~/.config/waybar/style.css"
    "~/.config/dunst/dunstrc"
    "~/.config/rofi/config.rasi"
)

for config in "${configs[@]}"; do
    expanded_path=$(eval echo "$config")
    if [[ -f "$expanded_path" ]]; then
        echo "✅ $config 存在"
    else
        echo "❌ $config 缺失"
    fi
done

echo ""
echo "🎉 测试完成！如果看到红色的 ❌，请检查对应的组件。"
echo "💡 你可以使用以下快捷键："
echo "   Super + Enter    - 打开终端"
echo "   Super            - 应用启动器"
echo "   Super + E        - 文件管理器"
echo "   Super + L        - 锁定屏幕"
echo "   Print            - 截图"
