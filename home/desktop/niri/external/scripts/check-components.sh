#!/usr/bin/env bash

# Niri 桌面环境组件检查脚本

echo "🔍 检查 Niri 桌面环境组件..."
echo "=================================="

# 检查核心组件
components=(
    "niri"
    "waybar"
    "dunst"
    "fuzzel"
    "nm-applet"
    "blueman-applet"
    "xwayland-satellite"
    "ghostty"
    "swaylock"
    "swaybg"
)

missing_components=()

for component in "${components[@]}"; do
    if command -v "$component" >/dev/null 2>&1; then
        echo "✅ $component - 已安装"
    else
        echo "❌ $component - 未找到"
        missing_components+=("$component")
    fi
done

echo ""
echo "🔧 检查特殊组件..."

# 检查 polkit 代理
if [ -f "/run/current-system/sw/bin/polkit-kde-authentication-agent-1" ]; then
    echo "✅ polkit-kde-authentication-agent-1 - 已安装"
else
    echo "❌ polkit-kde-authentication-agent-1 - 未找到"
    missing_components+=("polkit-kde-authentication-agent-1")
fi

echo ""
if [ ${#missing_components[@]} -eq 0 ]; then
    echo "🎉 所有组件都已正确安装！"
    echo ""
    echo "📋 使用说明："
    echo "- Super + T: 打开终端 (ghostty)"
    echo "- Super + D: 应用启动器 (fuzzel)"
    echo "- Super + E: 文件管理器"
    echo "- Super + B: 浏览器"
    echo "- Super + Q: 关闭窗口"
    echo "- Super + Alt + L: 锁屏"
else
    echo "⚠️  缺少以下组件："
    for component in "${missing_components[@]}"; do
        echo "   - $component"
    done
    echo ""
    echo "请重新构建并应用 Home Manager 配置："
    echo "  home-manager switch --flake .#hengvvang@laptop"
fi
