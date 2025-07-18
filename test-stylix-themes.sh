#!/usr/bin/env bash

# Stylix 主题测试脚本
echo "🎨 测试 Stylix 主题配置..."

# 测试不同主题方案的构建
themes=("warm-white" "catppuccin-latte" "solarized-light" "one-light")

for theme in "${themes[@]}"; do
    echo "📝 测试主题: $theme"
    
    # 临时修改配置进行测试
    sed -i "s/scheme = \".*\";/scheme = \"$theme\";/" users/hengvvang/laptop.nix
    
    # 尝试构建
    if nix build .#homeConfigurations."hengvvang@laptop".activationPackage --no-link 2>/dev/null; then
        echo "✅ $theme - 构建成功"
    else
        echo "❌ $theme - 构建失败"
    fi
done

# 恢复到 warm-white 主题
sed -i 's/scheme = ".*";/scheme = "warm-white";/' users/hengvvang/laptop.nix
echo "🔄 已恢复到 warm-white 主题"

echo "🎉 主题测试完成！"
