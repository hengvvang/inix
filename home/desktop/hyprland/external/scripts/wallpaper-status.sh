#!/usr/bin/env bash

# ========================================
# 获取当前壁纸信息脚本
# ========================================

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
STATE_FILE="$HOME/.cache/hyprpaper_current"

# 获取所有壁纸
WALLPAPERS=($(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" \) | sort))

if [ ${#WALLPAPERS[@]} -eq 0 ]; then
    echo '{"text": "󰸉", "tooltip": "没有找到壁纸", "class": "error"}'
    exit 0
fi

# 读取当前索引
CURRENT_INDEX=0
[ -f "$STATE_FILE" ] && CURRENT_INDEX=$(cat "$STATE_FILE" 2>/dev/null || echo 0)

# 验证索引
[ "$CURRENT_INDEX" -ge "${#WALLPAPERS[@]}" ] || [ "$CURRENT_INDEX" -lt 0 ] && CURRENT_INDEX=0

# 获取当前壁纸信息
CURRENT_WALLPAPER="${WALLPAPERS[$CURRENT_INDEX]}"
WALLPAPER_NAME=$(basename "$CURRENT_WALLPAPER" | sed 's/\.[^.]*$//')

# 截取文件名（如果太长）
if [ ${#WALLPAPER_NAME} -gt 20 ]; then
    WALLPAPER_NAME="${WALLPAPER_NAME:0:17}..."
fi

# 输出JSON格式
cat << EOF
{
    "text": "󰸉",
    "tooltip": "当前壁纸: $WALLPAPER_NAME\n第 $((CURRENT_INDEX + 1))/${#WALLPAPERS[@]} 张\n\n左键: 下一张\n右键: 上一张\n中键: 随机",
    "class": "wallpaper"
}
EOF
