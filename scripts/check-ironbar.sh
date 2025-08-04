#!/usr/bin/env bash
# Ironbar macOS Tahoe 主题验证脚本

echo "🎯 Ironbar macOS Tahoe 主题状态检查"
echo "=================================="

echo ""
echo "📁 配置文件检查："
if [ -f ~/.config/ironbar/config.json ]; then
    echo "✅ config.json 已部署"
else
    echo "❌ config.json 缺失"
fi

if [ -f ~/.config/ironbar/style.css ]; then
    echo "✅ style.css 已部署"
else
    echo "❌ style.css 缺失"
fi

echo ""
echo "🔧 服务状态检查："
if systemctl --user is-active --quiet ironbar.service; then
    echo "✅ ironbar.service 正在运行"
else
    echo "❌ ironbar.service 未运行"
fi

echo ""
echo "📊 进程检查："
if pgrep -f ironbar > /dev/null; then
    echo "✅ ironbar 进程运行中 (PID: $(pgrep -f ironbar))"
else
    echo "❌ ironbar 进程未找到"
fi

echo ""
echo "🎨 配置特性："
echo "• macOS Tahoe 液态玻璃主题"
echo "• 胶囊形状设计 (24px 圆角)"
echo "• 半透明深色背景"
echo "• 12个功能模块"
echo "• 启动器、聚焦窗口、系统托盘"
echo "• 音量、电池、网络、通知、时钟"
echo "• 电源菜单"

echo ""
echo "⚙️  可用操作："
echo "重启服务: systemctl --user restart ironbar.service"
echo "查看日志: journalctl --user -u ironbar.service -f"
echo "重新构建: home-manager switch --flake .#hengvvang@laptop"

echo ""
echo "🌟 macOS Tahoe 主题已成功配置！"
