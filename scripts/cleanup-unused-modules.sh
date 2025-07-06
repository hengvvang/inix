#!/usr/bin/env bash

# 清理未使用的模块文件脚本
# 作者：Assistant
# 用途：移除项目中未使用的模块文件和目录

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "🧹 开始清理未使用的模块文件..."
echo "项目根目录: $PROJECT_ROOT"

# 切换到项目根目录
cd "$PROJECT_ROOT"

# 1. 移除重复的 touchpad-refactored.nix 文件
echo ""
echo "📁 清理重复的触摸板模块文件..."
if [ -f "system/services/drivers/touchpad-refactored.nix" ]; then
    echo "移除: system/services/drivers/touchpad-refactored.nix"
    rm -f "system/services/drivers/touchpad-refactored.nix"
    echo "✅ 已移除 touchpad-refactored.nix"
else
    echo "ℹ️  touchpad-refactored.nix 已不存在"
fi

# 2. 检查并清理空的预留文件（可选）
echo ""
echo "📁 检查预留文件..."

check_empty_file() {
    local file="$1"
    local description="$2"
    
    if [ -f "$file" ]; then
        # 检查文件是否只包含注释和基本结构
        if grep -q "预留文件\|预留配置" "$file"; then
            echo "发现预留文件: $file ($description)"
            echo "  内容:"
            head -3 "$file" | sed 's/^/    /'
            echo "  ⚠️  这是预留文件，建议保留以备将来扩展"
        fi
    fi
}

check_empty_file "overlays/default.nix" "Overlays 配置"
check_empty_file "pkgs/default.nix" "自定义包"

# 3. 检查可能未使用的目录
echo ""
echo "📁 检查可能未被引用的模块目录..."

check_module_usage() {
    local module_path="$1"
    local module_name="$2"
    
    if [ -d "$module_path" ]; then
        # 在主要配置文件中搜索该模块的引用
        local found=false
        
        # 搜索 import 语句
        if grep -r "\./$module_name" system/ hosts/ home/ >/dev/null 2>&1; then
            found=true
        fi
        
        # 搜索配置选项引用
        if grep -r "$module_name\.enable" system/ hosts/ home/ >/dev/null 2>&1; then
            found=true
        fi
        
        if [ "$found" = false ]; then
            echo "⚠️  可能未使用的模块: $module_path"
            echo "  请手动检查是否真的未使用"
        else
            echo "✅ 模块已被引用: $module_name"
        fi
    fi
}

# 检查一些可能未使用的模块
echo "检查硬件驱动模块引用..."
check_module_usage "system/services/drivers/wacom" "wacom"
check_module_usage "system/services/drivers/ethernet" "ethernet"
check_module_usage "system/services/drivers/intel" "intel"
check_module_usage "system/services/drivers/amd" "amd"

# 4. 清理可能的构建产物
echo ""
echo "📁 清理构建产物..."
if [ -L "result" ]; then
    echo "移除符号链接: result"
    rm -f result
    echo "✅ 已移除 result 符号链接"
else
    echo "ℹ️  没有找到 result 符号链接"
fi

# 5. 显示清理总结
echo ""
echo "🎉 清理完成！"
echo ""
echo "📋 清理总结："
echo "  ✅ 移除了重复的 touchpad-refactored.nix"
echo "  ✅ 清理了构建产物"
echo "  ⚠️  预留文件已保留（建议用于将来扩展）"
echo ""
echo "💡 建议："
echo "  1. 运行 'git status' 查看变更"
echo "  2. 如果确认无误，可以提交这些清理"
echo "  3. 可以考虑移除真正未使用的驱动模块目录"
echo ""
echo "⚠️  重要提醒："
echo "  某些模块可能在主机配置之外被间接引用"
echo "  建议在移除模块前先进行完整的系统构建测试"
