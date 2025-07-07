#!/usr/bin/env bash

# Clash 代理服务快速配置脚本

set -e

echo "🚀 Clash 代理服务配置助手"
echo "=========================="

# 检查是否提供了订阅链接
if [ -z "$1" ]; then
    echo "❌ 请提供订阅链接"
    echo "用法: $0 <订阅链接>"
    echo "示例: $0 https://your-subscription-url"
    exit 1
fi

SUBSCRIPTION_URL="$1"
CONFIG_FILE="/etc/clash/config.yaml"

echo "📥 正在下载订阅配置..."

# 创建配置目录
sudo mkdir -p /etc/clash

# 下载订阅配置
if sudo curl -L -o "$CONFIG_FILE" "$SUBSCRIPTION_URL"; then
    echo "✅ 订阅配置下载成功"
else
    echo "❌ 订阅配置下载失败"
    exit 1
fi

echo "🔧 正在启动 Clash 服务..."

# 启动并启用服务
sudo systemctl enable clash
sudo systemctl start clash

# 检查服务状态
if sudo systemctl is-active --quiet clash; then
    echo "✅ Clash 服务启动成功"
    echo ""
    echo "🌐 Web UI 地址: http://localhost:9090"
    echo "🔗 代理地址: http://127.0.0.1:7890"
    echo "🧦 SOCKS5 地址: socks5://127.0.0.1:7890"
    echo ""
    echo "📊 查看服务状态: sudo systemctl status clash"
    echo "📋 查看日志: sudo journalctl -u clash -f"
else
    echo "❌ Clash 服务启动失败"
    echo "📋 查看错误日志: sudo journalctl -u clash -e"
    exit 1
fi
