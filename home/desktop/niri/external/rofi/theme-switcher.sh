#!/bin/bash

# Rofi macOS Glass Theme Switcher
# rofi macOS 毛玻璃主题切换脚本
# 支持在深色和浅色主题之间切换

# 配置文件路径
CONFIG_DIR="$HOME/.config/rofi"
CONFIG_FILE="$CONFIG_DIR/config.rasi"
DARK_THEME="$CONFIG_DIR/macos-glass-dark.rasi"
LIGHT_THEME="$CONFIG_DIR/macos-glass-light.rasi"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 显示帮助信息
show_help() {
    echo -e "${BLUE}Rofi macOS 毛玻璃主题切换器${NC}"
    echo ""
    echo "用法: $0 [选项]"
    echo ""
    echo "选项:"
    echo "  dark, d     切换到深色主题"
    echo "  light, l    切换到浅色主题"
    echo "  auto, a     根据系统时间自动切换"
    echo "  toggle, t   在深色和浅色主题间切换"
    echo "  status, s   显示当前主题状态"
    echo "  help, h     显示此帮助信息"
    echo ""
    echo "示例:"
    echo "  $0 dark     # 切换到深色主题"
    echo "  $0 toggle   # 切换主题"
    echo "  $0 auto     # 自动选择主题"
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
        echo -e "${YELLOW}请确保已正确安装 rofi macOS 毛玻璃主题文件。${NC}"
        exit 1
    fi
}

# 获取当前主题
get_current_theme() {
    if [[ -f "$CONFIG_FILE" ]]; then
        # 检查配置文件中是否包含深色或浅色主题的特征
        if grep -q "rgba(29, 29, 31" "$CONFIG_FILE"; then
            echo "dark"
        elif grep -q "rgba(245, 245, 247" "$CONFIG_FILE"; then
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

    case "$theme" in
        "dark")
            theme_file="$DARK_THEME"
            theme_name="深色主题"
            ;;
        "light")
            theme_file="$LIGHT_THEME"
            theme_name="浅色主题"
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

        # 显示主题信息
        echo ""
        echo -e "${BLUE}当前主题特性：${NC}"
        case "$theme" in
            "dark")
                echo "  • 深色毛玻璃背景（6% 不透明度）"
                echo "  • 浅色文本，适合深色壁纸"
                echo "  • macOS 标准蓝色强调色"
                echo "  • 适合夜间使用"
                ;;
            "light")
                echo "  • 浅色毛玻璃背景（8% 不透明度）"
                echo "  • 深色文本，适合浅色壁纸"
                echo "  • 蓝色选中效果"
                echo "  • 适合白天使用"
                ;;
        esac
    else
        echo -e "${RED}✗ 切换主题失败${NC}"
        exit 1
    fi
}

# 显示当前状态
show_status() {
    local current_theme=$(get_current_theme)

    echo -e "${BLUE}Rofi 主题状态${NC}"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

    case "$current_theme" in
        "dark")
            echo -e "当前主题: ${GREEN}深色毛玻璃主题${NC}"
            echo "背景色调: 深色透明"
            echo "文字颜色: 浅色"
            echo "适用场景: 深色壁纸，夜间使用"
            ;;
        "light")
            echo -e "当前主题: ${GREEN}浅色毛玻璃主题${NC}"
            echo "背景色调: 浅色透明"
            echo "文字颜色: 深色"
            echo "适用场景: 浅色壁纸，白天使用"
            ;;
        "unknown")
            echo -e "当前主题: ${YELLOW}自定义主题${NC}"
            echo "检测到配置文件，但不是标准的 macOS 毛玻璃主题"
            ;;
        "none")
            echo -e "当前主题: ${RED}未配置${NC}"
            echo "没有找到 rofi 配置文件"
            ;;
    esac

    echo ""
    echo -e "${BLUE}配置信息${NC}"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "配置文件: $CONFIG_FILE"
    echo "深色主题: $DARK_THEME"
    echo "浅色主题: $LIGHT_THEME"

    # 检查字体
    if fc-list | grep -qi "LXGW.*WenKai"; then
        echo -e "字体状态: ${GREEN}✓ LXGW WenKai Mono 已安装${NC}"
    else
        echo -e "字体状态: ${YELLOW}⚠ LXGW WenKai Mono 未检测到${NC}"
    fi

    # 检查图标主题
    if [[ -d "/usr/share/icons/Papirus-Dark" ]] || [[ -d "$HOME/.local/share/icons/Papirus-Dark" ]]; then
        echo -e "图标主题: ${GREEN}✓ Papirus-Dark 已安装${NC}"
    else
        echo -e "图标主题: ${YELLOW}⚠ Papirus-Dark 未检测到${NC}"
    fi
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

# 重启 rofi（如果正在运行）
restart_rofi() {
    if pgrep -x "rofi" > /dev/null; then
        echo ""
        echo -e "${YELLOW}检测到 rofi 正在运行，建议重启以应用新主题${NC}"
        echo "运行以下命令重启 rofi："
        echo "  pkill rofi && rofi -show drun"
    fi
}

# 主函数
main() {
    # 检查必需文件
    check_files

    # 解析命令行参数
    case "${1:-help}" in
        "dark"|"d")
            apply_theme "dark"
            restart_rofi
            ;;
        "light"|"l")
            apply_theme "light"
            restart_rofi
            ;;
        "auto"|"a")
            auto_theme
            restart_rofi
            ;;
        "toggle"|"t")
            toggle_theme
            restart_rofi
            ;;
        "status"|"s")
            show_status
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
