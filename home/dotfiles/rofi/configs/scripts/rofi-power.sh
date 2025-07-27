#!/usr/bin/env bash

# Rofi 电源菜单
# 简单的系统电源管理

set -euo pipefail

# 电源选项
options="🔒 锁定\n⏾ 休眠\n💤 挂起\n🔄 重启\n⏻ 关机\n🚪 注销"

# 显示菜单并获取选择
selected=$(echo -e "$options" | rofi -dmenu -p "电源" -theme-str 'window {width: 300px;}')

# 执行相应操作
case $selected in
    "🔒 锁定")
        loginctl lock-session
        ;;
    "⏾ 休眠")
        systemctl hibernate
        ;;
    "💤 挂起")
        systemctl suspend
        ;;
    "🔄 重启")
        systemctl reboot
        ;;
    "⏻ 关机")
        systemctl poweroff
        ;;
    "🚪 注销")
        loginctl terminate-session ""
        ;;
esac
