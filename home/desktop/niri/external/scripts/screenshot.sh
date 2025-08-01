#!/usr/bin/env bash

# Niri 截图脚本
# 支持区域、窗口、屏幕截图

SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# 创建截图目录
mkdir -p "$SCREENSHOT_DIR"

case "$1" in
    "area")
        # 区域截图到文件
        grim -g "$(slurp)" "$SCREENSHOT_DIR/area_$TIMESTAMP.png"
        notify-send "截图已保存" "区域截图已保存到 $SCREENSHOT_DIR/area_$TIMESTAMP.png"
        ;;
    "area-to-clipboard")
        # 区域截图到剪贴板
        grim -g "$(slurp)" - | wl-copy
        notify-send "截图已复制" "区域截图已复制到剪贴板"
        ;;
    "window")
        # 当前窗口截图
        grim -g "$(niri msg focused-window | jq -r .geometry | sed 's/[^0-9x+,]//g' | tr ',' ' ' | awk '{print $1 "," $2 " " $3 "x" $4}')" "$SCREENSHOT_DIR/window_$TIMESTAMP.png"
        notify-send "截图已保存" "窗口截图已保存到 $SCREENSHOT_DIR/window_$TIMESTAMP.png"
        ;;
    "window-to-clipboard")
        # 当前窗口截图到剪贴板
        grim -g "$(niri msg focused-window | jq -r .geometry | sed 's/[^0-9x+,]//g' | tr ',' ' ' | awk '{print $1 "," $2 " " $3 "x" $4}')" - | wl-copy
        notify-send "截图已复制" "窗口截图已复制到剪贴板"
        ;;
    "screen")
        # 全屏截图
        grim "$SCREENSHOT_DIR/screen_$TIMESTAMP.png"
        notify-send "截图已保存" "全屏截图已保存到 $SCREENSHOT_DIR/screen_$TIMESTAMP.png"
        ;;
    "screen-to-clipboard")
        # 全屏截图到剪贴板
        grim - | wl-copy
        notify-send "截图已复制" "全屏截图已复制到剪贴板"
        ;;
    *)
        echo "用法: $0 {area|area-to-clipboard|window|window-to-clipboard|screen|screen-to-clipboard}"
        exit 1
        ;;
esac
