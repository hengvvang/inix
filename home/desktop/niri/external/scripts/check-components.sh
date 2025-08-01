#!/usr/bin/env bash

# ====================================
# Niri 桌面环境组件检查脚本
# 检查所有必要的组件是否正在运行
# ====================================

# 设置颜色
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 检查函数
check_process() {
    local process_name="$1"
    local display_name="$2"
    
    if pgrep -x "$process_name" >/dev/null; then
        echo -e "${GREEN}✓${NC} $display_name 正在运行"
        return 0
    else
        echo -e "${RED}✗${NC} $display_name 未运行"
        return 1
    fi
}

check_service() {
    local service_name="$1"
    local display_name="$2"
    
    if systemctl --user is-active "$service_name" >/dev/null 2>&1; then
        echo -e "${GREEN}✓${NC} $display_name 服务活跃"
        return 0
    else
        echo -e "${RED}✗${NC} $display_name 服务未活跃"
        return 1
    fi
}

# 主检查函数
main() {
    echo -e "${BLUE}======================================"
    echo -e " Niri 桌面环境组件检查"
    echo -e "======================================${NC}"
    echo
    
    local failed=0
    
    # 检查核心组件
    echo -e "${YELLOW}核心组件:${NC}"
    check_process "niri" "Niri 窗口管理器" || ((failed++))
    
    # 检查桌面组件
    echo
    echo -e "${YELLOW}桌面组件:${NC}"
    check_process "waybar" "Waybar 状态栏" || ((failed++))
    check_process "dunst" "Dunst 通知守护进程" || ((failed++))
    check_process "swaybg" "Swaybg 壁纸管理" || ((failed++))
    
    # 检查可选组件
    echo
    echo -e "${YELLOW}可选组件:${NC}"
    check_process "xwayland-satellite" "XWayland Satellite" || echo -e "${YELLOW}!${NC} XWayland Satellite 未运行 (可选)"
    check_process "fuzzel" "Fuzzel 启动器" || echo -e "${YELLOW}!${NC} Fuzzel 未运行 (按需启动)"
    
    # 检查系统服务
    echo
    echo -e "${YELLOW}系统服务:${NC}"
    if systemctl --user list-units --type=service 2>/dev/null | grep -q waybar; then
        check_service "waybar" "Waybar"
    fi
    
    if systemctl --user list-units --type=service 2>/dev/null | grep -q dunst; then
        check_service "dunst" "Dunst"
    fi
    
    # 检查环境变量
    echo
    echo -e "${YELLOW}环境变量:${NC}"
    
    if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
        echo -e "${GREEN}✓${NC} XDG_SESSION_TYPE = wayland"
    else
        echo -e "${RED}✗${NC} XDG_SESSION_TYPE = $XDG_SESSION_TYPE (应为 wayland)"
        ((failed++))
    fi
    
    if [[ "$XDG_CURRENT_DESKTOP" == "niri" ]]; then
        echo -e "${GREEN}✓${NC} XDG_CURRENT_DESKTOP = niri"
    else
        echo -e "${YELLOW}!${NC} XDG_CURRENT_DESKTOP = $XDG_CURRENT_DESKTOP (可能不是 niri)"
    fi
    
    # 显示总结
    echo
    echo -e "${BLUE}======================================${NC}"
    if [[ $failed -eq 0 ]]; then
        echo -e "${GREEN}✓ 所有核心组件运行正常${NC}"
        exit 0
    else
        echo -e "${RED}✗ 发现 $failed 个问题${NC}"
        echo -e "${YELLOW}提示: 可以使用 'systemctl --user restart waybar' 等命令重启服务${NC}"
        exit 1
    fi
}

# 处理命令行参数
case "${1:-}" in
    --help|-h)
        echo "用法: $0 [选项]"
        echo "选项:"
        echo "  --help, -h    显示帮助信息"
        echo "  --quiet, -q   静默模式，只显示错误"
        exit 0
        ;;
    --quiet|-q)
        # 静默模式 - 重定向正常输出
        main 2>&1 | grep -E "✗|错误|失败"
        ;;
    *)
        main
        ;;
esac
