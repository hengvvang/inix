#!/usr/bin/env bash
# Hyprland 壁纸切换脚本
# 使用 hyprpaper 管理壁纸

# 壁纸目录
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
# 状态文件，记录当前壁纸索引
STATE_FILE="$HOME/.config/hypr/current_wallpaper_index"

# 确保壁纸目录存在
if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "错误: 壁纸目录 $WALLPAPER_DIR 不存在"
    notify-send "壁纸切换" "壁纸目录不存在: $WALLPAPER_DIR" -i dialog-error
    exit 1
fi

# 获取所有支持的图片文件
mapfile -t WALLPAPERS < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | sort)

# 检查是否有壁纸文件
if [ ${#WALLPAPERS[@]} -eq 0 ]; then
    echo "错误: 在 $WALLPAPER_DIR 中未找到任何图片文件"
    notify-send "壁纸切换" "未找到任何壁纸文件" -i dialog-error
    exit 1
fi

# 读取当前壁纸索引
if [ -f "$STATE_FILE" ]; then
    CURRENT_INDEX=$(cat "$STATE_FILE" 2>/dev/null || echo 0)
else
    CURRENT_INDEX=0
fi

# 验证索引有效性
if ! [[ "$CURRENT_INDEX" =~ ^[0-9]+$ ]] || [ "$CURRENT_INDEX" -ge ${#WALLPAPERS[@]} ]; then
    CURRENT_INDEX=0
fi

# 根据参数决定操作
case "${1:-next}" in
    "next")
        # 切换到下一张壁纸
        CURRENT_INDEX=$(( (CURRENT_INDEX + 1) % ${#WALLPAPERS[@]} ))
        ;;
    "prev")
        # 切换到上一张壁纸
        CURRENT_INDEX=$(( (CURRENT_INDEX - 1 + ${#WALLPAPERS[@]}) % ${#WALLPAPERS[@]} ))
        ;;
    "random")
        # 随机选择壁纸
        CURRENT_INDEX=$((RANDOM % ${#WALLPAPERS[@]}))
        ;;
    *)
        echo "用法: $0 [next|prev|random]"
        exit 1
        ;;
esac

# 获取选择的壁纸
SELECTED_WALLPAPER="${WALLPAPERS[$CURRENT_INDEX]}"
WALLPAPER_NAME=$(basename "$SELECTED_WALLPAPER")

# 应用壁纸使用 hyprpaper
echo "正在应用壁纸: $WALLPAPER_NAME"
if hyprctl hyprpaper reload ",$SELECTED_WALLPAPER"; then
    # 保存当前索引
    mkdir -p "$(dirname "$STATE_FILE")"
    echo "$CURRENT_INDEX" > "$STATE_FILE"
    
    # 发送通知
    notify-send "壁纸已更换" "$WALLPAPER_NAME (${CURRENT_INDEX}/${#WALLPAPERS[@]})" -i image-x-generic -t 2000
    
    echo "壁纸切换成功: $WALLPAPER_NAME (${CURRENT_INDEX}/${#WALLPAPERS[@]})"
else
    echo "错误: 壁纸切换失败"
    notify-send "壁纸切换失败" "无法应用壁纸: $WALLPAPER_NAME" -i dialog-error
    exit 1
fi
