#!/usr/bin/env bash

# Clash Verge Rev 虚拟网卡模式修复脚本

set -e

echo "🔧 正在配置 Clash Verge Rev 虚拟网卡模式支持..."

# 检查是否是 root 用户或有 sudo 权限
if [[ $EUID -eq 0 ]]; then
    echo "✅ 检测到 root 权限"
elif command -v sudo &> /dev/null; then
    echo "✅ 检测到 sudo 权限"
    SUDO="sudo"
else
    echo "❌ 需要 root 权限来配置虚拟网卡支持"
    exit 1
fi

# 加载 TUN 模块
echo "📡 加载 TUN/TAP 内核模块..."
$SUDO modprobe tun
$SUDO modprobe tap

# 检查 TUN 设备
if [[ ! -c /dev/net/tun ]]; then
    echo "📁 创建 TUN 设备目录..."
    $SUDO mkdir -p /dev/net
    $SUDO mknod /dev/net/tun c 10 200
fi

# 设置 TUN 设备权限
echo "🔐 设置 TUN 设备权限..."
$SUDO chmod 666 /dev/net/tun

# 创建 tun 组（如果不存在）
if ! getent group tun > /dev/null 2>&1; then
    echo "👥 创建 tun 用户组..."
    $SUDO groupadd tun
fi

# 将当前用户添加到 tun 组
echo "👤 将用户 $USER 添加到 tun 组..."
$SUDO usermod -a -G tun $USER

# 检查并设置系统参数
echo "⚙️  配置系统网络参数..."
$SUDO sysctl -w net.ipv4.ip_forward=1
$SUDO sysctl -w net.ipv6.conf.all.forwarding=1

# 创建持久化配置
echo "💾 创建持久化配置..."
$SUDO tee /etc/sysctl.d/99-tun-support.conf > /dev/null << EOF
# TUN/TAP 虚拟网卡支持
net.ipv4.ip_forward = 1
net.ipv6.conf.all.forwarding = 1
net.core.default_qdisc = fq
net.ipv4.tcp_congestion_control = bbr
EOF

# 创建 udev 规则
echo "📋 创建 udev 规则..."
$SUDO tee /etc/udev/rules.d/99-tun.rules > /dev/null << EOF
# TUN/TAP 设备权限规则
KERNEL=="tun", GROUP="tun", MODE="0666"
KERNEL=="tap[0-9]*", GROUP="tun", MODE="0666"
SUBSYSTEM=="misc", KERNEL=="tun", GROUP="tun", MODE="0666"
EOF

# 重新加载 udev 规则
echo "🔄 重新加载 udev 规则..."
$SUDO udevadm control --reload-rules
$SUDO udevadm trigger

# 检查 clash-verge-rev 是否已安装
if command -v clash-verge-rev &> /dev/null; then
    echo "✅ 检测到 Clash Verge Rev 已安装"
    
    # 为 clash-verge-rev 设置 capabilities
    CLASH_BINARY=$(which clash-verge-rev)
    echo "🔧 为 Clash Verge Rev 设置网络权限..."
    $SUDO setcap cap_net_admin,cap_net_raw=+eip "$CLASH_BINARY"
    
    # 验证 capabilities 设置
    if getcap "$CLASH_BINARY" | grep -q "cap_net_admin,cap_net_raw"; then
        echo "✅ Clash Verge Rev 权限设置成功"
    else
        echo "⚠️  Clash Verge Rev 权限设置可能失败，但可以尝试继续使用"
    fi
else
    echo "⚠️  未检测到 Clash Verge Rev，请确保已正确安装"
fi

echo ""
echo "🎉 配置完成！"
echo ""
echo "📝 接下来的步骤："
echo "1. 重新登录或重启系统以应用用户组更改"
echo "2. 打开 Clash Verge Rev"
echo "3. 在设置中启用 TUN 模式"
echo "4. 导入您的代理配置"
echo ""
echo "💡 如果仍然无法启用虚拟网卡模式，请："
echo "- 确保重新登录系统"
echo "- 检查防火墙设置"
echo "- 查看 Clash Verge Rev 的日志输出"
echo ""
echo "🔧 如果问题仍然存在，可以运行以下命令检查："
echo "   ls -la /dev/net/tun"
echo "   groups $USER"
echo "   sysctl net.ipv4.ip_forward"
