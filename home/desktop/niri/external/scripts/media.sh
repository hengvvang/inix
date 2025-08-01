#!/usr/bin/env bash

# ====================================
# Waybar 媒体播放器状态脚本
# 支持 Spotify, VLC, Firefox 等播放器
# ====================================

# 获取播放器状态
get_player_status() {
    local player_name=""
    local status=""
    local title=""
    local artist=""
    
    # 尝试获取当前播放器信息
    if command -v playerctl >/dev/null 2>&1; then
        # 获取活跃的播放器
        local active_player=$(playerctl -l 2>/dev/null | head -n1)
        
        if [[ -n "$active_player" ]]; then
            player_name="$active_player"
            status=$(playerctl -p "$active_player" status 2>/dev/null)
            title=$(playerctl -p "$active_player" metadata title 2>/dev/null)
            artist=$(playerctl -p "$active_player" metadata artist 2>/dev/null)
        fi
    fi
    
    # 如果没有获取到信息，返回空
    if [[ -z "$status" ]] || [[ "$status" == "Stopped" ]]; then
        echo "{}"
        return
    fi
    
    # 处理标题和艺术家信息
    if [[ -n "$title" ]]; then
        if [[ -n "$artist" ]]; then
            text="$artist - $title"
        else
            text="$title"
        fi
        
        # 限制文本长度
        if [[ ${#text} -gt 35 ]]; then
            text="${text:0:32}..."
        fi
    else
        text="正在播放"
    fi
    
    # 确定播放器类型和图标
    local class="default"
    if [[ "$player_name" == *"spotify"* ]]; then
        class="spotify"
    elif [[ "$player_name" == *"firefox"* ]]; then
        class="firefox"
    elif [[ "$player_name" == *"vlc"* ]]; then
        class="vlc"
    elif [[ "$player_name" == *"mpd"* ]]; then
        class="mpd"
    fi
    
    # 确定状态图标
    local status_icon=""
    case "$status" in
        "Playing")
            status_icon=""
            ;;
        "Paused")
            status_icon=""
            ;;
        *)
            status_icon=""
            ;;
    esac
    
    # 输出 JSON 格式
    cat << EOF
{
    "text": "$text",
    "class": "$class",
    "tooltip": "播放器: $player_name\n状态: $status\n$text",
    "alt": "$status"
}
EOF
}

# 主函数
main() {
    get_player_status
}

# 运行主函数
main
