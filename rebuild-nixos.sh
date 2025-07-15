#!/usr/bin/env bash

# NixOS 配置重建脚本

set -e

echo "🔧 重建 NixOS 配置以启用虚拟网卡支持..."

# 进入配置目录
cd /home/hengvvang/inix

# 检查是否有未提交的更改
if git status --porcelain | grep -q .; then
    echo "📝 检测到配置更改，正在暂存..."
    git add .
    git status --short
fi

echo "🏗️  构建新配置..."
if sudo nixos-rebuild switch --flake .#laptop; then
    echo "✅ NixOS 配置重建成功！"
else
    echo "❌ NixOS 配置重建失败"
    exit 1
fi

echo "🏗️  构建 Home Manager 配置..."
if nix build .#homeConfigurations."hengvvang@laptop".activationPackage; then
    echo "✅ Home Manager 配置构建成功！"
    
    echo "🔄 激活 Home Manager 配置..."
    if ./result/activate; then
        echo "✅ Home Manager 配置激活成功！"
    else
        echo "❌ Home Manager 配置激活失败"
        exit 1
    fi
else
    echo "❌ Home Manager 配置构建失败"
    exit 1
fi

echo ""
echo "🎉 配置重建完成！"
echo ""
echo "📝 接下来的步骤："
echo "1. 重启系统（推荐）或重新登录"
echo "2. 启动 Clash Verge Rev"
echo "3. 在设置中启用 TUN 模式"
echo "4. 导入您的代理配置"
echo ""
echo "💡 Clash Verge Rev 现在应该支持虚拟网卡模式了！"
