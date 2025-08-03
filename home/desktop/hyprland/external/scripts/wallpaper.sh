#!/usr/bin/env bash

# ========================================
# Hyprpaper 壁纸切换脚本
# 用法: ./wallpaper.sh [next|prev|random]
# ========================================

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
STATE_FILE="$HOME/.cache/hyprpaper_current"
ACTION="${1:-next}"

# 检查壁纸目录
[ ! -d "$WALLPAPER_DIR" ] && { echo "错误: 壁纸目录不存在"; exit 1; }

# 创建缓存目录
mkdir -p "$(dirname "$STATE_FILE")"

# 查找壁纸文件
WALLPAPERS=($(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" \) | sort))
[ ${#WALLPAPERS[@]} -eq 0 ] && { echo "错误: 没有找到壁纸文件"; exit 1; }

# 读取当前索引
CURRENT_INDEX=0
[ -f "$STATE_FILE" ] && CURRENT_INDEX=$(cat "$STATE_FILE" 2>/dev/null || echo 0)

# 验证索引
[ "$CURRENT_INDEX" -ge "${#WALLPAPERS[@]}" ] || [ "$CURRENT_INDEX" -lt 0 ] && CURRENT_INDEX=0

# 根据操作选择壁纸
case "$ACTION" in
    "next")
        NEW_INDEX=$(( (CURRENT_INDEX + 1) % ${#WALLPAPERS[@]} ))
        ;;
    "prev")
        NEW_INDEX=$(( (CURRENT_INDEX - 1 + ${#WALLPAPERS[@]}) % ${#WALLPAPERS[@]} ))
        ;;
    "random")
        NEW_INDEX=$((RANDOM % ${#WALLPAPERS[@]}))
        # 确保不选择当前壁纸
        [ ${#WALLPAPERS[@]} -gt 1 ] && [ $NEW_INDEX -eq $CURRENT_INDEX ] && NEW_INDEX=$(( (NEW_INDEX + 1) % ${#WALLPAPERS[@]} ))
        ;;
    *)
        echo "用法: $0 [next|prev|random]"
        exit 1
        ;;
esac

SELECTED_WALLPAPER="${WALLPAPERS[$NEW_INDEX]}"
WALLPAPER_NAME=$(basename "$SELECTED_WALLPAPER")

echo "切换到第 $((NEW_INDEX + 1))/${#WALLPAPERS[@]} 张壁纸: $WALLPAPER_NAME"

# 保存新索引
echo "$NEW_INDEX" > "$STATE_FILE"

# 应用壁纸
hyprctl hyprpaper reload ",$SELECTED_WALLPAPER"

# 发送通知
command -v notify-send &> /dev/null && notify-send "壁纸已切换" "第 $((NEW_INDEX + 1))/${#WALLPAPERS[@]} 张: $WALLPAPER_NAME" -t 2000

# 更新waybar显示
pkill -SIGRTMIN+8 waybar 2>/dev/null || true
