#!/bin/bash
# Dunst 主题切换脚本
# 在深色和浅色主题之间切换

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DUNST_CONFIG_DIR="$HOME/.config/dunst"
DARK_CONFIG="$SCRIPT_DIR/config"
LIGHT_CONFIG="$SCRIPT_DIR/config-light"
CURRENT_CONFIG="$DUNST_CONFIG_DIR/dunstrc"

# 创建配置目录
mkdir -p "$DUNST_CONFIG_DIR"

# 颜色输出函数
print_color() {
    local color=$1
    local message=$2
    case $color in
        "red")    echo -e "\033[31m$message\033[0m" ;;
        "green")  echo -e "\033[32m$message\033[0m" ;;
        "yellow") echo -e "\033[33m$message\033[0m" ;;
        "blue")   echo -e "\033[34m$message\033[0m" ;;
        "purple") echo -e "\033[35m$message\033[0m" ;;
        "cyan")   echo -e "\033[36m$message\033[0m" ;;
        *)        echo "$message" ;;
    esac
}

# 显示标题
show_header() {
    print_color "cyan" "=================================================="
    print_color "cyan" "🎨 Dunst macOS Tahoe 风格主题切换器"
    print_color "cyan" "=================================================="
    echo
}

# 检查当前主题
check_current_theme() {
    if [ -f "$CURRENT_CONFIG" ]; then
        if grep -q "#1d1d1f18" "$CURRENT_CONFIG" 2>/dev/null; then
            echo "dark"
        elif grep -q "#f2f2f720" "$CURRENT_CONFIG" 2>/dev/null; then
            echo "light"
        else
            echo "unknown"
        fi
    else
        echo "none"
    fi
}

# 重新加载 dunst 配置
reload_dunst() {
    if command -v dunstctl >/dev/null 2>&1; then
        if pgrep -x dunst > /dev/null; then
            dunstctl reload
            print_color "green" "✅ Dunst 配置已重新加载"
        else
            print_color "yellow" "⚠️  Dunst 未运行，配置将在下次启动时生效"
        fi
    else
        print_color "yellow" "⚠️  dunstctl 未找到，请手动重启 dunst"
    fi
}

# 发送测试通知
send_test_notification() {
    local theme=$1
    if command -v notify-send >/dev/null 2>&1; then
        notify-send "🎨 主题切换" "已切换到 $theme 主题" -i "preferences-desktop-theme" -u low
    fi
}

# 切换到深色主题
switch_to_dark() {
    if [ -f "$DARK_CONFIG" ]; then
        cp "$DARK_CONFIG" "$CURRENT_CONFIG"
        print_color "blue" "🌙 已切换到深色主题"
        reload_dunst
        send_test_notification "深色"
    else
        print_color "red" "❌ 深色主题配置文件不存在: $DARK_CONFIG"
        exit 1
    fi
}

# 切换到浅色主题
switch_to_light() {
    if [ -f "$LIGHT_CONFIG" ]; then
        cp "$LIGHT_CONFIG" "$CURRENT_CONFIG"
        print_color "yellow" "☀️  已切换到浅色主题"
        reload_dunst
        send_test_notification "浅色"
    else
        print_color "red" "❌ 浅色主题配置文件不存在: $LIGHT_CONFIG"
        exit 1
    fi
}

# 自动主题切换
auto_switch() {
    local system_theme=""

    # 尝试检测 GNOME 主题
    if command -v gsettings >/dev/null 2>&1; then
        local gtk_theme=$(gsettings get org.gnome.desktop.interface gtk-theme 2>/dev/null | tr -d "'")
        local color_scheme=$(gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null | tr -d "'")

        if [[ "$gtk_theme" == *"dark"* ]] || [[ "$color_scheme" == "prefer-dark" ]]; then
            system_theme="dark"
        else
            system_theme="light"
        fi
    fi

    # 尝试检测 KDE 主题
    if [ -z "$system_theme" ] && command -v kreadconfig5 >/dev/null 2>&1; then
        local kde_theme=$(kreadconfig5 --group General --key ColorScheme 2>/dev/null)
        if [[ "$kde_theme" == *"Dark"* ]]; then
            system_theme="dark"
        else
            system_theme="light"
        fi
    fi

    # 根据时间判断（备用方案）
    if [ -z "$system_theme" ]; then
        local hour=$(date +%H)
        if [ "$hour" -ge 18 ] || [ "$hour" -le 6 ]; then
            system_theme="dark"
        else
            system_theme="light"
        fi
    fi

    case "$system_theme" in
        "dark")
            print_color "blue" "🔍 检测到深色系统主题"
            switch_to_dark
            ;;
        "light")
            print_color "yellow" "🔍 检测到浅色系统主题"
            switch_to_light
            ;;
    esac
}

# 主题切换
toggle_theme() {
    local current=$(check_current_theme)
    case "$current" in
        "dark")
            print_color "blue" "🔄 当前为深色主题，切换到浅色"
            switch_to_light
            ;;
        "light")
            print_color "yellow" "🔄 当前为浅色主题，切换到深色"
            switch_to_dark
            ;;
        "none")
            print_color "purple" "🆕 未检测到配置，使用深色主题"
            switch_to_dark
            ;;
        *)
            print_color "red" "❓ 无法识别当前主题，使用深色主题"
            switch_to_dark
            ;;
    esac
}

# 显示当前状态
show_status() {
    local current=$(check_current_theme)
    print_color "cyan" "📊 当前状态："
    echo "   配置目录: $DUNST_CONFIG_DIR"
    echo "   当前配置: $CURRENT_CONFIG"

    case "$current" in
        "dark")  print_color "blue" "   当前主题: 🌙 深色主题" ;;
        "light") print_color "yellow" "   当前主题: ☀️  浅色主题" ;;
        "none")  print_color "red" "   当前主题: ❌ 未配置" ;;
        *)       print_color "red" "   当前主题: ❓ 未知" ;;
    esac

    if pgrep -x dunst > /dev/null; then
        print_color "green" "   Dunst 状态: ✅ 运行中"
    else
        print_color "red" "   Dunst 状态: ❌ 未运行"
    fi
}

# 显示帮助信息
show_help() {
    show_header
    echo "用法: $0 [选项]"
    echo
    print_color "green" "选项："
    echo "  dark     - 切换到深色主题 🌙"
    echo "  light    - 切换到浅色主题 ☀️"
    echo "  auto     - 根据系统主题自动切换 🔍"
    echo "  toggle   - 在深浅主题间切换 🔄"
    echo "  status   - 显示当前状态 📊"
    echo "  test     - 发送测试通知 🧪"
    echo "  help     - 显示此帮助信息 ❓"
    echo
    print_color "cyan" "示例："
    echo "  $0 dark     # 切换到深色主题"
    echo "  $0 toggle   # 切换主题"
    echo "  $0 auto     # 自动检测并切换"
    echo
    print_color "yellow" "提示："
    echo "  • 配置文件位置: $DUNST_CONFIG_DIR/dunstrc"
    echo "  • 支持通过 Ctrl+Space 关闭通知"
    echo "  • 使用 dunstctl 命令控制通知行为"
}

# 发送测试通知
test_notifications() {
    print_color "cyan" "🧪 发送测试通知..."

    if ! command -v notify-send >/dev/null 2>&1; then
        print_color "red" "❌ notify-send 命令未找到"
        return 1
    fi

    # 测试不同优先级的通知
    notify-send "🧪 测试通知" "这是一个普通优先级的测试通知" -u normal
    sleep 1
    notify-send "✅ 成功" "这是一个低优先级的成功通知" -u low
    sleep 1
    notify-send "⚠️ 警告" "这是一个紧急通知测试" -u critical

    print_color "green" "✅ 测试通知已发送"
}

# 主程序
main() {
    case "${1:-help}" in
        "dark")
            show_header
            switch_to_dark
            ;;
        "light")
            show_header
            switch_to_light
            ;;
        "auto")
            show_header
            auto_switch
            ;;
        "toggle")
            show_header
            toggle_theme
            ;;
        "status")
            show_header
            show_status
            ;;
        "test")
            show_header
            test_notifications
            ;;
        "help"|"-h"|"--help")
            show_help
            ;;
        *)
            print_color "red" "❌ 未知选项: $1"
            echo
            show_help
            exit 1
            ;;
    esac
}

# 检查依赖
check_dependencies() {
    local missing_deps=()

    if ! command -v dunst >/dev/null 2>&1; then
        missing_deps+=("dunst")
    fi

    if [ ${#missing_deps[@]} -ne 0 ]; then
        print_color "red" "❌ 缺少依赖: ${missing_deps[*]}"
        print_color "yellow" "请确保已安装 Dunst 通知系统"
        exit 1
    fi
}

# 检查依赖并运行主程序
check_dependencies
main "$@"
