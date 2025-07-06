#!/usr/bin/env bash

# 快速修复 NixOS 配置中的重复定义问题

echo "开始修复 NixOS 配置中的重复定义问题..."

# 修复 printing/drivers.nix
echo "修复 printing/drivers.nix..."
if [ -f "system/services/drivers/printing/drivers.nix" ]; then
    # 检查是否有重复的 services.printing.drivers 定义
    if grep -c "services\.printing\.drivers" system/services/drivers/printing/drivers.nix > 1; then
        echo "发现重复的 services.printing.drivers 定义，正在修复..."
        # 这里需要手动修复，因为每个文件的结构可能不同
        echo "请手动检查并修复 system/services/drivers/printing/drivers.nix"
    fi
fi

# 检查所有驱动模块是否还有重复定义
echo "检查剩余的重复定义..."

find system/services/drivers -name "*.nix" -exec bash -c '
    file="$1"
    echo "检查文件: $file"
    
    # 检查常见的重复定义
    attrs=("environment.systemPackages" "boot.kernelModules" "services.udev.extraRules" "boot.supportedFilesystems" "boot.kernel.sysctl")
    
    for attr in "${attrs[@]}"; do
        count=$(grep -c "^[[:space:]]*$attr" "$file" 2>/dev/null || echo 0)
        if [ "$count" -gt 1 ]; then
            echo "  ⚠️  发现重复定义: $attr (出现 $count 次)"
        fi
    done
' _ {} \;

echo "检查完成！"

# 提供重构建议
cat << 'EOF'

=== 重构建议 ===

1. 立即修复（临时方案）：
   - 手动合并重复的属性定义
   - 使用 lib.mkMerge 或 lib.flatten

2. 长期重构（推荐方案）：
   - 将每个驱动类别合并为单个文件
   - 使用提供的 module-helpers.nix 辅助函数
   - 参考 touchpad-refactored.nix 示例

3. 测试重构模块：
   # 在 default.nix 中替换原有模块引用
   imports = [
     # ./touchpad/default.nix  # 注释掉原有模块
     ./touchpad-refactored.nix  # 使用重构版本
   ];

4. 逐步迁移：
   - 一次重构一个驱动类别
   - 测试每个模块后再继续下一个
   - 保留原文件作为备份

EOF
