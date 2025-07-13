#!/usr/bin/env bash

echo "=== 嵌入式开发环境检查 ==="
echo

echo "1. 检查用户组配置："
echo "当前用户: $USER"
echo "用户组: $(groups $USER)"
echo

echo "2. 检查关键组是否存在："
if getent group dialout > /dev/null; then
    echo "✅ dialout 组存在"
else
    echo "❌ dialout 组不存在"
fi

if getent group plugdev > /dev/null; then
    echo "✅ plugdev 组存在"
else
    echo "❌ plugdev 组不存在"
fi
echo

echo "3. 检查用户是否在必要组中："
if groups $USER | grep -q "dialout"; then
    echo "✅ 用户在 dialout 组中"
else
    echo "❌ 用户不在 dialout 组中"
fi

if groups $USER | grep -q "plugdev"; then
    echo "✅ 用户在 plugdev 组中"
else
    echo "❌ 用户不在 plugdev 组中"
fi
echo

echo "4. 检查调试工具："
command -v openocd >/dev/null && echo "✅ openocd 已安装" || echo "❌ openocd 未安装"
command -v gdb >/dev/null && echo "✅ gdb 已安装" || echo "❌ gdb 未安装"
command -v lsusb >/dev/null && echo "✅ lsusb 已安装" || echo "❌ lsusb 未安装"
echo

echo "5. 检查 USB 调试设备（需要插入设备）："
echo "USB 设备列表："
lsusb | grep -E "(ST-Link|J-Link|CMSIS|Black Magic)" || echo "未检测到已知调试器"
echo

echo "6. 检查串口设备："
ls -la /dev/ttyUSB* /dev/ttyACM* 2>/dev/null | head -5 || echo "未检测到串口设备"
echo

echo "=== 检查完成 ==="
echo "如果发现问题，请重新构建并部署 NixOS 配置。"
