#!/usr/bin/env fish

# Hyprland 玻璃主题测试脚本

echo "🎨 macOS Tahoe 流体玻璃主题测试"
echo ""

# 检查 Hyprland 是否运行
if not pgrep -x "Hyprland" >/dev/null
    echo "❌ Hyprland 未运行"
    exit 1
end

echo "✅ Hyprland 正在运行"

# 检查主题文件是否存在
set theme_file "$HOME/.config/hypr/themes/macos-tahoe-glass.conf"
if test -f "$theme_file"
    echo "✅ 玻璃主题文件存在: $theme_file"
else
    echo "❌ 玻璃主题文件不存在: $theme_file"
    exit 1
end

# 检查配置是否正确引用主题
set config_file "$HOME/.config/hypr/hyprland.conf"
if test -f "$config_file"
    set theme_line (grep "macos-tahoe-glass.conf" "$config_file")
    if test -n "$theme_line"
        echo "✅ 主配置文件正确引用玻璃主题"
    else
        echo "⚠️  主配置文件未引用玻璃主题"
        echo "当前主题引用: $(grep 'source.*themes/' "$config_file" | head -n 1)"
    end
else
    echo "❌ Hyprland 配置文件不存在"
    exit 1
end

echo ""
echo "🔍 检查关键配置..."

# 检查模糊是否启用
set blur_enabled (hyprctl getoption decoration:blur:enabled -j | jq -r '.int')
if test "$blur_enabled" = "1"
    echo "✅ 模糊效果已启用"
else
    echo "❌ 模糊效果未启用"
end

# 检查模糊大小
set blur_size (hyprctl getoption decoration:blur:size -j | jq -r '.int')
echo "📏 模糊大小: $blur_size px"

# 检查模糊传递次数
set blur_passes (hyprctl getoption decoration:blur:passes -j | jq -r '.int')
echo "🔄 模糊传递: $blur_passes 次"

# 检查圆角
set rounding (hyprctl getoption decoration:rounding -j | jq -r '.int')
echo "⭕ 窗口圆角: $rounding px"

# 检查透明度
set active_opacity (hyprctl getoption decoration:active_opacity -j | jq -r '.float')
set inactive_opacity (hyprctl getoption decoration:inactive_opacity -j | jq -r '.float')
echo "👁️  活动窗口透明度: $active_opacity"
echo "👁️  非活动窗口透明度: $inactive_opacity"

echo ""
echo "🎯 建议的测试步骤:"
echo "1. 打开一个终端窗口 (Super+Return)"
echo "2. 打开文件管理器 (Super+F)"
echo "3. 在窗口后面放置一张图片作为背景"
echo "4. 观察窗口的模糊和透明效果"
echo "5. 尝试浮动窗口 (右键标题栏 -> Float)"
echo "6. 测试工作区切换动画"
echo ""

# 检查必要的依赖
echo "🔧 检查依赖..."

set missing_deps
if not command -v jq >/dev/null
    set missing_deps $missing_deps "jq"
end

if test (count $missing_deps) -gt 0
    echo "⚠️  缺少依赖: $missing_deps"
    echo "请安装: sudo pacman -S $missing_deps"
else
    echo "✅ 所有依赖都已安装"
end

echo ""
echo "📋 快速命令:"
echo "  切换主题: ~/.config/hypr/scripts/theme-switcher.fish macos-tahoe-glass"
echo "  切换回原主题: ~/.config/hypr/scripts/theme-switcher.fish catppuccin"
echo "  重新加载配置: hyprctl reload"
echo "  临时禁用模糊: hyprctl keyword decoration:blur:enabled false"
echo ""
echo "🎉 测试完成！享受您的玻璃主题吧！"
