#!/bin/bash

# Mako macOS Tahoe Theme Switcher
# mako macOS Tahoe 风格主题切换脚本
# 支持在深色和浅色主题之间切换

# 配置文件路径
CONFIG_DIR="$HOME/.config/mako"
CONFIG_FILE="$CONFIG_DIR/config"
DARK_THEME="$(dirname "$0")/config"
LIGHT_THEME="$(dirname "$0")/config-light"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 显示帮助信息
show_help() {
    echo -e "${BLUE}Mako macOS Tahoe 主题切换器${NC}"
    echo ""
    echo "用法: $0 [选项]"
    echo ""
    echo "选项:"
    echo "  dark, d     切换到深色主题"
    echo "  light, l    切换到浅色主题"
    echo "  auto, a     根据系统时间自动切换"
    echo "  toggle, t   在深色和浅色主题间切换"
    echo "  status, s   显示当前主题状态"
    echo "  test        发送测试通知"
    echo "  reload, r   重新加载 mako 配置"
    echo "  help, h     显示此帮助信息"
    echo ""
    echo "示例:"
    echo "  $0 dark     # 切换到深色主题"
    echo "  $0 toggle   # 切换主题"
    echo "  $0 auto     # 自动选择主题"
    echo "  $0 test     # 发送测试通知"
    echo ""
    echo "主题文件:"
    echo "  深色主题: $DARK_THEME"
    echo "  浅色主题: $LIGHT_THEME"
    echo "  当前配置: $CONFIG_FILE"
}

# 检查文件是否存在
check_files() {
    local missing_files=()

    if [[ ! -f "$DARK_THEME" ]]; then
        missing_files+=("深色主题文件: $DARK_THEME")
    fi

    if [[ ! -f "$LIGHT_THEME" ]]; then
        missing_files+=("浅色主题文件: $LIGHT_THEME")
    fi

    if [[ ${#missing_files[@]} -gt 0 ]]; then
        echo -e "${RED}错误：缺少必需的主题文件：${NC}"
        for file in "${missing_files[@]}"; do
            echo -e "  ${RED}✗${NC} $file"
        done
        echo ""
        echo -e "${YELLOW}请确保已正确安装 mako macOS Tahoe 主题文件。${NC}"
        exit 1
    fi
}

# 检查 mako 是否运行
check_mako() {
    if ! pgrep -x "mako" > /dev/null; then
        echo -e "${YELLOW}⚠ mako 未运行${NC}"
        echo "请先启动 mako："
        echo "  mako &"
        echo "或在 niri 配置中添加："
        echo "  spawn-at-startup \"mako\""
        return 1
    fi
    return 0
}

# 获取当前主题
get_current_theme() {
    if [[ -f "$CONFIG_FILE" ]]; then
        # 检查配置文件中的背景色特征
        if grep -q "#1d1d1f18" "$CONFIG_FILE"; then
            echo "dark"
        elif grep -q "#f5f5f715" "$CONFIG_FILE"; then
            echo "light"
        else
            echo "unknown"
        fi
    else
        echo "none"
    fi
}

# 应用主题
apply_theme() {
    local theme="$1"
    local theme_file=""
    local theme_name=""
    local icon_theme=""

    case "$theme" in
        "dark")
            theme_file="$DARK_THEME"
            theme_name="深色主题"
            icon_theme="Papirus-Dark"
            ;;
        "light")
            theme_file="$LIGHT_THEME"
            theme_name="浅色主题"
            icon_theme="Papirus-Light"
            ;;
        *)
            echo -e "${RED}错误：未知的主题类型 '$theme'${NC}"
            exit 1
            ;;
    esac

    # 创建配置目录（如果不存在）
    mkdir -p "$CONFIG_DIR"

    # 复制主题文件到配置文件
    if cp "$theme_file" "$CONFIG_FILE"; then
        echo -e "${GREEN}✓${NC} 成功切换到 ${BLUE}$theme_name${NC}"

        # 重新加载 mako 配置
        if check_mako; then
            makoctl reload
            echo -e "${GREEN}✓${NC} mako 配置已重新加载"
        fi

        # 显示主题信息
        echo ""
        echo -e "${BLUE}当前主题特性：${NC}"
        case "$theme" in
            "dark")
                echo "  • 深色毛玻璃背景（极低透明度）"
                echo "  • 浅色文本，适合深色壁纸"
                echo "  • macOS 标准配色方案"
                echo "  • 使用 $icon_theme 图标主题"
                echo "  • 适合夜间和暗环境使用"
                ;;
            "light")
                echo "  • 浅色毛玻璃背景（极低透明度）"
                echo "  • 深色文本，适合浅色壁纸"
                echo "  • 柔和的配色方案"
                echo "  • 使用 $icon_theme 图标主题"
                echo "  • 适合白天和明亮环境使用"
                ;;
        esac

        # 检查图标主题
        check_icon_theme "$icon_theme"

    else
        echo -e "${RED}✗ 切换主题失败${NC}"
        exit 1
    fi
}

# 检查图标主题
check_icon_theme() {
    local icon_theme="$1"
    local icon_paths=(
        "/run/current-system/sw/share/icons/$icon_theme"
        "/usr/share/icons/$icon_theme"
        "$HOME/.local/share/icons/$icon_theme"
        "$HOME/.icons/$icon_theme"
    )

    for path in "${icon_paths[@]}"; do
        if [[ -d "$path" ]]; then
            echo -e "${GREEN}✓${NC} 图标主题 $icon_theme 已找到: $path"
            return 0
        fi
    done

    echo -e "${YELLOW}⚠ 图标主题 $icon_theme 未找到${NC}"
    echo "建议安装 Papirus 图标主题："
    echo "  环境包：papirus-icon-theme"
}

# 显示当前状态
show_status() {
    local current_theme=$(get_current_theme)

    echo -e "${BLUE}Mako 通知主题状态${NC}"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

    # 主题状态
    case "$current_theme" in
        "dark")
            echo -e "当前主题: ${GREEN}macOS Tahoe 深色主题${NC}"
            echo "背景效果: 深色毛玻璃（极低透明度）"
            echo "文字颜色: 浅色文本"
            echo "图标主题: Papirus-Dark"
            echo "适用场景: 深色壁纸，夜间使用"
            ;;
        "light")
            echo -e "当前主题: ${GREEN}macOS Tahoe 浅色主题${NC}"
            echo "背景效果: 浅色毛玻璃（极低透明度）"
            echo "文字颜色: 深色文本"
            echo "图标主题: Papirus-Light"
            echo "适用场景: 浅色壁纸，白天使用"
            ;;
        "unknown")
            echo -e "当前主题: ${YELLOW}自定义主题${NC}"
            echo "检测到配置文件，但不是标准的 macOS Tahoe 主题"
            ;;
        "none")
            echo -e "当前主题: ${RED}未配置${NC}"
            echo "没有找到 mako 配置文件"
            ;;
    esac

    echo ""
    echo -e "${BLUE}配置信息${NC}"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "配置文件: $CONFIG_FILE"
    echo "深色主题: $DARK_THEME"
    echo "浅色主题: $LIGHT_THEME"

    # 检查 mako 状态
    if check_mako; then
        echo -e "Mako 状态: ${GREEN}✓ 正在运行${NC}"

        # 显示当前通知数量
        local notification_count=$(makoctl list | jq length 2>/dev/null || echo "0")
        echo "当前通知: $notification_count 条"
    else
        echo -e "Mako 状态: ${RED}✗ 未运行${NC}"
    fi

    # 检查字体
    if fc-list | grep -qi "LXGW.*WenKai"; then
        echo -e "字体状态: ${GREEN}✓ LXGW WenKai Mono 已安装${NC}"
    else
        echo -e "字体状态: ${YELLOW}⚠ LXGW WenKai Mono 未检测到${NC}"
    fi

    # 检查图标主题
    local current_icon_theme
    case "$current_theme" in
        "dark") current_icon_theme="Papirus-Dark" ;;
        "light") current_icon_theme="Papirus-Light" ;;
        *) current_icon_theme="Papirus" ;;
    esac

    check_icon_theme "$current_icon_theme"
}

# 自动选择主题（根据时间）
auto_theme() {
    local hour=$(date +%H)

    echo -e "${BLUE}根据时间自动选择主题...${NC}"
    echo "当前时间: $(date '+%H:%M')"

    if [[ $hour -ge 6 && $hour -lt 18 ]]; then
        echo "检测到白天时间 (06:00-18:00)，切换到浅色主题"
        apply_theme "light"
    else
        echo "检测到夜间时间 (18:00-06:00)，切换到深色主题"
        apply_theme "dark"
    fi
}

# 切换主题
toggle_theme() {
    local current_theme=$(get_current_theme)

    echo -e "${BLUE}切换主题模式...${NC}"

    case "$current_theme" in
        "dark")
            echo "从深色主题切换到浅色主题"
            apply_theme "light"
            ;;
        "light")
            echo "从浅色主题切换到深色主题"
            apply_theme "dark"
            ;;
        *)
            echo "未检测到标准主题，默认应用深色主题"
            apply_theme "dark"
            ;;
    esac
}

# 发送测试通知
send_test_notifications() {
    if ! check_mako; then
        return 1
    fi

    echo -e "${BLUE}发送测试通知...${NC}"

    # 基础测试通知
    notify-send "macOS Tahoe 主题测试" "这是一个普通优先级的测试通知\n使用 LXGW WenKai Mono 字体显示" &
    sleep 1

    # 低优先级通知
    notify-send -u low "低优先级通知" "这是一个低优先级的通知\n字体较小，颜色较淡" &
    sleep 1

    # 高优先级通知
    notify-send -u critical "重要通知" "这是一个紧急通知\n具有特殊的颜色和样式" &
    sleep 1

    # 系统通知
    notify-send -a "System" "系统通知" "模拟系统级别的通知\n具有蓝色强调色" &
    sleep 1

    # 成功通知
    notify-send "操作成功" "任务已成功完成\n绿色主题表示成功状态" &
    sleep 1

    # 带图标的通知（如果支持）
    if command -v notify-send >/dev/null 2>&1; then
        notify-send -i "dialog-information" "图标测试" "这个通知包含图标\n测试图标主题是否正确加载" &
    fi

    echo -e "${GREEN}✓${NC} 测试通知已发送"
    echo "请检查通知的外观是否符合 macOS Tahoe 风格："
    echo "  • 圆角矩形边框（18px 圆角）"
    echo "  • 毛玻璃半透明背景"
    echo "  • LXGW WenKai Mono 字体"
    echo "  • 合适的颜色对比度"
    echo "  • 应用程序图标显示"
}

# 重新加载配置
reload_config() {
    if check_mako; then
        makoctl reload
        echo -e "${GREEN}✓${NC} mako 配置已重新加载"
    else
        echo -e "${RED}✗${NC} 无法重新加载配置，mako 未运行"
        return 1
    fi
}

# 显示 mako 信息
show_mako_info() {
    echo -e "${CYAN}Mako 实用命令：${NC}"
    echo "  makoctl list          - 列出当前通知"
    echo "  makoctl dismiss       - 关闭最新通知"
    echo "  makoctl dismiss -a    - 关闭所有通知"
    echo "  makoctl history       - 显示通知历史"
    echo "  makoctl reload        - 重新加载配置"
    echo "  makoctl mode          - 显示当前模式"
    echo ""
    echo -e "${CYAN}建议的 niri 快捷键：${NC}"
    echo "  Mod+N                 - 显示通知历史"
    echo "  Mod+Shift+N           - 清除所有通知"
    echo "  Escape                - 关闭当前通知"
}

# 主函数
main() {
    # 检查必需文件
    check_files

    # 解析命令行参数
    case "${1:-help}" in
        "dark"|"d")
            apply_theme "dark"
            ;;
        "light"|"l")
            apply_theme "light"
            ;;
        "auto"|"a")
            auto_theme
            ;;
        "toggle"|"t")
            toggle_theme
            ;;
        "status"|"s")
            show_status
            ;;
        "test")
            send_test_notifications
            ;;
        "reload"|"r")
            reload_config
            ;;
        "info"|"i")
            show_mako_info
            ;;
        "help"|"h"|"")
            show_help
            ;;
        *)
            echo -e "${RED}错误：未知的选项 '$1'${NC}"
            echo ""
            show_help
            exit 1
            ;;
    esac
}

# 检查是否为脚本模式运行
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
