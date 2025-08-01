#!/usr/bin/env bash

# Niri 音量控制脚本

case "$1" in
    "up")
        pamixer -i 5
        volume=$(pamixer --get-volume)
        notify-send "音量" "音量: ${volume}%" -h int:value:$volume
        ;;
    "down")
        pamixer -d 5
        volume=$(pamixer --get-volume)
        notify-send "音量" "音量: ${volume}%" -h int:value:$volume
        ;;
    "toggle")
        pamixer -t
        if pamixer --get-mute | grep -q "true"; then
            notify-send "音量" "静音已开启"
        else
            volume=$(pamixer --get-volume)
            notify-send "音量" "静音已关闭 - 音量: ${volume}%" -h int:value:$volume
        fi
        ;;
    *)
        echo "用法: $0 {up|down|toggle}"
        exit 1
        ;;
esac
