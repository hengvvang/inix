#!/usr/bin/env bash

# Clash Verge Rev 虚拟网卡模式用户层修复脚本

set -e

echo "🔧 正在配置 Clash Verge Rev 虚拟网卡模式支持（用户层）..."

# 检查当前用户是否在 tun 组中
if groups $USER | grep -q '\btun\b'; then
    echo "✅ 用户 $USER 已在 tun 组中"
else
    echo "⚠️  用户 $USER 不在 tun 组中，需要管理员权限添加"
    if command -v sudo &> /dev/null; then
        echo "🔧 尝试将用户添加到 tun 组..."
        sudo groupadd -f tun
        sudo usermod -a -G tun $USER
        echo "✅ 已将用户 $USER 添加到 tun 组"
        echo "⚠️  需要重新登录或重启以生效"
    else
        echo "❌ 无法自动添加到 tun 组，请手动运行："
        echo "   sudo groupadd -f tun"
        echo "   sudo usermod -a -G tun $USER"
    fi
fi

# 检查 TUN 设备
if [[ -c /dev/net/tun ]]; then
    echo "✅ TUN 设备存在: /dev/net/tun"
    
    # 检查权限
    if [[ -r /dev/net/tun && -w /dev/net/tun ]]; then
        echo "✅ TUN 设备权限正确"
    else
        echo "⚠️  TUN 设备权限可能不正确"
        ls -la /dev/net/tun
    fi
else
    echo "❌ TUN 设备不存在，需要管理员权限创建"
    if command -v sudo &> /dev/null; then
        echo "🔧 尝试创建 TUN 设备..."
        sudo mkdir -p /dev/net
        sudo mknod /dev/net/tun c 10 200
        sudo chmod 666 /dev/net/tun
        echo "✅ TUN 设备已创建"
    else
        echo "请手动运行以下命令："
        echo "   sudo mkdir -p /dev/net"
        echo "   sudo mknod /dev/net/tun c 10 200"
        echo "   sudo chmod 666 /dev/net/tun"
    fi
fi

# 检查内核模块
echo "📡 检查内核模块..."
if lsmod | grep -q "^tun "; then
    echo "✅ TUN 模块已加载"
else
    echo "⚠️  TUN 模块未加载，尝试加载..."
    if command -v sudo &> /dev/null; then
        sudo modprobe tun
        echo "✅ TUN 模块已加载"
    else
        echo "请手动运行: sudo modprobe tun"
    fi
fi

# 检查系统参数
echo "⚙️  检查系统网络参数..."
if [[ $(sysctl -n net.ipv4.ip_forward 2>/dev/null) == "1" ]]; then
    echo "✅ IP 转发已启用"
else
    echo "⚠️  IP 转发未启用，尝试启用..."
    if command -v sudo &> /dev/null; then
        sudo sysctl -w net.ipv4.ip_forward=1
        echo "✅ IP 转发已启用（临时）"
    else
        echo "请手动运行: sudo sysctl -w net.ipv4.ip_forward=1"
    fi
fi

# 检查 clash 客户端
CLASH_CLIENTS=("clash-verge-rev" "clash-nyanpasu" "clash-meta")
for client in "${CLASH_CLIENTS[@]}"; do
    if command -v "$client" &> /dev/null; then
        echo "✅ 检测到 $client 已安装"
        
        CLASH_BINARY=$(which "$client")
        echo "📍 $client 位置: $CLASH_BINARY"
        
        # 检查 capabilities
        if command -v getcap &> /dev/null; then
            CAPS=$(getcap "$CLASH_BINARY" 2>/dev/null || true)
            if [[ -n "$CAPS" ]]; then
                echo "🔐 当前权限: $CAPS"
            else
                echo "⚠️  未设置特殊权限，尝试设置..."
                if command -v sudo &> /dev/null; then
                    sudo setcap cap_net_admin,cap_net_raw=+eip "$CLASH_BINARY"
                    echo "✅ $client 权限设置完成"
                else
                    echo "请手动运行: sudo setcap cap_net_admin,cap_net_raw=+eip $CLASH_BINARY"
                fi
            fi
        else
            echo "⚠️  无法检查权限（getcap 不可用）"
        fi
    else
        echo "⚠️  未检测到 $client"
    fi
done

if ! command -v clash-verge-rev &> /dev/null && ! command -v clash-nyanpasu &> /dev/null && ! command -v clash-meta &> /dev/null; then
    echo "💡 请确保通过 Nix 配置正确安装 Clash 客户端"
fi

echo ""
echo "🎉 检查完成！"
echo ""
echo "📝 当前状态："
echo "- 用户组: $(groups $USER)"
echo "- TUN 设备: $(ls -la /dev/net/tun 2>/dev/null || echo '不存在')"
echo "- TUN 模块: $(lsmod | grep -q '^tun ' && echo '已加载' || echo '未加载')"
echo "- IP 转发: $(sysctl -n net.ipv4.ip_forward 2>/dev/null || echo '未知')"
echo ""
echo "💡 如果虚拟网卡模式仍然无法使用："
echo "1. 重新登录系统以应用用户组更改"
echo "2. 重建并切换 NixOS 配置"
echo "3. 重启 Clash Verge Rev"
echo "4. 检查 Clash Verge Rev 的日志输出"
