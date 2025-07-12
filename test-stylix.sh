#!/usr/bin/env nix-shell
#! nix-shell -i bash -p nixos-rebuild

# Stylix 配置测试脚本

echo "检查 Stylix 配置..."

# 检查 flake.nix 语法
echo "验证 flake.nix 语法..."
nix flake check /home/hengvvang/inix || {
    echo "❌ flake.nix 语法检查失败"
    exit 1
}

echo "✅ flake.nix 语法正确"

# 构建 Home Manager 配置
echo "构建 Home Manager 配置..."
nix build /home/hengvvang/inix#homeConfigurations.hengvvang@laptop.activationPackage || {
    echo "❌ Home Manager 配置构建失败"
    exit 1
}

echo "✅ Home Manager 配置构建成功"

echo "🎉 Stylix 配置验证完成！"
echo ""
echo "下一步："
echo "1. 添加实际的壁纸文件到 home/profiles/theme/wallpapers/"
echo "2. 根据需要调整字体和应用程序目标"
echo "3. 运行 'home-manager switch --flake .#hengvvang@laptop' 应用配置"
