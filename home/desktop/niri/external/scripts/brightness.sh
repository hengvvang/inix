#!/usr/bin/env bash

# Niri 亮度控制脚本

case "$1" in
    "up")
        brightnessctl set +10%
        brightness=$(brightnessctl get)
        max_brightness=$(brightnessctl max)
        percentage=$((brightness * 100 / max_brightness))
        notify-send "亮度" "亮度: ${percentage}%" -h int:value:$percentage
        ;;
    "down")
        brightnessctl set 10%-
        brightness=$(brightnessctl get)
        max_brightness=$(brightnessctl max)
        percentage=$((brightness * 100 / max_brightness))
        notify-send "亮度" "亮度: ${percentage}%" -h int:value:$percentage
        ;;
    *)
        echo "用法: $0 {up|down}"
        exit 1
        ;;
esac
